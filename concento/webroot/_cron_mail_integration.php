<?php
// Doğru config'in set edilebilmesi için Bileşim firmasını session'a yazıyoruz.
session_start();
$_SESSION['SES_COMPANY'] = 'ZS';

//config files
require  dirname(dirname(dirname(dirname(__FILE__)))).DIRECTORY_SEPARATOR.'concento'.DIRECTORY_SEPARATOR.'core'.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'config.php';

//Bootstrap
require  dirname(dirname(dirname(dirname(__FILE__)))).DIRECTORY_SEPARATOR.'concento'.DIRECTORY_SEPARATOR.'core'.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'bootstrap.php';

global $db;

$xcmp = "ZS";
$user = "zsmail";

loginServiceUser($xcmp, $user);

function parsepart_inner($p,$i,$arrayNo){
    global $link,$msgid,$partsarray;
    //where to write file attachments to:
    //fetch part
    $part = imap_fetchbody($link,$msgid,$i);
    //if type is not text
    if ($p->type!=0){
        //DECODE PART        
        //decode if base64
        if ($p->encoding==3)$part=base64_decode($part);
        //decode if quoted printable
        if ($p->encoding==4)$part=quoted_printable_decode($part);
        //no need to decode binary or 8bit!
        
        //get filename of attachment if present
        $filename='';
        // if there are any dparameters present in this part
        if (count($p->dparameters)>0){
            foreach ($p->dparameters as $dparam){
                if ((strtoupper($dparam->attribute)=='NAME') ||(strtoupper($dparam->attribute)=='FILENAME')) $filename=$dparam->value;
//				print_r($dparam);
                }
            }
        //if no filename found
        if ($filename==''){
            // if there are any parameters present in this part
            if (count($p->parameters)>0){
                foreach ($p->parameters as $param){
                    if ((strtoupper($param->attribute)=='NAME') ||(strtoupper($param->attribute)=='FILENAME')) $filename=$param->value;
//					print_r($filename);
				}
			}
		}
        //write to disk and set partsarray variable
		if ($filename!=''){
			$filename2 = imap_mime_header_decode($filename);
			$filename = "";
			foreach($filename2 as $key=>$val) {

				if (strtolower($val->charset) != "UTF-8" && trim(strtolower($val->charset)) != ""&& trim(strtolower($val->charset)) != "default") {
					$filename .= mb_convert_encoding($val->text,"UTF-8",trim($val->charset));
				} else {
					$filename .= $val->text;
				}
			}
//			print_r($filename);
            //$partsarray[$arrayNo]["attachment"][] = array('filename'=>$filename,'binary'=>base64_encode($part));
		}
    //end if type!=0        
    }
    
    //if part is text
    else if($p->type==0){
        //decode text
        //if QUOTED-PRINTABLE
        if ($p->encoding==4) $part=quoted_printable_decode($part);
        //if base 64
        if ($p->encoding==3) $part=base64_decode($part);
        
        //OPTIONAL PROCESSING e.g. nl2br for plain text
        //if plain text

		if (strtolower($p->parameters[0]->attribute) == "charset") {
			if (strtolower($p->parameters[0]->value) != "UTF-8" && trim(strtolower($p->parameters[0]->value)) != "") {
				// echo "XXXXXXXXXXXXXXXXX--";
				// echo strtoupper($p->parameters[0]->value);
				// echo "<br>\n";
				if(strtoupper($p->parameters[0]->value)=="X-UNKNOWN")
				{
					$p->parameters[0]->value="auto";
				}
				$part = mb_convert_encoding($part,"UTF-8",strtoupper($p->parameters[0]->value));
			}
		}
        if (strtoupper($p->subtype)=='PLAIN') {
 //       if (strtoupper($p->subtype)=='PLAIN') {
	        $partsarray[$arrayNo]["PLAIN"] .= $part;
		} else if (strtoupper($p->subtype)=='HTML') {
	        $partsarray[$arrayNo]["HTML"] .= $part;
		}
    }
    
    //if subparts... recurse into function and parse them too!
    if (count($p->parts)>0){
        foreach ($p->parts as $pno=>$parr){
	        parsepart_inner($parr,($i.'.'.($pno+1)),$arrayNo);            
	    }
    }
    
    return true;
}

