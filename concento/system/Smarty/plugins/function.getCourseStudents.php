<?php
function smarty_function_getCourseStudents($params, $smarty) {

	global $db;
	$id = (int)$params["id"];

	$sql = "SELECT TOCODE FROM RELATIONS WHERE FROMMODULE = 'courses' AND FROMCODE = '".$id."' AND OP = '1'";
	$students = $db->getAll($sql,null,null,null,MDB2_FETCHMODE_ASSOC);

	$first = true;
	$stu = "";
	foreach ($students as $val){
		if($first){
		   $stu = $val["TOCODE"];
		   $first = false;
		} else {
	       $stu .= ",".$val["TOCODE"];
		}
	}

	$smarty->assign("students", $stu);
}
?>