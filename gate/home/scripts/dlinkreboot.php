<?php

// сервер локальной машины
$dblocation = "192.168.0.4";
// Имя базы данных, на хостинге или локальной машине
$dbname = "ip_pelican";
// Имя пользователя базы данных
$dbuser = "root";
// и его пароль
$dbpasswd = "uk.rjyfn2009";
 
// Устанавливаем соединение с базой данных
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
        if (!$dbcnx) {
                exit( "<P>В настоящий момент сервер базы данных не доступен, поэтому корректное отображение страницы невозможно.</P>" );
        }
 
// Выбираем базу данных
        if (! @mysql_select_db($dbname,$dbcnx) ) {
                exit( "<P>В настоящий момент база данных не доступна, поэтому корректное отображение страницы невозможно.</P>" );
        }
        
// Устанавливаем кодировку соединения
@mysql_query("SET NAMES 'utf8'");

function shop_all ($dbcnx) {
    $query = "SELECT ip FROM wifi_ap ORDER BY id ASC";
    $result = mysql_query($query);

    if (!$result)
        die(mysql_error($dbcnx));

    $n = mysql_num_rows($result);
    $shop_all = array();

    for ($i = 0; $i < $n; $i++)
    {
        $row = mysql_fetch_assoc($result);
        $shop_all[] = $row;
    }

    return $shop_all;
}

$shop_all = shop_all($dbcnx);

foreach ($shop_all as $wifi):
    {
	    $ip = $wifi['ip'];
	    $output=0;
	    echo $ip." connecting....";
	    echo "\n";
	    $prerun = "(sleep 1;echo admin;sleep 2; echo admin;sleep 2; echo 'reboot'; sleep 1; echo 'quit' ) | telnet ".$ip."";
	    exec($prerun, $output);
	    
	    if (isset($output[0])) {
		//$new = str_replace(",", "", $output[0]);
		echo $output[0]."\n";
	    }
    }endforeach;

?>