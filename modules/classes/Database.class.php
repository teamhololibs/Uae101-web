<?php

class Database {

    protected $db_host;
    protected $db_user;
    protected $db_password;
    protected $db_name;
    protected $db_connection;
    protected $use_slave;
    protected $db_host_slave;
    protected $db_user_slave;
    protected $db_password_slave;
    protected $db_name_slave;
    protected $db_connection_slave;
    protected $query;
    protected $result;
    protected $last_insert_id;
    protected $fields_count;
    protected $data = array();
    private static $instance = null;

    public function __construct($host, $user, $password, $name) {
        $this->db_host = $host;
        $this->db_user = $user;
        $this->db_password = $password;
        $this->db_name = $name;

        $this->ConnectDatabase();
        return $this;
    }

    /**
     * Close mysql connection & delete the object.
     */
    public function __destruct() {
        mysqli_close($this->db_connection);
    }

    /**
     * @desc Connects to database
     */
    public function ConnectDatabase() {
        $this->db_connection = mysqli_connect($this->db_host, $this->db_user, $this->db_password, $this->db_name);
        if (mysqli_connect_error()) {
            die('Unable to connect to "<b>' . $this->db_host . "</b>\" due to error #" . mysqli_connect_errno() . ": " . mysqli_connect_error());
        }
    }

    /**
     * @return instance Database class connection (resource)
     * @param Host 
     * @param User
     * @param Password
     * @param Name
     */
    static public function GetInstance($host, $user, $password, $name, $slave = NULL) {

        if (self::$instance) {
            return self::$instance;
        } else {
            self::$instance = new Database($host, $user, $password, $name);
            return self::$instance;
        }
    }

    /**
     * @return result Returns result for a read query
     * @desc Executes MySQL Query
     */
    public function ExecuteQuery($qs) {

        $qs = ltrim($qs);
        if (preg_match("/^(drop|delete)/i", $qs) == true) {
            Log::Write('database', "$qs");
        }
        $this->query = $qs;
        $query_start_time = microtime(true);
        $res = mysqli_query($this->db_connection, $qs);
        $query_end_time = microtime(true);
        if (!$res) {
            echo "<br/><br/>Database Exception in the query: <br/><br/><b>$qs</b><br/><br/>";
            echo mysqli_error($this->db_connection);
            if (TEST_SITE == true) {
                echo "<br/><br/>The error was encountered in: <br/><br/>";
                $backtrace = backtrace();
                echo "<em>File</em>: " . $backtrace['file'];
                echo "<br/><em>Line</em> #" . $backtrace['line'];
            }
            die;
        } else {
            $query_execution_time = $query_end_time - $query_start_time;
            $this->result = $res;
            $this->last_insert_id = mysqli_insert_id($this->db_connection);
            $this->fields_count = mysqli_field_count($this->db_connection);
            if (defined('USE_PQP_PROFILER') && USE_PQP_PROFILER) {
                $backtrace = backtrace();
                $GLOBALS['queries']['count']++;
                $GLOBALS['queries']['list'][] =
                        array("query" => $qs,
                            "time" => $query_execution_time,
                            "backtrace" => $backtrace);
            }
            //if (preg_match("/^select/i", $qs) == true)
            return $this->result;
        }
    }

    /**
     * @return string Database Compatible Escaped String
     * @param string String to be escaped
     */
    public function GetEscapeString($str) {
        return mysqli_real_escape_string($this->db_connection, trim($str));
    }

    public function GetLastInsertId() {
        return $this->last_insert_id;
    }

    /**
     * @return integer Number of columns for the most recent query
     */
    public function GetFieldCount() {
        return $this->fields_count;
    }

    /**
     * @return array Gets array of data from result of the query
     * @param string query
     */
    public function GetRowsAsArray($qs, $slave = false) {
        $res = $this->ExecuteQuery($qs);
        $data = array();

        while ($list = mysqli_fetch_array($res)) {
            $data[] = $list;
        }

        return CheckNull($data);
    }

    /**
     * @return array Easier and faster querying
     */
    public function GetRows($table, $where = '', $columns = '*', $slave = false) {
        if ($where != '') {
            $where = "WHERE $where";
        }
        $qs = "SELECT $columns FROM $table $where";
        return $this->GetRowsAsAssocArray($qs);
    }

