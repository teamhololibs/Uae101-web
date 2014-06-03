<?php

require_once '../common.prepend.php';

$json = '';
if (!isset($_GET['ajax']) || $_GET['ajax'] != '1') {
    $json = RenderPage(SubmitLibrary());
} else {
    $json = SubmitLibrary();
}

echo $json;