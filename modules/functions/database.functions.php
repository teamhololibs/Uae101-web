<?php

/**
 * @return instance Database class connection (resource)
 * @param string DB HOST name
 * @param string DB USER name
 * @param string DB PASSWORD name 
 * @param string DB NAME name 
 */
function GetDBInstance($host = false, $user = false, $password = false, $name = false, $slave = false) {
    if ($host === false)
        $host = DB_HOST;

    if ($user === false)
        $user = DB_USER;

    if ($password === false)
        $password = DB_PASS;

    if ($name === false)
        $name = DB_NAME;

    if ($slaves === NULL) {
        $slaves = null; //DB_SLAVE_EXISTS
    }

    return Database::GetInstance($host, $user, $password, $name);
}

/**
 * @return result The result of MySQL query if the such a query was executed
 * @param string query
 */
function ExecuteQuery($qs, $slave = false) {
    $db = GetDBInstance();
    return $db->ExecuteQuery($qs);
}

/**
 * @return string The ID of the last inserted row;
 */
function GetLastInsertId() {
    $db = GetDBInstance();
    return $db->GetLastInsertId();
}

/**
 * @return integer Number of columns for the most recent query
 */
function GetFieldCount() {
    $db = GetDBInstance();
    return $db->GetFieldCount();
}

/**
 * @return array Gets array of data from result of the query
 * @param string query
 */
function GetRowsAsArray($qs, $slave = false) {
    $db = GetDBInstance();
    return $db->GetRowsAsArray($qs, $slave = false);
}

/**
 * @return array Easier and faster querying
 */
function GetRows($table, $where = '', $columns = '*', $slave = false) {
    $db = GetDBInstance();
    return $db->GetRows($table, $where, $columns, $slave);
}

/**
 * @return array Gets associative array of data from result of the query
 * @param string query
 */
function GetRowsAsAssocArray($qs, $slave = false) {
    $db = GetDBInstance();
    return $db->GetRowsAsAssocArray($qs, $slave);
}

/**
 * @return integer Gets the number of rows 
 * @param string Table name
 * @param string Where clause
 * @param string Fields to count
 */
function GetCount($table, $where = '', $field_to_count = '*', $slave = false) {
    $db = GetDBInstance();
    return $db->GetCount($table, $where, $field_to_count, $slave);
}

/**
 * @return integer Gets the minimum of the data set
 * @param string Table name
 * @param string Field to find minimum for
 * @param string Where clause
 */
function GetMin($table, $field, $where = '', $slave = false) {
    $db = GetDBInstance();
    return $db->GetMin($table, $field, $where, $slave);
}

/**
 * @return integer Gets the maximum of the data set
 * @param string Table name
 * @param string Fields to find maximum for
 * @param string Where clause
 */
function GetMax($table, $field, $where = '', $slave = false) {
    $db = GetDBInstance();
    return $db->GetMax($table, $field, $where, $slave);
}

/**
 * @return array Gets row as array when searching for a single field 
 * @param string Table name
 * @param string Field (column) to search
 * @param string Value to search in the field (column) 
 * @param string Fields (columns) to display
 * @param string Additional where clause
 */
function GetRowById($table, $search_field, $search_value, $fields_to_display = '*', $additional_where_clause = '', $slave = false) {
    $db = GetDBInstance();
    return $db->GetRowById($table, $search_field, $search_value, $fields_to_display, $additional_where_clause, $slave);
}

/**
 * @return string Gets info of a row when searching for a single field 
 * @param string Table name
 * @param string Field (column) to search
 * @param string Value to search in the field (column) 
 * @param string Field (column) to display (by default it is the search field)
 * @param string Additional where clause
 */
function GetInfoById($table, $search_field, $search_value, $field_to_display = '', $additional_where_clause = '', $slave = false) {
    $db = GetDBInstance();
    return $db->GetInfoById($table, $search_field, $search_value, $field_to_display, $additional_where_clause, $slave);
}

/**
 * @return string Gets info by column of a table
 * @param string table name
 * @param string column name
 * @param string optional where clause
 */
function GetColumnInfo($table, $column, $where_clause = '', $slave = false) {
    $db = GetDBInstance();
    return $db->GetColumnInfo($table, $column, $where_clause, $slave);
}

/**
 * @return string Gets info of a SINGLE column for any query
 * @param string query
 */
function GetColumnInfoByQuery($qs, $slave = false) {
    $db = GetDBInstance();
    return $db->GetColumnInfoByQuery($qs, $slave);
}

?>
