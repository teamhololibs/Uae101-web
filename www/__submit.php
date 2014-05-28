<?php

require_once '../common.prepend.php';

$html = '';
if (!isset($_GET['ajax']) || $_GET['ajax'] != '1') {
    $html = RenderPage(SubmitLibrary());
} else {
    $html = SubmitLibrary();
}

echo $html;