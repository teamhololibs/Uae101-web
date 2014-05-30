<?php

$page_load_time = microtime(true);

$file_path = dirname(__FILE__) . '/';

define('LOGIN_SESSION_TIMEOUT', 1800); // 30 mins

session_start();

require_once "$file_path/config." . $_SERVER['HTTP_HOST'] . ".php";

if (!defined('TEST_SITE'))
    define('TEST_SITE', $TEST_SITE);

if (!defined('WEB_DIRECTORY'))
    define('WEB_DIRECTORY', $WEB_DIRECTORY);

if (!defined('SERVER_PATH'))
    define('SERVER_PATH', $SERVER_PATH);

if (!defined('PIC_PATH'))
    define('PIC_PATH', $PIC_PATH);

if (!defined('SITE_NAME'))
    define('SITE_NAME', $SITE_NAME);

if (!defined('GIT_CURL_USERAGENT_HEADER'))
    define('GIT_CURL_USERAGENT_HEADER', "teamhololibs");

foreach ($db_details as $key => $value) {
    if (!defined($key)) {
        define(strtoupper($key), $value);
    }
}

if (!isset($TEST_SITE) || !$TEST_SITE) {
    ini_set('display_errors', '0');
    error_reporting(E_ALL && ~E_STRICT && ~E_NOTICE);
    //error_log($file_path)
} else {
    error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
}

define('DB_SLAVE_EXISTS', false);

$classes_path = "modules/classes";
$functions_path = "modules/functions";
$admin_path = "admin";

$files = array(
    "$classes_path/Adminuser.class.php",
    "$classes_path/Author.class.php",
    "$classes_path/Config.class.php",
    "$classes_path/Category.class.php",
    "$classes_path/Database.class.php",
    "$classes_path/Letter.class.php",
    "$classes_path/Log.class.php",
    "$classes_path/Resource.class.php",
    "$functions_path/access.functions.php",
    "$functions_path/admin.functions.php",
    "$functions_path/database.functions.php",
    "$functions_path/overall.functions.php",
    "$functions_path/php.functions.php",
    "$functions_path/task.functions.php"
);

foreach ($files as $file) {
    require_once "$file_path/$file";
}

if(!defined('CHECK_IF_LOGGED_IN')){
    define('CHECK_IF_LOGGED_IN', false);
}

if (CHECK_IF_LOGGED_IN) {
    //echo '1';
    Adminuser::GetInstance();
}

?>