    /**
     * @return array Gets associative array of data from result of the query
     * @param string query
     */
    public function GetRowsAsAssocArray($qs, $slave = false) {
        $res = $this->ExecuteQuery($qs);
        $data = array();

        while ($list = mysqli_fetch_assoc($res)) {
            $data[] = $list;
        }

        return CheckNull($data);
    }

    /**
     * @return integer Gets the number of rows 
     * @param string Table name
     * @param string Where clause
     * @param string Fields to count
     */
    public function GetCount($table, $where = '', $field_to_count = '*', $slave = false) {
        if ($where != '')
            $where = " WHERE " . $where;
        $qs = "SELECT count($field_to_count) count FROM $table $where";
        $data = $this->GetRowsAsAssocArray($qs);

        if ($data == NULL)
            return 0;
        else
            return $data[0]['count'];
    }

    /**
     * @return integer Gets the minimum of the data set
     * @param string Table name
     * @param string Field to find minimum for
     * @param string Where clause
     */
    public function GetMin($table, $field, $where = '', $slave = false) {
        if ($where != '')
            $where = " WHERE " . $where;
        $qs = "SELECT MIN($field) min FROM $table $where";
        $data = $this->GetRowsAsAssocArray($qs);

        return $data[0]['min'];
    }

    /**
     * @return integer Gets the maximum of the data set
     * @param string Table name
     * @param string Fields to find maximum for
     * @param string Where clause
     */
    public function GetMax($table, $field, $where = '', $slave = false) {
        if ($where != '')
            $where = " WHERE " . $where;
        $qs = "SELECT MAX($field) max FROM $table $where";
        $data = $this->GetRowsAsAssocArray($qs);

        return $data[0]['max'];
    }

    /**
     * @return array Gets row as array when searching for a single field 
     * @param string Table name
     * @param string Field (column) to search
     * @param string Value to search in the field (column) 
     * @param string Fields (columns) to display
     * @param string Additional where clause
     */
    public function GetRowById($table, $search_field, $search_value, $fields_to_display = '*', $additional_where_clause = '', $slave = false) {
        if ($additional_where_clause != '') {
            $additional_where_clause = " AND $additional_where_clause ";
        }
        $qs = "SELECT $fields_to_display FROM $table WHERE $search_field = '$search_value' $additional_where_clause ";
        $data = $this->GetRowsAsAssocArray($qs);

        return $data[0];
    }

    /**
     * @return string Gets info of a row when searching for a single field 
     * @param string Table name
     * @param string Field (column) to search
     * @param string Value to search in the field (column) 
     * @param string Field (column) to display (by default it is the search field)
     * @param string Additional where clause
     */
    public function GetInfoById($table, $search_field, $search_value, $field_to_display = '', $additional_where_clause = '', $slave = false) {
        if ($field_to_display == '') {
            $field_to_display = $search_field;
        }
        if ($additional_where_clause != '') {
            $additional_where_clause = " AND $additional_where_clause ";
        }
        $qs = "SELECT $field_to_display FROM $table WHERE $search_field = '$search_value' $additional_where_clause ";
        $data = $this->GetRowsAsAssocArray($qs);

        return $data[0][$field_to_display];
    }

    /**
     * @return string Gets info by column of a table
     * @param string table name
     * @param string column name
     * @param string optional where clause
     */
    public function GetColumnInfo($table, $column, $where_clause = '', $slave = false) {
        $qs = "SELECT $column FROM $table WHERE $where_clause ";
        $rows = $this->GetRowsAsAssocArray($qs);
        $data = array();
        foreach ($rows as $row) {
            $data[] = $row[$column];
        }
        return $data;
    }

    /**
     * @return string Gets info of a SINGLE column for any query
     * @param string query
     */
    public function GetColumnInfoByQuery($qs, $slave = false) {
        $rows = $this->GetRowsAsArray($qs);
        $data = array();
        foreach ($rows as $row) {
            $data[] = $row[0];
        }
        return $data;
    }

}

?>
