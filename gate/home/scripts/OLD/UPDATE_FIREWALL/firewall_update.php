<?php

 include "./config.php";
 error_reporting( E_ERROR ); 

function shop_all ($dbcnx) {
    $query = "SELECT * FROM shop WHERE online=1 and gorod='TLT' and id=154 ORDER BY id ASC";
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
    
    $sql = "select ip_ws from ws where id_mag='".$shop_id."' limit 1" or die(mysql_error());
//    $sql = "select ip_ws from ws where id_mag='4'" or die(mysql_error());
    $rs = mysql_query($sql);
	    while($row = mysql_fetch_row($rs)){
		$str=$row[0];
	    }
	$arr = explode(".", $str);
	$MASK = $arr[0].".".$arr[1].".".$arr[2];
foreach (range(4, 4) as $port) {
$output=0;
	    $row=$MASK.".".$port;
	    echo $row." connecting....";
	    echo "\n";
	    $prerun = "sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@".$row." 'cat /etc/firewall.user'";
	    exec($prerun, $output);

	    if (isset($output[0])) {

//		if ( strpos($output[0], 'EGAIS')) {
			echo "ID ".$shop_id." - TPLINK DETECTED \n";
		$router="TPLINK";
$IPTABLES='$IPTABLES';
$LAN='$LAN';
$ECHO_STRING="\"echo 'htmlspecialchars_decode(&#36;)IPTABLES -I FORWARD 1 -i &#36;LAN -p udp --dport 123  -j ACCEPT'>> /etc/firewall.user\"";

#		 $run2 = "sshpass -f sshpass scp -o 'StrictHostKeyChecking no' ./tplink/firewall.user root@".$row.":/etc/";
#		 $run2 = "sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@".$row." 'echo \"IPTABLES -I FORWARD 1 -i '$LAN' -p udp --dport 123  -j ACCEPT\">> /etc/firewall.user'";
		 $run2 = "sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' root@".$row." ".$ECHO_STRING;
                exec($run2, $output_asus2);

//	    	}

            }

	    else {
	    	  echo "ID ".$shop_id." - ASUS/DIR DETECTED \n";
		$router="ASUS";
//		$run1 = "sshpass -f sshpass scp -o 'StrictHostKeyChecking no' ./asus/post-firewall admin@".$row.":/tmp/local/sbin/";
//                exec($run1, $output_asus);
//		$run2 = "sshpass -f sshpass ssh -o 'StrictHostKeyChecking no' admin@".$row." '/tmp/local/sbin/flash-save.sh'";
//                exec($run2, $output_asus2);
		 }
//		    $query3="update `internet` set `router`='".$router."' where `id_mag`='".$shop_id."'";
		//    echo $query3;
//		    $update= mysqli_query($sql,$query3);
//		    $update = mysql_query($query3, $dbcnx)   or die("Error: ". mysql_error(). " with query ". $query3);
		
    }
    } endforeach;
?>