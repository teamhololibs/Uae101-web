<?php

require_once '../common.prepend.php';

$html = '';
if (!isset($_POST['category_name']) || $_POST['category_name'] != '1') {
    $html = GetLeftMenu();
}
echo $html;