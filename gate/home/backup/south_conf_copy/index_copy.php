<?php
include "config.php";

$session = $_GET["session"];
$username = $_GET["username"];
$domain = $_GET["userdomain"];
$findme = 'tsd';
//////// ПРОВЕРЯЕМ ЕСЛИ ЛИ В НАЗВАНИИ ДОМЕННОГО ПОЛЬЗОВАТЕЛЯ ПРИСТАВКА 'tsd' 
$pos = strpos($username, $findme);


//////// ВЫВОДИМ СПИСОК ПОЛЬЗОВАТЕЛЕЙ ИЗ ТАБЛИЦЫ 'SESSION_ONLINE' КОТОРЫХ НЕТ В ТАБЛИЦЕ 'USER_LIST'
$select_du = "SELECT session_online.name FROM session_online WHERE session_online.name NOT IN (SELECT session_online.name FROM USER_LIST, session_online WHERE session_online.name=USER_LIST.NAME_USER)";
$result_du = mysql_query($select_du);
$n = mysql_num_rows($result_du);
$so_name = array();

/////// ЗАГОНЯЕМ ИХ В МАССИВ SO_NAME[]
if ($n < 5){
    for($i=0;$i<$n;$i++){
	$row = mysql_fetch_assoc($result_du);
	$so_name[]=$row;
//	echo "# Пользователь: ".$row['name']."\r\n";
    }
}

////// УДАЛЯЕМ ДОМЕННЫХ ПОЛЬЗОВАТЕЛЕЙ ИЗ ТАБЛИЦЫ SESSION_ONLINE
echo "#Список разногласий: \r\n";
foreach ($so_name as $res) {
    $delete = "DELETE FROM `session_online` WHERE `name`='".$res["name"]."' ";
    mysql_query($delete);
$date_time_log = date("y-m-d H:i:s");
    $insert_log = "INSERT INTO `log_south_conf`(`name`, `date`) VALUES ('".$res["name"]."', '".$date_time_log."')";
    mysql_query($insert_log);
}

////////////////////////////////////////////////////////////////////////////////////////////////////

if ($pos !== false) {
    $tsd = "tsd";
}

