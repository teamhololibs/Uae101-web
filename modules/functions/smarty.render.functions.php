<?php

/**
 * @param MAIN_CONTENT - html page rendered using Smarty fetch method
 * @desc Renders the whole page along with the main content in the middle
 */
function RenderPage($MAIN_CONTENT) {

    $tpl = new Smarty;

    $user = new User();
    $tpl->assign('USER_LOGGED_IN', $user->IsUserLoggedIn());
    $tpl->assign('USER_ID', $user->GetUserID());
    $tpl->assign('USERNAME', $user->GetUserUsername());
    $tpl->assign('USER_EMAIL', $user->GetUserEmail());
    $tpl->assign('USER_INFORMATION', $user->GetUserInformation());

    switch ($GLOBALS['selected_page']) {
        case '':
        case '/':
            $page = "TAGS";
            break;
        case 'REGISTER':
            $page = "REGISTER";
            break;
        case 'DUMMY':
            $page = "DUMMY";
            break;
        default:
            $page = "TAGS";
    }
    $tpl->assign("SELECTED_$page", "selected");

    if (IsUserLoggedIn())
        $tpl->assign('USER_INFORMATION_OR_LOGIN_AREA', GetUserInformationArea());
    else
        $tpl->assign('USER_INFORMATION_OR_LOGIN_AREA', GetUserLogin());

    $tpl->assign('PAGE_TITLE', $GLOBALS['page_title']);
    $tpl->assign('MAIN_CONTENT', $MAIN_CONTENT);

    if (defined('USE_PQP_PROFILER') && USE_PQP_PROFILER)
        $_SESSION['PQP_SHOW'] = true;

    return $tpl->fetch('main.tpl');
}

/**
 * @return array 
 * @desc Mainly used for db queries debuging. Returns an array with the line and file where the query was executed
 */
function backtrace() {
    $backtrace = debug_backtrace();
    $return_data = array();
    for ($level = 0; $level < count($backtrace); $level++) {
        if (!preg_match("/(database.(\w)*.php)/i", $backtrace[$level]['file'])) {
            $return_data['file'] = $backtrace[$level]['file'];
            $return_data['line'] = $backtrace[$level]['line'];
            break;
        }
    }
    return $return_data;
}

function MainSearchPage() {
    $tpl = new Smarty;
    GetRowsAsAssocArray("select * from users");
    $res = $tpl->fetch('searching/main.page.search.tpl');

    return RenderPage($res);
}

function ValidateFileExistsFromUrl($url) {
    $file_url = explode("?", $url);
    $file_name = $file_url[0];
    $file_exists = ValidateFileExists("../" . WEB_DIRECTORY . $file_name);
    return $file_exists;
}

function ValidateFileExists($name) {
    return file_exists($name);
}

function GetCurrentFilename() {
    $_SESSION['d']->dump($_SERVER);
    echo __FILE__;
}

function GetEncodedCurrentUrl() {
    return rawurlencode($_SERVER['REQUEST_URI']);
}

function GetUrlEncodedValue($name) {
    return rawurlencode($name);
}

function GetUrlDecodedValue($name) {
    return rawurldecode($name);
}

/**
 * @desc Back Up the database and save it in a .sql file with the current time stamp as name for future reference
 * @return nil sql file 
 */
function BackUpAndDownloadDatabase() {
    SaveDbToClient(SaveDbToServer());
}

function SaveDbToClient($full_filepath) {

    /*
      //Not used

      $packets = 0;
      if (FALSE !== ($handler = fopen($full_filepath, 'r'))) {
      header('Content-Description: File Transfer');
      header('Content-Type: application/octet-stream');
      header('Content-Disposition: attachment; filename=' . basename($full_filepath));
      header('Content-Transfer-Encoding: chunked'); //changed to chunked
      header('Expires: 0');
      header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
      header('Pragma: public');
      //header('Content-Length: ' . filesize($file)); //Remove
      //Send the content in chunks
      while (false !== ($chunk = fread($handler, 4096))) {
      $packets++;
      echo $chunk;
      //die(var_dump($chunk));
      }
      die;
      exit;
      } else
      echo "error";
      fclose($handler);
     */

    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename=' . basename($full_filepath));
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    header('Content-Length: ' . filesize($full_filepath));
    ob_clean();
    flush();
    readfile($full_filepath);
}

