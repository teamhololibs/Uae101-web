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

echo "\"Argh! I'm telling you! This page doesn't exist!\"<br/><br/>";
echo "\"Doesn't exist? Or am I not allowed to see?\"<br/><br/>";
echo "\"I don't know dude, just.. Try again..\"<br/><br/>";

footer();
?>
