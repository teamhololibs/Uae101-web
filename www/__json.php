<?php

require_once '../common.prepend.php';

$json = '';
$res_ins = new Resource;
$json = $res_ins->GetResourceJson();

echo json_encode($json);
