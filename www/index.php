<?php

require_once '../common.prepend.php';
//
//$rows = GetRows("resources");
//foreach ($rows as $row){
//    $desc = TextToDB(substr($row['description'], 0, 200));
//    $qs = "UPDATE resources SET description = '$desc' WHERE resource_id = {$row['resource_id']}";
//    ExecuteQuery($qs);
//}

$json = '';
if (!isset($_GET['ajax']) || $_GET['ajax'] != '1') {
    $json = RenderPage(ResourcesPage());
} else {
    $json = ResourcesPage();
}

echo $json;
?>
