<?php

/**
 *
 * @param array $students
 * @param integer $course_id
 */
function setCourseStudents ( $students, $course_id ) {
    global $db;
	if( is_array($students) && isset($students) && !is_null($course_id) ) {
	    // mevcut kişileri pasif yaparak, hepsine bir ders hakkı ekliyoruz
	    $sql = "SELECT TOCODE FROM RELATIONS WHERE FROMMODULE = 'courses' AND FROMCODE = '".$id."' AND OP = '1'";
	    $students = $db->getAll($sql,null,null,null,MDB2_FETCHMODE_ASSOC);
	    foreach ($students as $val){
	        $query = "UPDATE CMDB SET LEVEL = LEVEL + 1 WHERE CONTACTCODE = '".$val["TOCODE"]."'";
	        $db->query( $query );
	    }

	    $updateSql = "UPDATE RELATIONS SET OP = '0' WHERE FROMMODULE = 'courses' AND FROMCODE = '".$course_id."'"; // önceki dataları pasife çekiyoruz OP = '0' olarak
	    $db->query( $updateSql );
	    foreach ( $students as $student ){
	       setRelation("courses", $course_id, "xusrinf", $student, "attended", "1", ""); // yeni dataları kaydediyoruz
	       $query = "UPDATE CMDB SET LEVEL = LEVEL - 1 WHERE CONTACTCODE = '".$student."'"; // derse katılanların bir dersini düşüyoruz
	       $db->query( $query );
	    }
	}
}

/**
 *
 * @param string $fromModule
 * @param string $fromCode
 * @param string $toModule
 * @param string $toCode
 * @param string $resultCode
 * @param integer $op
 * @param string $desc
 */
function setRelation($fromModule, $fromCode, $toModule, $toCode, $resultCode, $op, $desc){
    $relArray['rels_fromcode'] = $fromCode;
    $relArray['rels_frommodule'] = $fromModule;
    $relArray['rels_tocode'] = $toCode;
    $relArray['rels_tomodule'] = $toModule;
    $relArray['rels_resultcode'] = $resultCode;
    $relArray['rels_op'] = $op;
    $relArray['rels_description'] = $desc;
    //$relArray['rels_iuser'] = $_this->data['user'];
    $relId = AddRecord('rels','', $relArray,$_SESSION['SES_PROFILE'],'de');
}