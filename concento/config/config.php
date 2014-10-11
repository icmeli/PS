<?php
global $APPPARAMETERS;
global $XPARAMETERS;

//config files
require_once dirname(dirname(dirname(dirname(__FILE__)))) .DIRECTORY_SEPARATOR.'concento'.DIRECTORY_SEPARATOR.'core'.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'config.php';

//Bootstrap
//require_once dirname(dirname(dirname(dirname(__FILE__)))) .DIRECTORY_SEPARATOR.'concento'.DIRECTORY_SEPARATOR.'core'.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'bootstrap.php';

/*************************************************	CONCENTO CONFIG AYARLARI							*************************************************/
/*************************************************	START												*************************************************/
/*************************************************	Bu alanda CONCENTO için gerekli tanımlar yapılıyor	*************************************************/
$company = $_SESSION['SES_COMPANY'];

define('SMARTY_XCMP_TEMPLATE_DIR', dirname(ROOT) . DS . $company . DS . 'concento' . DS . 'view' . DS . 'tpl' . DS ); // xcmp templates for CONCENTO
define('SMARTY_XCMP_TEMPLATE_THEME_DIR', SMARTY_XCMP_TEMPLATE_DIR . $_SESSION['XUSR_TEMPLATE'] . DS ); // xcmp Theme templates for CONCENTO

array_push($SMARTY_PLUGINS_DIR, dirname(ROOT) . DS . $company . DS . 'concento' . DS . 'system' . DS . 'Smarty' . DS . 'plugins' . DS); // xcmp plugins for CONCENTO

define('XCMP_DIR', dirname(ROOT) . DS . $company . DS . 'concento' . DS); // xcmp directory constant for CONCENTO
define('_LOGDIR', XCMP_DIR.DS."concento".DS."logs". DS); // xcmp log directory for CONCENTO

if(!is_ssl()) { // web-server security control
	define('VIEW_PATH_XCMP', 'http://'.$_SERVER["HTTP_HOST"].WINDESK.'../'.$company.'/concento/view/'); // xcmp Template Path for CONCENTO
} else {
	define('VIEW_PATH_XCMP', 'https://'.$_SERVER["HTTP_HOST"].WINDESK.'../'.$company.'/concento/view/'); // xcmp Template Path for CONCENTO
}
/*************************************************	CONCENTO CONFIG AYARLARI					*************************************************/
/*************************************************	END											*************************************************/



/*************************************************	PORTA CONFIG AYARLARI						*************************************************/
/*************************************************	START										*************************************************/
/*************************************************	Firma PORTA kullanacaksa 					*************************************************/
/*************************************************	bu bölümde gerekli tanımlamalar yapılıyor 	*************************************************/
/*************************************************	kullanmıyorsa COMMENT'e alınabilir		 	*************************************************/

define('XCMP_DIR_PORTA', dirname(ROOT) . DS . $company . DS . 'porta' . DS); // xcmp directory constant for PORTA
define('SMARTY_XCMP_TEMPLATE_DIR_PORTA', dirname(ROOT) . DS . $company . DS . 'porta' . DS . 'view' . DS . 'tpl' . DS ); // xcmp templates for PORTA

/*************************************************	PORTA CONFIG AYARLARI						*************************************************/
/*************************************************	END											*************************************************/

$CAPPPARAMETERS = include "company.parameters.inc";

/**
 * Firma ve Genel Parametreler Birleştirme
 * @author: omer.akca
 * @date : 27.03.2013
 */
$APPPARAMETERS = array_merge($APPPARAMETERS, $CAPPPARAMETERS);

/** 
 * Firma ve Genel function Birleştirme
 * @author: deniz.icmeli
 * @date : 31.05.2013 - 08:45
 */
$custom_app_func_files = array("lib_custom_PS.php");
$app_func_files = array_merge($app_func_files, $custom_app_func_files);
