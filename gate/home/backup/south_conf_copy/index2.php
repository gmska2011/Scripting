<?php
header("Content-Type: text/html; charset=utf-8");
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Cache-Control: no-store, no-cache, must-revalidate');
header('Cache-Control: post-check=0, pre-check=0', FALSE);
header('Pragma: no-cache');

include "config2.php";

$session = $_GET["session"];
$username = $_GET["username"];
$domain = $_GET["userdomain"];

//////// ПРОВЕРЯЕМ ЕСЛИ ЛИ В НАЗВАНИИ ДОМЕННОГО ПОЛЬЗОВАТЕЛЯ ПРИСТАВКА 'tsd' 
if (strpos($username, 'tsd') !== false) $tsd = "tsd";
if (strpos($username, 'tmc') !== false) $tsd = "tmc";

$today = date("H:i d.m.y");
$date_time = date("d-m-y H:i:s");
$datetimeSQL = date("Y-m-d H:i:s");
$ip = $_SERVER["REMOTE_ADDR"];
//////// ПРОВЕРЯЕМ ЗАКРЫТ ЛИ ДОСТУП КО ВСЕМ ТЕРМИНАЛАМ В ТАБЛИЦЕ EXPEL_ALL    
$ExpellAll = mysql_fetch_assoc(mysql_query ("SELECT access FROM expel_all", $dbcnx));
$access = $ExpellAll['access'];
/////// ЕСЛИ ДОСТУП ОТКРЫТ ДЛЯ ВСЕХ, ПРОВЕРЯЕМ ОТКРЫТ ЛИ ДОСТУП ПЕРСОНАЛЬНО ДЛЯ ПОЛЬЗОВАТЕЛЯ
if ($access == 1) {
	$query = mysql_query("SELECT * FROM domain_user WHERE username ='".$username."'", $dbcnx);
	$result = mysql_fetch_assoc($query);
	$id = $result['id_object'];
	$access = $result['run'];
}
if (($username == 'meandr') or ($username == 'it') or ($username == 'muxa')) {
	$access = 2;
}
////// ЗАПРАШИВАЕМ МАСКУ ПОДСЕТИ МАГАЗИНА ВОШЕДШЕГО ПОЛЬЗОВАТЕЛЯ
$maskQuery = mysql_query("SELECT internet.mask FROM internet, domain_user WHERE domain_user.id_object=internet.id_object and domain_user.username='".$username."' ");
$maskQueryRow = mysql_fetch_row($maskQuery);
$MASK = $maskQueryRow['0'].'.';

$yeard = date("Y"); // текущий год
$monthd = date("n"); // текущий месяц
$month_newd = $monthd + 1; // след. месяц
$lastdayd = mktime(0, 0, 0, $month_newd, 0, $yeard); // последний день месяца
$day_now = date("j"); // текущий день
$hours_now = date("G"); // текущий час

$lastdayd_str = date('d', $lastdayd);

//$day_now = 29;
//$hours_now = 11;

//////// ЕСЛИ СЕГОДНЯ ПОСЛЕДНИЙ ДЕНЬ МЕСЯЦА И ВРЕМЯ БОЛЬШЕ 21
if (($day_now == $lastdayd_str) and ($hours_now >= 21)) {
	if (($username == 'meandr') or ($username == 'it') or ($username == 'muxa')){
		$access = 2;
	} else {
		$access = 0;
	}
}
/////////// ВЫВОДИМ ДАННЫЕ В ТЕКСТОВЫЙ ДОКУМЕНТ
echo "# Сгенерированный конфиг SOUTH_CONFIG.INI. Дата создания файла: ".$today."\r\n";
echo "# Имя пользователя ".$username."\r\n";
echo "# Рабочий каталог SOUTH \r\n";
echo "# Ваш IP адрес: ".$ip." \r\n";
echo "# ID магазина: ".$id." \r\n";
echo "# Домен: ".$domain." \r\n";
echo "# МASK подсети: ".$MASK." \r\n";

/////////// ЕСЛИ БЫЛ ЗАПУЩЕН SOUTH_PIVO /////////////////////////////////////////////////
if (isset($_GET["pivo"])) $southdir = "h:\south_pivo\\"; 
else $southdir = "h:\south\\";

echo "WORKDIR=".$southdir."\r\n";
echo "WORKDIRSCALE=".$southdir."Scale\r\n\r\n";
echo "TSD=".$tsd."\r\n";
echo "RUN=".$access."\r\n";

echo "# Установка ядра процессора для работы \r\n";    
$trm = mysql_fetch_assoc(mysql_query("SELECT * FROM terminal WHERE ip='".$ip."'", $dbcnx));
$core = $trm['core'];
$id_term = $trm['id'];
$ip_term = $trm['ip'];

