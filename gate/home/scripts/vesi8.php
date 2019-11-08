<?php
  $conn = mysql_connect('localhost', 'root', 'uk.rjyfn2009');
  mysql_query("SET NAMES 'UTF8'");

  $db_name= "ip_pelican";
  $table_name = "users";

  $fields = mysql_list_fields($db_name, $table_name);
  $fields_num = mysql_num_fields($fields);
    $zz=1;
    $sql = 'select ip_kassa_1 from users';
    $res = mysql_query($sql, $conn)  or die("Error: ". mysql_error(). " with query ". $sql);
$pp=0;
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

$port=8;

//                echo $pieces[3];
$row=$pieces[0].'.'.$pieces[1].'.'.$pieces[2].'.'.$port;
echo $row." - ";

//echo $field_value;
$run = "nc -w2 -z $row 200$port && echo ok || echo neok";
exec($run, $output);

print_r($output[$pp]);

if ($output[$pp] == "ok") {
$query3="UPDATE users set ip_ves_3='".$row."' where ip_kassa_1='".$field_value."'";
//echo $query3;

//$update= mysqli_query($sql,$query3);
$update = mysql_query($query3, $conn)   or die("Error: ". mysql_error(). " with query ". $query3);
}


$pp++;
#$ip_kassa[$zz]=$field_value;
    		echo "\n";

               }else{
                  echo '';
               }
           $zz++;
     }
                   mysql_close($conn);


    ?>