if ($session == 1) {

    $today = date("H:i d.m.y");
    $date_time = date("d-m-y H:i:s");  
    //$username=$_GET["username"];
    $ip = $_SERVER["REMOTE_ADDR"];
//////// ПРОВЕРЯЕМ ЗАКРЫТ ЛИ ДОСТУП КО ВСЕМ ТЕРМИНАЛАМ В ТАБЛИЦЕ EXPEL_ALL    
    $queryExpellAll = mysql_query("SELECT access FROM expel_all");
    $resultExpellAll = mysql_fetch_assoc ($queryExpellAll);
    $run = $resultExpellAll['access'];
/////// ЕСЛИ ДОСТУП ОТКРЫТ ДЛЯ ВСЕХ, ПРОВЕРЯЕМ ОТКРЫТ ЛИ ДОСТУП ПЕРСОНАЛЬНО ДЛЯ ПОЛЬЗОВАТЕЛЯ
    if (($username == 'meandr') or ($username == 'it') or ($username == 'muxa')){
        $run = 2;
    }

    if ($run == 1) {
	$query = mysql_query("SELECT * FROM domain_users WHERE username ='".$username."'");
	$result = mysql_fetch_assoc($query);
	$id = $result['id_mag'];
	$run = $result['run'];
    }
////// ЗАПРАШИВАЕМ МАСКУ ПОДСЕТИ МАГАЗИНА ВОШЕДШЕГО ПОЛЬЗОВАТЕЛЯ
    $maskQuery = mysql_query("SELECT DISTINCT(CONCAT(SUBSTRING_INDEX(`ip_ws`, '.', 3), '.')) FROM `ws` WHERE id_mag='".$id."'");
    $maskQueryRow = mysql_fetch_row($maskQuery);
    $MASK = $maskQueryRow['0'];

    $yeard = date("Y");
    $monthd = date("n");
    $month_newd = $monthd + 1;
    $lastdayd = mktime(0, 0, 0, $month_newd, 0, $yeard);
    $day_now = date("j");
    $hours_now = date("G");

    $lastdayd_str = date('d', $lastdayd);

//$day_now = 29;
//$hours_now = 11;

//////// ЕСЛИ СЕГОДНЯ ПОСЛЕДНИЙ ДЕНЬ МЕСЯЦА И ВРЕМЯ БОЛЬШЕ 21
if (($day_now == $lastdayd_str) and ($hours_now >= 21)){
    if (($username == 'meandr') or ($username == 'it') or ($username == 'muxa')){
	$run = 2;
    }
    else {
	$run = 0;
    }
}

//echo $day_now." - day_now \r\n";
//echo $lastdayd_str." - lastdayd_str \r\n";
//echo $hours_now." - hours_now \r\n";
//echo $day_now." - day_now \r\n";

echo "# Количество различных  = ".$n." \r\n";
/////////// ВЫВОДИМ ДАННЫЕ В ТЕКСТОВЫЙ ДОКУМЕНТ
echo "# Сгенерированный конфиг SOUTH_CONFIG.INI. Дата создания файла: ".$today."\r\n";
echo "# Имя пользователя ".$username."\r\n";
echo "# Рабочий каталог SOUTH \r\n";
echo "# Ваш IP адрес: ".$ip." \r\n";
echo "# ID магазина: ".$id." \r\n";
echo "# Домен: ".$domain." \r\n";
//echo "# IP адрес директора: ".$str."\r\n";
echo "# МASK подсети: ".$MASK." \r\n";

/////////// ЕСЛИ БЫЛ ЗАПУЩЕН SOUTH_PIVO /////////////////////////////////////////////////
if (isset($_GET["pivo"])) {
    $southdir = "h:\south_pivo\\"; 
} else { $southdir = "h:\south\\";  }

echo "WORKDIR=".$southdir."\r\n";
echo "WORKDIRSCALE=".$southdir."Scale\r\n\r\n";
echo "TSD=".$tsd."\r\n";
echo "RUN=".$run."\r\n";

echo "# Установка ядра процессора для работы \r\n";    
    $query_trm = sprintf("SELECT * FROM terminal WHERE ip_term='".$ip."'");
    $result_trm = mysql_query($query_trm);
    
    while ($trm = mysql_fetch_assoc($result_trm)){

    $last_core = $trm['last_core'];
    $core = $trm['core'];
    $my_term = $trm['id_term'];
    $my_ip_term = $trm['ip_term'];
    
    function session_count_core ($dbcnx, $i, $my_ip_term) {
    $query = "SELECT COUNT(*) as core FROM session_online WHERE core='".$i."' and terminal='".$my_ip_term."'";
    $result = mysql_query($query);
    
    if (!$result)
	die(mysql_error($dbcnx));
    
    //Извлечение из БД
    $row = mysql_fetch_assoc($result);
    $session_count_core = $row['core'];
    
    return $session_count_core;
    }

    for ($i=1;$i<=$core;$i++){
	    
	$scc = session_count_core ($dbcnx, $i, $my_ip_term);		
	$user_core[$i] = $scc;
    }
    $last_core = array_keys($user_core, min($user_core))[0];

echo "# Менее загруженное ядро ".$last_core." на терминале ".$my_ip_term." \r\n";
	
    $query_update = "UPDATE domain_users SET id_term='".$my_term."', domain='NEODC' WHERE username='".$username."'";
    mysql_query($query_update);

if ($last_core == 1) {
    if ($last_core < $core) {
    	echo "PROC=1 \r\n\r\n";
	// к значению $last_core прибавляем + 1
	$query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
	mysql_query($query_update);
    }
	else {
	        echo "PROC=1 \r\n\r\n";
	        // значение $last_core заменем на 1
    	        $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	        mysql_query($query_update); 
	    }
}
    elseif ($last_core == 2) {
    
        if ($last_core < $core){
	        echo "PROC=2 \r\n\r\n";
	        // к значению $last_core прибавляем + 1
	        $query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
	        mysql_query($query_update);
	    }
	    else {
	        echo "PROC=2 \r\n\r\n";
	        // значение $last_core заменем на 1
	        $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
	        mysql_query($query_update);
	    }
    }    
    elseif ($last_core == 3) {

        if ($last_core < $core){
    	    echo "PROC=4 \r\n\r\n";
	    // к значению $last_core прибавляем + 1
		$query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
		mysql_query($query_update);
            }
	    else {
	    echo "PROC=4 \r\n\r\n";
	    // значение $last_core заменем на 1
            $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
	    mysql_query($query_update);
	    }
    }

    elseif ($last_core == 4) {

        if ($last_core < $core){
	    echo "PROC=8 \r\n\r\n";
	    // к значению $last_core прибавляем + 1
    	    $query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
    	    }
    	    else {
    	    echo "PROC=8 \r\n\r\n";
    	    // значение $last_core заменем на 1
    	    $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
	    }
    }

    elseif ($last_core == 5) {

        if ($last_core < $core){
    	    echo "PROC=16 \r\n\r\n";
	    // к значению $last_core прибавляем + 1
    	    $query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
    	    }
    	    else {
    	    echo "PROC=16 \r\n\r\n";
	    // значение $last_core заменем на 1
    	    $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
	    }
    }

    elseif ($last_core == 6) {

        if ($last_core < $core){
    	    echo "PROC=32 \r\n\r\n";
	    // к значению $last_core прибавляем + 1
    	    $query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
    	    }
    	    else {
    	    echo "PROC=32 \r\n\r\n";
	    // значение $last_core заменем на 1
    	    $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
	    }
    }

    elseif ($last_core == 7) {

        if ($last_core < $core){
    	    echo "PROC=64 \r\n\r\n";
	    // к значению $last_core прибавляем + 1
    	    $query_update = "UPDATE terminal SET last_core=('".$last_core."'+1) WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
    	    }
    	    else {
    	    echo "PROC=64 \r\n\r\n";
	    // значение $last_core заменем на 1
    	    $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
	    }
    }

    	    else {
    	    echo "PROC=128 \r\n\r\n";
	    // значение $last_core заменем на 1
    	    $query_update = "UPDATE terminal SET last_core=1 WHERE ip_term='".$ip."'";
    	    mysql_query($query_update);
    	    }
}

//echo "PROC=2 \r\n\r\n";

echo "# Номер виртуального порта штрихэтикетника (default: LPT2) \r\n";
echo "LPTPORT=LPT2\r\n\r\n";

echo "# Имя SMB-шары (Citizen, Datamax) \r\n";

        $query_mod = sprintf("SELECT share_strh FROM domain_users WHERE username='".$username."'");
        $result_mod = mysql_query($query_mod);
        $strh_mod = mysql_fetch_assoc($result_mod);
        $strh = $strh_mod['share_strh'];

echo "SHTRIH_MODEL=".$strh."\r\n\r\n";

echo "# МАСКА ПОДСЕТИ МАГАЗИНА (sample: 192.168.0.) \r\n";
echo "MASK=".$MASK."\r\n\r\n";

echo "# IP машины куда подключен штрихэтикетник \r\n";

	$query_sh = sprintf("SELECT w.ip_ws FROM domain_users as d LEFT JOIN ws as w ON d.id_shtrih = w.id  where d.username='".$username."'");
	$result_sh = mysql_query($query_sh);
	$rsh = mysql_fetch_assoc($result_sh);
	$sh = $rsh['ip_ws'];

echo "SHTRIH_IP=".$sh."\r\n\r\n";

echo "# IP машин куда скидывать прайс магазина (sample: 84 85) \r\n";
echo "COPY_PRC_IP=";

if (isset($_GET["pivo"])){
    $query2 = sprintf("SELECT SUBSTRING_INDEX(`ip_ws`, '.', -1) as sub FROM ws WHERE id_mag='".$id."' and os_ws = 'ZHMORE'");
}
else {
    $query2 = sprintf("SELECT SUBSTRING_INDEX(`ip_ws`, '.', -1) as sub FROM ws WHERE id_mag='".$id."' and os_ws != 'ATOL' and os_ws != 'ZHMORE'");
}
    $result2 = mysql_query($query2);
    while ($mag = mysql_fetch_assoc($result2)){
        echo $mag['sub']." ";
    }

echo " \r\n\r\n";

echo "# COMM магазина - путь к базе данных магазина \r\n";
if (isset($_GET["pivo"])) { 
    $query_comm = sprintf("SELECT commp FROM shop WHERE id='".$id."'");
} else {
    $query_comm = sprintf("SELECT comm FROM shop WHERE id='".$id."'");
}
	$result_comm = mysql_query($query_comm);
	$comm = mysql_fetch_row($result_comm);
	$com = $comm[0];	
	    if (isset($com)) {
		echo "COMM=".$com."\r\n\r\n";
	    }
	    else
	    {
		echo "COMM=commXX\r\n\r\n";
	    }

echo "# IP адреса весов DIGI (sample: 6 7 8) \r\n";
echo "IP_VES=";

	$query_ves = sprintf("SELECT * FROM ves WHERE id_mag='".$id."'");
	$result_ves = mysql_query($query_ves);
	    while ($ves = mysql_fetch_assoc($result_ves)){
	    $vesip = $ves['ip_ves'];
	    $ves_arr = explode(".", $vesip);
	    echo $ves_arr[3]." ";
	    }
echo "\r\n\r\n";

    $add_domain = "UPDATE `domain_users` SET `domain`='".$domain."' WHERE username = '".$username."'";
    mysql_query($add_domain);

$session_pel_query = sprintf("SELECT * FROM session_pel ORDER BY date LIMIT 1");
$session_pel_result = mysql_query($session_pel_query);
$session_row = mysql_fetch_assoc($session_pel_result);
$session_pel_date = $session_row['date'];
$session_pel_id = $session_row['id'];
$date_time = date("Y-m-d H:i:s");
$d = strtotime("-12 day",strtotime($date_time));

    if ($d < strtotime($session_pel_date)) {
    $session_pel = sprintf("INSERT INTO `session_pel`(`date`, `name`, `terminal`, `core`) VALUES ('".$date_time."','".$username."','".$ip."','".$last_core."')");
    mysql_query($session_pel);
    }	
    else {  
    $session_pel = sprintf("UPDATE `session_pel` SET `date`='".$date_time."', `name`='".$username."', `terminal`='".$ip."', `core`='".$last_core."' WHERE `id`='".$session_pel_id."'");	
    mysql_query($session_pel);  
    }
//    echo strtotime($date_time)." - сейчас\r\n";
//    echo strtotime($session_pel_date)." - дата сессии\r\n";
//    echo $d." - минус 12 дней\r\n";
    
    // удаление записей по $username из таблицы 'session_online'
    $session_pel_online_del = sprintf ("DELETE FROM `session_online` WHERE name = '".$username."'");
    mysql_query($session_pel_online_del);
    
    // удаление всех записей старше 24 часов
    $session_pel_offline_24 = sprintf ("DELETE FROM `session_online` WHERE date < (NOW() - INTERVAL 1 DAY)");
    mysql_query($session_pel_offline_24);

    // добавление актуальной  записи по $username в таблицу 'session_online'
    $session_pel_online = sprintf("INSERT INTO `session_online`(`date`, `name`, `terminal`, `core`) VALUES ('".$date_time."','".$username."','".$ip."','".$last_core."')");
    mysql_query($session_pel_online);

}
    else {
    $session_pel_online_del = sprintf ("DELETE FROM `session_online` WHERE name = '".$username."'");
    //echo $session_pel_online_del;
    mysql_query($session_pel_online_del);
    }
    // удаление всех записей старше 24 часов
    $session_pel_offline_24 = sprintf ("DELETE FROM `session_online` WHERE date < (NOW() - INTERVAL 1 DAY)");
    mysql_query($session_pel_offline_24);
?>