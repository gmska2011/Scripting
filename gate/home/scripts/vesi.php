<?php
  $conn = mysql_connect('localhost', 'root', 'uk.rjyfn2009');
  mysql_query("SET NAMES 'UTF8'");

  $db_name= "ip_pelican";
  $table_name = "users";

  $fields = mysql_list_fields($db_name, $table_name);
  $fields_num = mysql_num_fields($fields);
    $zz=1;
    $sql = 'select ip_kassa_1 from users';
//    $sql = 'select ip_kassa_1 from users where name rlike "П 8 кв"';
    $res = mysql_query($sql, $conn)  or die("Error: ". mysql_error(). " with query ". $sql);

$ii=0;
//foreach (range(1, 254) as $number) {
foreach (range(1, 254) as $number) {
if ($number < 10){
//    echo "00".$number;
    $ipves[$ii]="00".$number;

}elseif ($number > 99){
//    echo $number;
    $ipves[$ii]=$number;
    }else {
//    echo "0".$number;
    $ipves[$ii]="0".$number;
    }
//    echo "\n";
$ii++;
}
//echo $ipves[4];
//exit;

//$yy=0;
    while ($db_row = mysql_fetch_row($res)) {
//       if ( $db_row[7]=="unavailable"){ echo '<tr bgcolor="#F6CECE">'."\n"; }
//       else if ($db_row[7]=="away" or $db_row[7]=="xa") { echo '<tr bgcolor="#FAEBD7">'."\n"; }
//       else {  echo '<tr bgcolor="#E0EEE0">'."\n";}
//       echo "<td>$zz</td>";
       foreach($db_row as $field_value)
              if ($field_value){
                //echo $field_value;
//             $pieces = preg_replace("/\)/", "", $field_value);
 $pieces=explode(".", $field_value);

//$port=006;
$pp=0;
$ii=1;
$output=0;
//echo $pieces[0].'.'.$pieces[1].'.'.$pieces[2].' - ';

//foreach ($ipves as $port){

foreach (range(1, 254) as $port) {
//    $port=$ipves[$pp];
    //                echo $pieces[3];
    $row=$pieces[0].'.'.$pieces[1].'.'.$pieces[2].'.'.$port;

    echo $row;
    echo "\n";

if ($port < 10){
//    echo "00".$number;
    $ipves[$pp]="00".$port;

}elseif ($port > 99){
//    echo $number;
    $ipves[$pp]=$port;
    }else {
//    echo "0".$number;
    $ipves[$pp]="0".$port;
    }



    echo "Port: 2".$ipves[$pp];

    echo " pinging....";

    $run = "nc -w1 -z $row 2$ipves[$pp] && echo ok || echo neok";
//echo $run;
    exec($run, $output);
    print_r($output[$pp]);
    echo "\n";
    echo $output[$pp]."\n";


    if ($output[$pp] == "ok") {
//    $query3="UPDATE users set ip_ves_".$ii."='".$row."' where ip_kassa_1='".$field_value."'";
    echo $query3;
    $ii++;
    //$update= mysqli_query($sql,$query3);
    $update = mysql_query($query3, $conn)   or die("Error: ". mysql_error(). " with query ". $query3);
    }
    $pp++;
}


#$ip_kassa[$zz]=$field_value;
    		echo "\n";

               }else{
                  echo '';
               }
           $zz++;
     }
                   mysql_close($conn);


    ?>