function addAttachment_inner($callID, $data, $name, $desc = '') {

	global $ATC_ARRAY, $doc_root, $db;
	
	$dot_pos = strrpos($name, ".");
	
	$ext = substr($name, $dot_pos, strlen($name) - $dot_pos);
	$ext2 = substr($ext,1);

	$blockedext = explode(",",GP("blockedattachext"));
	if (in_array($ext2,$blockedext)) {
		echo "Blocked File Extention ".$name;
		return -1;
	}

	$path = GP("attachpath");

	if ($path == "") {
		$path = "../ZS/concento/webroot/attachments/";
	}

	$rndName = generateFileName() . $ext;	
	while (file_exists($path.$rndName)) {
		$rndName = generateFileName() . $ext;			
	}
	
	if ($f = fopen($doc_root."/".$path.$rndName, 'a')) {

		fwrite($f, $data);
		fclose($f);
		
		$code = $db->getOne("SELECT CODE FROM CALL WHERE ID = ".$callID."");

		$ATC_ARRAY["xatc_moduleName"] = "call";
		$ATC_ARRAY["xatc_code"] = $code;
		$ATC_ARRAY["xatc_dispFileName"] = $name;
		$ATC_ARRAY["xatc_fileName"] = $rndName;
		$ATC_ARRAY["xatc_name"] = $name;
		$ATC_ARRAY["xatc_atchType"] = "other";
		$ATC_ARRAY["xatc_filePath"] = $path;
		$ATC_ARRAY["xatc_prePostId"] = $_POST['prepostid'];
		
		$r = AddRecord('xatc', '', $ATC_ARRAY, $_SESSION['SES_PROFILE'], "yu");
		echo "<br>OLDU - xatc<br> *** ".$r." *** <br><br>";
		return $r;
		
	} else {
		echo "<br>OLMADI - xatc<br> ***  *** <br><br>";
		echo $doc_root."/".$path.$rndName ." File couldn't be written";
		
		return 0;
		
	}
}