function SaveDbToServer() {

    ini_set('max_execution_time', 0);

    $tables = GetColumnInfoByQuery('SHOW TABLES');
    $return = "";
    foreach ($tables as $table) {
        $result = ExecuteQuery("SELECT * FROM $table");
        $num_fields = GetFieldCount();

        $row2 = GetRowsAsArray('SHOW CREATE TABLE ' . $table);
        $return.= 'DROP TABLE IF EXISTS ' . $table . ';';
        $return.= "\n\n" . $row2[0][1] . ";\n\n";

        for ($i = 0; $i < $num_fields; $i++) {
            while ($row = mysqli_fetch_row($result)) {
                $return.= 'INSERT INTO ' . $table . ' VALUES(';
                for ($j = 0; $j < $num_fields; $j++) {
                    $row[$j] = addslashes($row[$j]);
                    $row[$j] = str_replace("\n", "\\n", $row[$j]);
                    if (isset($row[$j])) {
                        $return.= '"' . $row[$j] . '"';
                    } else {
                        $return.= '""';
                    }
                    if ($j < ($num_fields - 1)) {
                        $return.= ',';
                    }
                }
                $return.= ");\n";
            }
        }
        $return.="\n\n\n";
    }

    //save file
    
    $name = SITE_NAME . '-BackUp-' . date('m-d-Y') . "-at-" . date('H.i') . "hrs.sql";
    $full_filepath = SERVER_PATH . "/db_backups/" . $name;
    $handle = fopen($full_filepath, 'w+');

    //echo "The name and complete path of the latest back up file is ";
    //echo "<br/><br/>$full_filepath<br/><br/>";

    fwrite($handle, $return);
    fclose($handle);
    
    return $full_filepath;
}

function Logout() {

    // unset cookies
    if (isset($_SERVER['HTTP_COOKIE'])) {
        $cookies = explode(';', $_SERVER['HTTP_COOKIE']);
        foreach ($cookies as $cookie) {
            $parts = explode('=', $cookie);
            $name = trim($parts[0]);
            //setcookie($name, '', time() - 1000);
            setcookie($name, '', time() - 1000, '/');
        }
    }

    unset($_SESSION);
    session_destroy();
}

function ClearConfirmationMessage() {
    unset($_SESSION['confirmation_message']);
}

function SetConfirmationMessage($message, $type = '') {
    $_SESSION['confirmation_message']['message'] = $message;
    $_SESSION['confirmation_message']['type'] = $type;
}

/**
 * @return string DB compatible string
 * @param string String to be escaped
 */
function TextToDB($str) {
    $db = GetDBInstance();
    return $db->GetEscapeString($str);
}

/**
 * @return string DB compatible string
 * @param string String to be escaped
 */
function TextFromDB($str) {
    return stripcslashes($str);
}

/**
 * @return string_or_bool Hashed Password, or bool if second parameter is specified
 * @param string password to be hashed
 * @param string hashed password for verification
 */
function HashPassword($password, $hashed_password = '') {

    if ($hashed_password == '') {
        $salt = substr(hash('sha512', uniqid()), 0, 22);
        $hashed_pass = crypt($password, '$2a$10$' . $salt . '$');
        return $hashed_pass;
    } else {
        $password_validation = (crypt($password, $hashed_password) === $hashed_password) ? true : false;
        return $password_validation;
    }
}

/**
 * @return bool Data as is if not NULL
 * @param data Data to check
 */
function CheckNull($data) {
    if (is_null($data) || count($data) == 0) {
        return NULL;
    } else {
        return $data;
    }
}

function MultiDimensionalArraySort(&$array, $subkey, $sortType = SORT_ASC) {
    $keys = array();
    foreach ($array as $subarray) {
        $keys[] = $subarray[$subkey];
    }
    array_multisort($keys, $sortType, $array);
}

?>
