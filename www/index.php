<?php

require_once '../common.prepend.php';

$html = '';
if( !isset($_GET['ajax']) || $_GET['ajax'] != '1'){
    $html = RenderPage(ResourcesPage());
} else {
    $html = ResourcesPage();
}

echo $html;
?>
