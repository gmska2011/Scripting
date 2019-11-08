<?php
$link2 = mysqli_connect("localhost", "root", "uk.rjyfn2009", "ip_pelican");
$charset = "UTF8";
mysqli_set_charset($link, "utf8");

/* п�ове�ка подкл��ени� */
if (mysqli_connect_errno()) {
    printf("�е �дало�� подкл��и����: %s\n", mysqli_connect_error());
        exit();
        }
$query = "SELECT name FROM users";

#echo $query."\n";   
$name = array();     
if ($result = mysqli_query($link, $query)) 
{
    $z=0;    
    /* в�бо�ка данн�� и поме�ение и� в ма��ив */
    while ($row = mysqli_fetch_row($result)) {
	$pieces = explode(" (", $row[0]);
#        $name[$i] = $row[0];

#	$name[$i][1] = preg_replace("/(.*).$/", "\\1", $pieces[1]);

	if ($pieces[1]) {
#	$pieces[1] = preg_replace("/(.*).$/", "\\1", $pieces[1]);
#	$pieces[1] = ~s/(.*)/;
		if (preg_match("/\)/", $pieces[1])){
		$pieces[1] = preg_replace("/\)/", "", $pieces[1]);
		}
	    $name[($pieces[0])][0] = 1;
	    $name[($pieces[0])][1] = $pieces[1];
	    $z=$z+1;
	}

    }

    
$count1=$z;
#while ($z > 0){
#echo $name[$i][0]." - ".$name[$i][1];

#echo $name[$z][0]." - ".$name[$z][1]."\n";
#$z=$z-1;
#    }
        /* о�и�аем �ез�л��и����ий набо� */
mysqli_free_result($result);
}

if ($result = mysqli_query($link2, $query2)) {

/* в�бо�ка данн�� и поме�ение и� в ма��ив */
    while ($row = mysqli_fetch_row($result)) {
if ( $name[($row[0])][0]==1 ) { 
$name2=$row[0];
#echo $name2." - ".$name[($row[0])][1]."\n";
#$query3="UPDATE users set telephone='".$name[($row[0])][1]."' where name='".$name2."'";
echo $query3;

if ($update= mysqli_query($link2, $query3)){} else {echo "ERROR";};
}

    }


        /* о�и�аем �ез�л��и����ий набо� */
mysqli_free_result($result);
}


                        
                /* зак��ваем подкл��ение */
                    mysqli_close($link);
                    mysqli_close($link2);
    ?>