function AddToCall_inner($mailArray, $intID, $xcmp) {

	global $DATA_ARRAY, $db, $link;
	
	// pre($mailArray); exit;
	
	$integration = $db->getRow("SELECT * FROM XMAILINTEGRATION WHERE ID = '".$intID."'", null, null, null, MDB2_FETCHMODE_ASSOC);
	
	for ($i = 0; $i < count($mailArray); $i++) {
		
		$arr = array();
		$description = $mailArray[$i]["PLAIN"] ? $mailArray[$i]["PLAIN"] : strip_tags($mailArray[$i]["HTML"]);
	
		$senderMail= $mailArray[$i]["from"];
		
		$xusr = $db->getRow("SELECT * FROM XUSER WHERE EMAIL='$senderMail'", null, null, null, MDB2_FETCHMODE_ASSOC);
		
		if (empty($xusr)) {
			$xusrinf = $db->getRow("SELECT * FROM XUSERINFO WHERE EMAIL='$senderMail'", null, null, null, MDB2_FETCHMODE_ASSOC);
			if (empty($xusrinf)) {
				list($xu_name, $xu_surname) = explode(" ", $mailArray[$i]["person"]);
				$xuiArr = array();
				$xuiArr['xusrinf_name'] = $xu_name;
				$xuiArr['xusrinf_last'] = $xu_surname;
				$xuiArr['xusrinf_full'] = $mailArray[$i]["person"];
				$xuiArr['xusrinf_email'] = $senderMail;
				$xuiID = AddRecord('xusrinf', '', $xuiArr, "ADMIN", 'yu');
				$xusrinf = $db->getRow("SELECT * FROM XUSERINFO WHERE ID='$xuiID'", null, null, null, MDB2_FETCHMODE_ASSOC);
				$ucode = $xusrinf['CODE'];
			} else {
				$ucode = $xusrinf['CODE'];
			}
			$urgency = "Orta";
		} else {
			$xusrinf = $db->getRow("SELECT * FROM XUSERINFO WHERE XUSERCODE='".$xusr['CODE']."'", null, null, null, MDB2_FETCHMODE_ASSOC);
			if (empty($xusrinf)) {
				$xuiArr = array();
				$xuiArr['xusrinf_name'] = $xusr['NAME'];
				$xuiArr['xusrinf_last'] = $xusr['LASTNAME'];
				$xuiArr['xusrinf_full'] = $xusr['FULLNAME'];
				$xuiArr['xusrinf_email'] = $xusr['EMAIL'];
				$xuiArr['xusrinf_xusercode'] = $xusr['CODE'];
				$xuiID = AddRecord('xusrinf', '', $xuiArr, "ADMIN", 'yu');
				$xusrinf = $db->getRow("SELECT * FROM XUSERINFO WHERE ID='$xuiID'", null, null, null, MDB2_FETCHMODE_ASSOC);
				$ucode = $xusrinf['CODE'];
			} else {
				$ucode = $xusrinf['CODE'];
			}
			$urgency = "Yüksek";
		}
		
		$arr['call_callercode'] = $ucode;
		$arr['call_xusercode'] = $ucode;
	
		// Call parameters
		$arr['call_status']  = 'Closed';
		$arr['call_dnis'] = $mailArray[$i]["m_to"];
		$arr['call_ani'] = $mailArray[$i]["from"];
		$arr['call_ivrdigits'] = $mailArray[$i]["msgid"];
		$arr['call_type'] = "inbound";
		$arr['call_description'] = "Kimden: ".$arr['call_ani']."\n"."Kime: ".$arr['call_dnis']."\n\n".convert_to_inner($description, "UTF-8");
		$arr['call_subject'] = $mailArray[$i]["subject"];
		$arr['call_channel'] = $integration['CALL_CHANNEL'];
		$arr['call_category1'] = $integration['CALL_CATEGORY1'];
		$arr['call_category2'] = $integration['CALL_CATEGORY2'];
		$arr['call_category3'] = $integration['CALL_CATEGORY3'];
		$arr['call_category4'] = $integration['CALL_CATEGORY4'];
		$arr['call_category5'] = $integration['CALL_CATEGORY5'];
		$arr['call_category6'] = $integration['CALL_CATEGORY6'];
		$arr['call_asggroup'] = $integration['CALL_ASGGROUP'];
		$arr['call_sumdesc1'] = $integration['CALL_SUMDESC1'];
		$arr['call_sumdesc2'] = $integration['CALL_SUMDESC2'];
		
		if (base64_decode($arr['call_description'], true)) {
			$arr['call_description'] = base64_decode($arr['call_description']);	
		}
		
		if ($_GET["debug"] == "1") {
			echo '~~~ '.$i.':<br />';
			echo '*******************************************************************<br />';
			pre($mailArray[$i]);
			echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*<br />';
		}
		
		$callID = AddRecord('call', '', $arr, $_SESSION['SES_PROFILE'], 'yu');
		$callCode = $db->getOne("SELECT CODE FROM CALL WHERE ID = '".$callID."'");
		
		echo "~~~ ".$callID." <br />";


		if ($callID > 0) {

			$iArr = array();

			$iArr['issue_callercode'] = $arr['call_xusercode'];
			$iArr['issue_contactcode'] = $arr['call_xusercode'];
			
			$iArr['issue_urgency'] = $urgency;
			
			$iArr['issue_status'] = "Open";
			$iArr['issue_sumdesc1'] = $integration['CALL_SUMDESC1'];
			$iArr['issue_sumdesc2'] = $integration['CALL_SUMDESC2'];
			$iArr['issue_calltype'] = "byEmail";
			$iArr['issue_indescription'] = $arr['call_description'];
			
			$iArr['issue_mail_to'] = $mailArray[$i]["m_to"];
			$iArr['issue_mail_from'] = $mailArray[$i]["from"];
			$iArr['issue_mail_cc'] = $mailArray[$i]["m_cc"];
			$iArr['issue_mail_subject'] = $mailArray[$i]["subject"];
			
			/* Atama grubu set eden içerik analizi
			$analyze = new ContentAnalyze( $description );
			$needles = $analyze->prepareNeedles( $xcmp );
			$analyze->setNeedles( $needles );
			$assignmentGroupCode = $analyze->calculateTextPoints();
			$analysisResult = $analyze->getResult();
			
			$iArr['issue_assigmentgroup'] = $assignmentGroupCode;
			*/
			
			// Talep kategorisi set eden içerik analizi
			$analyze = new ContentAnalyze( $description );
			$needles = $analyze->prepareNeedles( $xcmp );
			$analyze->setNeedles( $needles );
			$issue_category1 = $analyze->calculateTextPoints();
			$analysisResult = $analyze->getResult();
			
			$iArr['issue_category1'] = $issue_category1;
			
			// Entegrasyonda tanımlanan diğer kategoriler (Bu poc'de kullanılmadı)
			$iArr['issue_category2'] = $integration['CALL_CATEGORY2'];
			$iArr['issue_category3'] = $integration['CALL_CATEGORY3'];
			$iArr['issue_category4'] = $integration['CALL_CATEGORY4'];
			$iArr['issue_category5'] = $integration['CALL_CATEGORY5'];
			$iArr['issue_category6'] = $integration['CALL_CATEGORY6'];
			
			// Atama grubu BMASGREL'e göre set ediliyor
			$asggroupsql = "
			SELECT
				ASGGROUPCODE,
				COALESCE(CATEGORY1,1,0) || COALESCE(CATEGORY2,1,0) || COALESCE(CATEGORY3,1,0) || COALESCE(CATEGORY4,1,0) || COALESCE(CATEGORY5,1,0) || COALESCE(CATEGORY6,1,0) || COALESCE(REGIONCODE,1,0) || COALESCE(LOCATIONCODE,1,0) || COALESCE(DEPARTMENTCODE,1,0) || COALESCE(ISSUESTATUS,1,0) BINARYCODE
				FROM
					BMASGREL
				WHERE
					(CATEGORY1 = '".$iArr['issue_category1']."' OR CATEGORY1 IS NULL)
					AND (CATEGORY2 = '".$iArr['issue_category2']."' OR CATEGORY2 IS NULL)
					AND (CATEGORY3 = '".$iArr['issue_category3']."' OR CATEGORY3 IS NULL)
					AND (CATEGORY4 = '".$iArr['issue_category4']."' OR CATEGORY4 IS NULL)
					AND (CATEGORY5 = '".$iArr['issue_category5']."' OR CATEGORY5 IS NULL)
					AND (CATEGORY6 = '".$iArr['issue_category6']."' OR CATEGORY5 IS NULL)
					AND (ISSUESTATUS = '".$iArr['issue_status']."' OR ISSUESTATUS IS NULL)
					AND ASGGROUPCODE IS NOT NULL
					AND XCMPCODE = '".$_SESSION['SES_COMPANY']."'
				ORDER BY
					BINARYCODE DESC
				LIMIT 0,1
			";
			
			$asggroup = $db->getAll($asggroupsql, null, null, null, MDB2_FETCHMODE_ASSOC);
			
			$iArr['issue_assigmentgroup'] = $asggroup[0]['ASGGROUPCODE'];
			
			$issueID = AddRecord('issue', '', $iArr, $_SESSION['SES_PROFILE'], 'windeskk');
			echo "---".$issueID."<br/>";

			$issueCode = $db->getOne("SELECT CODE FROM BMISSUE WHERE ID = '".$issueID."'");
	
			$relId = mail_setRelation_inner("call", $callCode, "issue", $issueCode, "", "0", $arr['call_description'],$integration['XCMPCODE']);

			/*
			for($atc = 0; $atc < count($mailArray[$i]["attachment"]); $atc++) {
				addAttachment_inner($callID, base64_decode($mailArray[$i]["attachment"][$atc]["binary"]), $mailArray[$i]["attachment"][$atc]["filename"]);
			}
			*/
			
			if (GP("mailintSeenProp") == "flag") {
				imap_setflag_full($link, $mailArray[$i]["msgid"], "\\Seen");
			} else if (GP("mailintSeenProp") == "delete") {
				imap_setflag_full($link, $mailArray[$i]["msgid"], "\\Deleted");
			} else if (GP("mailintSeenProp") == "move") {
				imap_mail_move($link, $mailArray[$i]["msgid"],GP("mailintMoveFolder"));
			}
			
		} else {
		
			if (GP("mailintSeenProp") == "flag") {
				imap_clearflag_full($link, $mailArray[$i]["msgid"], GP("mailintOpenedMailFlag"));
			} else if (GP("mailintSeenProp") == "delete") {
				imap_undelete($link, $mailArray[$i]["msgid"]);
			}
			
		}

	}
	
	imap_expunge($link);
	
}

