<?php

require_once '../admin.common.prepend.php';

$admin = Adminuser::GetInstance();

define('NONE', false);

PreparePage(array( 
    'title' => SITE_NAME, // Required 
    'page_type' => '', // Required 
    'page_action' => '', // Optional
    'page_heading' => 'Welcome ' . $admin->GetAdminName(), // Required 
));

echo "Welcome!<br/><br/>";

//var_dump($_GET);

footer();
?>
