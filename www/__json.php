<?php

require_once '../common.prepend.php';

$json = '';
// $res_ins = new Resource;
// $json = $res_ins->GetResourceJson();

// echo json_encode($json);

$info['emirates'] = GetRows('emirates');
$info['hotlines'] = GetRows('hotlines');
$info['groups'] = GetRows('groups');
echo json_encode($info);
