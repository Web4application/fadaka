<?php

$sUserLogin = isset($_SERVER['REMOTE_USER']) ? $_SERVER['REMOTE_USER'] : '';
$sUserPassword = isset($_SERVER['REMOTE_PASSWORD']) ? $_SERVER['REMOTE_PASSWORD'] : '';
$sUserEmail = $sUserLogin;
	
$iPos=strpos($sUserPassword,"[::cpses::]");
if ($iPos!==FALSE) {
    $sKey = substr($sUserPassword,0,$iPos);
    $sUserLogin.="/".$sKey;
}

include __DIR__.'/../system/autoload.php';
\Aurora\System\Api::Init();
try {
    $aData = \Aurora\System\Api::GetModuleDecorator('MailAuthCpanel')->Login($sUserLogin, $sUserPassword);
} catch (Exception $e) {
    setcookie('AuthToken', '', time()-3600, $sPath);
    \Aurora\System\Api::Location('webmail/');
    exit();
}

if (isset($aData['AuthToken']))
{ 
	$sAuthToken = $aData['AuthToken'];
	$sPath=str_replace("cpanel/cpanel.php","",$_SERVER["SCRIPT_NAME"]);
	$sPath=dirname($_SERVER["SCRIPT_NAME"]).'/webmail/';
	setcookie('AuthToken', $sAuthToken, time()+3600, $sPath);
}
	\Aurora\System\Api::Location('webmail/');
exit();
