<?php

require_once '../common.prepend.php';
//
//$rows = GetRows("resources");
//foreach ($rows as $row){
//    $desc = TextToDB(substr($row['description'], 0, 200));
//    $qs = "UPDATE resources SET description = '$desc' WHERE resource_id = {$row['resource_id']}";
//    ExecuteQuery($qs);
//}

$html = '';

if (count($_GET) == 0) {
    GetDisplayStyle('cards');
} elseif (isset($_GET['style']) && $_GET['style'] != '') {
    GetDisplayStyle($_GET['style']);
}

if (!isset($_GET['ajax']) || $_GET['ajax'] != '1') {
    $data = ResourcesPage();
    $html = RenderPage($data['data']);
} else {
    $html = ResourcesPage();
    $html = json_encode($html);
}

echo $html;