$integrations = $db->getAll("SELECT * FROM XMAILINTEGRATION WHERE ISACTIVE = '1' AND XCMPCODE = '".$xcmp."'", null, null, null, MDB2_FETCHMODE_ASSOC);

foreach ($integrations AS $int) {

	//------------ MAIL INTEGRATION CODE START -------//
	echo "<b>Mail Integration Started -- ".$int['SERVER']."</b><br /><br />\r\n";

	$mailserver = $int['SERVER'];
	$mailport = $int['PORT'];
	$account = $int['ACCOUNT'];
	$password = $int['PASSWORD'];
	$flags = $int['FLAGS'];
	$folder = GP("mailintFolder");

	$imapconstr = "{".$mailserver.":".$mailport.$flags."}".$folder;
	$link = imap_open($imapconstr, $account, $password, NULL, 1);
	
	if ($_GET["debug"] == "1") {
		echo "Connected to mail server: $mailserver<br /><br />\r\n";
	}

	$messages = imap_search($link, GP("mailintOpenMail"));

	$mailCount = (!is_array($messages)) ? 0 : count($messages);
	
	if ($_GET["debug"] == "1") {
		echo $mailCount." Mail Found<br /><br />\r\n";
	}
	
	for ($i = 0; $i < $mailCount; $i++) {
	
		$msgid = $messages[$i];
		$info = imap_headerinfo($link, $msgid);
		$subject = imap_mime_header_decode($info->subject);
		$subject_imp="";
		
		foreach($subject as $key=>$val) {
			if (strtolower($val->charset) != "UTF-8" && trim(strtolower($val->charset)) != "" && trim(strtolower($val->charset)) != "default") {
				$subject_imp = $subject_imp.mb_convert_encoding($val->text,"UTF-8",trim($val->charset));
			} else {
				$subject_imp = $subject_imp.$val->text;
			}
		}
	
		$m_subject = $subject_imp; 
		$m_fromAddress = $info->from[0]->mailbox."@".$info->from[0]->host;
		$m_date = $info->date;
		$partsarray[$i]["msgid"] = $msgid;
		$partsarray[$i]["from"] = $m_fromAddress;
		$partsarray[$i]["person"] = $info->from[0]->personal;
		$partsarray[$i]["subject"] = $m_subject;
		$partsarray[$i]["date"] = $m_date;
		$partsarray[$i]["m_to"] = $info->toaddress;
		$partsarray[$i]["m_cc"] = $info->ccaddress;
		$partsarray[$i]["m_from"] = $info->fromaddress;
		
		$cctemp = explode(",", $info->ccaddress);
	
		foreach($cctemp as $value){
			$ccAdrtemp = Array();
			preg_match_all('/<(.*)>/', $value, $ccAdrtemp);
			$ccAdr[] = $ccAdrtemp[1];
		}
		
		foreach($toAdr[1] as $value) {
			$partsarray[$i]["m_to"] .= $value.", ";
		}
		
		if (count($ccAdr[1]) > 0) {
			foreach($ccAdr[1] as $value) {
				$partsarray[$i]["m_cc"] .= $value.", ";
			}
		}
			
		foreach($fromAdr[1] as $value) {
			$partsarray[$i]["m_from"] .= $value.", ";
		}

		$s = imap_fetchstructure($link, $msgid);
		
		if ($s->parts[0]->parameters[0]->value) {
			$charset = $s->parts[0]->parameters[0]->value;
		} else {
			$charset = $s->parameters[0]->value;
		}
				
		$partsarray[$i]["charset"] = $charset;

		if (count($s->parts) > 0) {
			foreach ($s->parts as $partno => $partarr) {
				parsepart_inner($partarr, $partno + 1, $i);
			}
		} else {
			$text = imap_body($link, $msgid);
			
			if ($s->encoding == 4) {
				$text = quoted_printable_decode($text);
			}
			
			if (strtoupper($s->subtype) == 'PLAIN') {
				$text = $text;
			}
			
			if (strtoupper($s->subtype) == 'HTML') {
				$text = $text;
			}
			
			$partsarray[$i][$s->subtype] = $text;
		}
	
	}
	
	$DATA_ARRAY = Array();
	$ATC_ARRAY = Array();
	
	// pre($partsarray);
	
	AddToCall_inner($partsarray, $int['ID'], $xcmp);
	
	imap_close($link);
	
	echo "<br /><br /><b>Mail Integration Finished</b><br /><br />\r\n";
	//------------ MAIL INTEGRATION CODE END-------//
	
	unset($DATA_ARRAY);
	unset($ATC_ARRAY);
	unset($partsarray);
	unset($int);
		
}

