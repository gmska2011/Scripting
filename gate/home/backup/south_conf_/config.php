<?php

$dblocation = "10.0.0.242";
$dbname = "pelican";
$dbuser = "root";
$dbpasswd = "uk.rjyfn2009";
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
	if (!$dbcnx) {
		exit( "<P>В настоящий момент сервер базы данных не доступен, поэтому корректное отображение страницы невозможно.</P>" );
	}
	if (! @mysql_select_db($dbname,$dbcnx) ) {
		exit( "<P>В настоящий момент база данных не доступна, поэтому корректное отображение страницы невозможно.</P>" );
	}
@mysql_query("SET NAMES 'utf8'");
?>