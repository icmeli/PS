<?php

/**
 *
 * @param array $students
 * @param integer $course_id
 */
function setCourseStudents ( $students, $course_id ) {
    global $db;
	if( is_array($students) && isset($students) && !is_null($course_id) ) {
	    $updateSql = "UPDATE RELATIONS SET OP = '0' WHERE FROMMODULE = 'courses' AND FROMCODE = '".$course_id."'"; // önceki dataları pasife çekiyoruz OP = '0' olarak
	    $db->query( $updateSql );
	    foreach ( $students as $student ){
	       setRelation("courses", $course_id, "xusrinf", $student, "attended", "1", ""); // yeni dataları kaydediyoruz
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