/* Subject kontrolü (Kargo takip numarası var mı?)
 * Eğer subject 102 ile başlıyorsa ve 12 karakter ise
 * 
 * Author: Bahadir Kocaoglu
 * Date: 21.05.2013
 */
function trusbj_($sbj) {	
	$pos = explode("102", $sbj);
	$t = substr($pos[1], 0, 9);
	$n = "102".$t;
	if (strlen($n) == "12") {
		// return $n;
		return is_numeric($n);
	}
}

function mail_setRelation_inner($fromModule, $fromCode, $toModule, $toCode, $resultCode, $op, $desc, $xcmpcode) {
	
	$_SESSION['SES_COMPANY'] = $xcmpcode;
	
	$relArray['rels_fromcode'] = $fromCode;
	$relArray['rels_frommodule'] = $fromModule;
	$relArray['rels_tocode'] = $toCode;
	$relArray['rels_tomodule'] = $toModule;
	$relArray['rels_resultcode'] = $resultCode;
	$relArray['rels_op'] = $op;
	$relArray['rels_description'] = $desc;
	//$relArray['rels_iuser'] = $_this->data['user'];
	$relId = AddRecord('rels','', $relArray,$_SESSION['SES_PROFILE'],'de');
	
	return $relId;
}

function mail_newMessage_inner($arr, $call_code, $module, $moduleCode, $subject, $body, $fromUser,$xcmpcode) {
	$bodyIn = "Açıklama: ".$arr['call_description'].
			"\n Kategoriler: ".$arr['call_category1']." - ".$arr['call_category2']." - ".$arr['call_category3']." - ".$arr['call_category4']." - ".$arr['call_category5'].
			"\n Sonuç Kodu: ".$arr['call_resultcode'];
	mail_setRelation_inner("call", $call_code, $module, $moduleCode,$arr['call_resultcode'],"1", $arr['call_description'],$xcmpcode);//fromModule, fromCode, toModule, toCode
	$msgArray['msgbox_module'] = $module;
	$msgArray['msgbox_moduleCode'] = $moduleCode;
	$msgArray['msgbox_subject'] = $subject;
	$msgArray['msgbox_body'] = $bodyIn; //$body;
	$msgArray['msgbox_fromUser'] = $fromUser;	 
	$msgArray['msgbox_status'] = "0"; // 0 --> Unread , 1 --> Read , -1 --> Deleted
	$msgId = AddRecord('msgbox','', $msgArray,$_SESSION['SES_PROFILE'],'d');
	return "Bildirim(Arama) ilgili kayıt ile eşleştirilmiştir.";
}

function convert_to_inner($source, $target_encoding) {
	// detect the character encoding of the incoming file
	$encoding = mb_detect_encoding( $source, "auto" );
	// escape all of the question marks so we can remove artifacts from
	// the unicode conversion process
	$target = str_replace( "?", "[question_mark]", $source );
	// convert the string to the target encoding
	$target = mb_convert_encoding( $target, $target_encoding, $encoding);
	// remove any question marks that have been introduced because of illegal characters
	$target = str_replace( "?", "", $target );
	// replace the token string "[question_mark]" with the symbol "?"
	$target = str_replace( "[question_mark]", "?", $target );
	return $target;
}


?> 
