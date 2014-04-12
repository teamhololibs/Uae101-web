<?php
define('CHECK_IF_LOGGED_IN', false);
require_once '../admin.common.prepend.php';

Logout();

header("Location: login.php?" . $_SERVER['QUERY_STRING']);