function session_count_core ($dbcnx, $i, $ip_term) {
	$query = mysql_query("SELECT COUNT(*) FROM user_list WHERE core='".$i."' and ip='".$ip_term."' and run='1'", $dbcnx);
	$row = mysql_fetch_assoc($query);
	return $row['COUNT(*)'];
}

for ($i=1; $i<=$core; $i++) {	
	$scc = session_count_core ($dbcnx, $i, $ip_term);
	$user_core[$i] = $scc;
}

$last_core = array_keys($user_core, min($user_core))[0];
if (isset($last_core)) {
	echo "# Менее загруженное ядро ".$last_core." на терминале ".$ip_term." \r\n";
	mysql_query("UPDATE user_list SET core='".$last_core."' WHERE name_user='".$username."'", $dbcnx);
} else { $last_core = 1; }

$PROC = [1,2,4,8,16,32,64,128,256,512,1024];
echo "PROC=".$PROC[($last_core-1)]." \r\n\r\n";
//if ($last_core < $core) $update_core = ($last_core + 1);
//else $update_core = '1';
//mysql_query("UPDATE terminal SET last_core = ".$update_core." WHERE ip='".$ip."'", $dbcnx); 

echo "# Номер виртуального порта штрихэтикетника (default: LPT2) \r\n";
echo "LPTPORT=LPT2\r\n\r\n";

$query_mod = mysql_fetch_assoc(mysql_query("SELECT printers.print_name, ws.ip FROM ws, printers WHERE printers.print_name in ('Citizen','Datamax') and printers.id_object='".$id."' and ws.id=printers.id_ws"));
echo "# Имя SMB-шары (Citizen, Datamax) \r\n";
echo "SHTRIH_MODEL=".$query_mod['print_name']."\r\n\r\n";

echo "# МАСКА ПОДСЕТИ МАГАЗИНА (sample: 192.168.0.) \r\n";
echo "MASK=".$MASK."\r\n\r\n";

echo "# IP машины куда подключен штрихэтикетник \r\n";
echo "SHTRIH_IP=".$query_mod['ip']."\r\n\r\n";

echo "# IP машин куда скидывать прайс магазина (sample: 84 85) \r\n";
echo "COPY_PRC_IP=";

if (isset($_GET["pivo"])) {
	$q_PRC_IP = mysql_query("SELECT SUBSTRING_INDEX(`ip`, '.', -1) as ip FROM ws WHERE id_object='".$id."' and os = 'ZHMORE'");
} else {
	$q_PRC_IP = mysql_query("SELECT SUBSTRING_INDEX(`ip`, '.', -1) as ip FROM ws WHERE id_object='".$id."' and type = '0' and os != 'ZHMORE' and os != 'ATOL'");
}
$n = mysql_num_rows($q_PRC_IP); 
for ($i = 0; $i < $n; $i++) {
	$row = mysql_fetch_assoc($q_PRC_IP);
	$r_PRC_IP[] = $row;
}

foreach ($r_PRC_IP as $ws) echo $ws['ip']." ";
echo " \r\n\r\n";

echo "# COMM магазина - путь к базе данных магазина \r\n";


$comm = mysql_fetch_assoc(mysql_query("SELECT * FROM south_conf WHERE id_object='".$id."'"));	
	if (isset($comm['COMM'])) {
		echo "COMM=".strtolower($comm['COMM'])."\r\n\r\n";
	} else {
		echo "COMM=commXX\r\n\r\n";
	}
echo "# IP адреса весов DIGI (sample: 6 7 8) \r\n";
echo "IP_VES=";

	$qves = mysql_fetch_assoc(mysql_query("SELECT SUBSTRING_INDEX(`ip`, '.', -1) as ip FROM ves WHERE id_object='".$id."'"));
		foreach ($qves as $a) {
			echo $a['ip']." ";
		}
echo "\r\n\r\n";

$squery = mysql_fetch_assoc(mysql_query("SELECT * FROM session_log ORDER BY date LIMIT 1"));
if (isset($squery['date'])) { $sDate = $squery['date']; } else { $sDate = $date_time; }
$sID = $squery['id'];
$d = strtotime("-14 day",strtotime(date("Y-m-d H:i:s")));

if ($d <= strtotime($sDate)) {
	mysql_query("INSERT INTO `session_log`(`date`, `domain_user`, `ip_term`, `core`) VALUES ('".$datetimeSQL."','".$username."','".$ip."','".$last_core."')");
} else { 
	mysql_query("UPDATE `session_log` SET `date`='".$datetimeSQL."', `domain_user`='".$username."', `ip_term`='".$ip."', `core`='".$last_core."' WHERE `id`='".$sID."'");	 
}
?>