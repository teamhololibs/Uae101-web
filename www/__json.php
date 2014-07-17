<?php

require_once '../common.prepend.php';
//
//$json = '';
//$res_ins = new Resource;
//$json = $res_ins->GetResourceJson();
//
//echo json_encode($json);

//$info['emirates'] = GetRows('emirates');
//$info['hotlines'] = GetRows('hotlines');
//$info['groups'] = GetRows('groups');
//echo json_encode($info);

?>{"emirates":[{"emirate_id":"1","name":"Abu Dhabi","shortform":"AD"},{"emirate_id":"2","name":"Dubai","shortform":"DXB"},{"emirate_id":"3","name":"Sharjah","shortform":"SHJ"},{"emirate_id":"4","name":"Ajman","shortform":"AJM"},{"emirate_id":"5","name":"Ras Al Khaimah","shortform":"RAK"},{"emirate_id":"6","name":"Umm Al Quwain","shortform":"UAQ"},{"emirate_id":"7","name":"Fujairah","shortform":"FUJ"}],"hotlines":[{"_id":"1","active":"1","emirate_id":"3","group_id":"4","hotline_name":"AUH Police","hotline_number":"02-999"},{"_id":"2","active":"1","emirate_id":"2","group_id":"1","hotline_name":"Dubai Police","hotline_number":"04-999"},{"_id":"3","active":"1","emirate_id":"3","group_id":"1","hotline_name":"Shj Police","hotline_number":"06-999"},{"_id":"4","active":"1","emirate_id":"4","group_id":"1","hotline_name":"Ajman Poice","hotline_number":"07-999"},{"_id":"5","active":"1","emirate_id":"1","group_id":"2","hotline_name":"AUH Fire","hotline_number":"02-991"},{"_id":"6","active":"1","emirate_id":"2","group_id":"2","hotline_name":"Dxb fire","hotline_number":"04-991"},{"_id":"7","active":"1","emirate_id":"3","group_id":"2","hotline_name":"Shj Fire","hotline_number":"06-991"},{"_id":"8","active":"1","emirate_id":"1","group_id":"3","hotline_name":"AD Ambulance","hotline_number":"02-997"},{"_id":"9","active":"1","emirate_id":"2","group_id":"3","hotline_name":"Dxb ambulance","hotline_number":"04-997"},{"_id":"10","active":"1","emirate_id":"2","group_id":"4","hotline_name":"Dxb Hospital","hotline_number":"04-99877"}],"groups":[{"_id":"1","active":"1","group_name":"Police"},{"_id":"2","active":"1","group_name":"Fire"},{"_id":"3","active":"1","group_name":"Ambulance"},{"_id":"4","active":"1","group_name":"Hospitals"}]}