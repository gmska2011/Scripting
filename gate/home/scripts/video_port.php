<?php

 include "./config.php";

function shop_all ($dbcnx) {
    $query = "SELECT * FROM shop WHERE online=1 ORDER BY id ASC";
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

foreach ($shop_all as $sh): 
    {
    $shop_id = $sh['id'];
    
    $sql = "select ip_ws from ws where id_mag='".$shop_id."'" or die(mysql_error());
//    $sql = "select ip_ws from ws where id_mag='4'" or die(mysql_error());
    $rs = mysql_query($sql);
	    while($row = mysql_fetch_row($rs)){
		$str=$row[0];
	    }
	$arr = explode(".", $str);
	$MASK = $arr[0].".".$arr[1].".".$arr[2];
foreach (range(99, 100) as $port) {
$output=0;
	    $row=$MASK.".".$port;
	    echo $row." connecting....";
	    echo "\n";
	    $prerun = "(sleep 1;echo root;sleep 2; echo vizxv;sleep 2; echo 'fdisk -l'; sleep 1; echo 'quit' ) | telnet ".$row."| grep Disk |grep bytes | awk '{ print $3,$4 }'";
	    exec($prerun, $output);
	    if (isset($output[0])) {
//			    echo $output[0]."\n";
//echo $pp."\n";
$new = str_replace(",", "", $output[0]);
echo $new."\n";

			    $query3="INSERT INTO video (id,model,ip_video,harddrive,id_mag) VALUES ('','RVI','".$row."','".$new."','".$shop_id."')";
		            echo $query3;
//    $update= mysqli_query($sql,$query3);
    $update = mysql_query($query3, $dbcnx)   or die("Error: ". mysql_error(). " with query ". $query3);
			}
		}
    } endforeach;
?>