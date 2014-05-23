<?php

$page_load_time = microtime(true);

$file_path = dirname(__FILE__) . '/';

session_start();

require_once "$file_path/config." . $_SERVER['HTTP_HOST'] . ".php";

// Define in config.php
if (!defined('CATEGORY_TREE_SESSION_FLAG'))
    define('CATEGORY_TREE_SESSION_FLAG', false); // 3 hours
if (!defined('CATEGORY_TREE_SESSION_TIMEOUT'))
    define('CATEGORY_TREE_SESSION_TIMEOUT', 10800); // 3 hours
// ^ Define in config.php

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

foreach ($db_details as $key => $value) {
    if (!defined($key)) {
        define(strtoupper($key), $value);
    }
}

/*
  if (!isset($TEST_SITE) || !$TEST_SITE) {
  ini_set('display_errors', '0');
  error_reporting(E_ALL && ~E_STRICT && ~E_NOTICE);
  //error_log($file_path)
  } else {
  error_reporting(E_ALL ^ E_NOTICE ^ E_WARNING);
  }
 */

define('DB_SLAVE_EXISTS', false);

// SMARTY variables
if (!defined('SMARTY_TEMPLATES_CACHING'))
    define('SMARTY_TEMPLATES_CACHING', FALSE);
if (!defined('SMARTY_TEMPLATES_DIR'))
    define('SMARTY_TEMPLATES_DIR', "$file_path/templates/");
if (!defined('SMARTY_TEMPLATES_C_DIR'))
    define('SMARTY_TEMPLATES_C_DIR', "$file_path/templates_c/");
if (!defined('SMARTY_CONFIG_DIR'))
    define('SMARTY_CONFIG_DIR', "$file_path/configs/");
if (!defined('SMARTY_DEBUGGING'))
    define('SMARTY_DEBUGGING', false);
if (!defined('SMARTY_DEBUGGING_CTRL'))
    define('SMARTY_DEBUGGING_CTRL', 'NONE'); // or 'NONE'
if (!defined('SMARTY_CACHING'))
    define('SMARTY_CACHING', false);
//define('SMARTY_CACHE_DIR', "$file_path/cache/smarty_cache/");


$classes_path = "modules/classes";
$functions_path = "modules/functions";
$plugins_path = "modules/plugins";
$admin_path = "admin";

$files = array(
    "$classes_path/Category.class.php",
    "$classes_path/Config.class.php",
    "$classes_path/Database.class.php",
    "$classes_path/Letter.class.php",
    "$classes_path/Log.class.php",
    "$classes_path/Resource.class.php",
    "$classes_path/SmartyCustom.class.php",
    "$functions_path/access.functions.php",
    "$functions_path/database.functions.php",
    "$functions_path/overall.functions.php",
    "$functions_path/php.functions.php",
    "$functions_path/task.functions.php",
    "$functions_path/smarty.render.functions.php"
    //"$plugins_path/lightopenid/openid.php"
    //"/www/Google/Client.php"
);

foreach ($files as $file) {
    require_once "$file_path/$file";
}
?>
