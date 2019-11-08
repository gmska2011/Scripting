<?php
$link = mysqli_connect("localhost", "root", "uk.rjyfn2009", "ip_pelican");
mysqli_set_charset($link, "utf8");

/* п©яп╬п╡п╣яп╨п╟ п©п╬п╢п╨п╩яяп╣п╫п╦я */
if (mysqli_connect_errno()) {
    printf("пп╣ яп╢п╟п╩п╬яя п©п╬п╢п╨п╩яяп╦яяяя: %s\n", mysqli_connect_error());
        exit();
        }

$mail = array();     

$lines = split("\n", file_get_contents('aaaa'));

$i=0;

while ($lines[$i]){

$raw=explode("::", $lines[$i]); 

$mail[$i][0]=$raw[0];
$mail[$i][1]=$raw[1];


#echo $mail[$i][0];
#echo " - ";
#echo $mail[$i][1]."\n";

$i=$i+1;    

$query3="UPDATE users set email='".$raw[0]."' where name rlike'".$raw[1]."'";

echo $query3;

if ($update= mysqli_query($link, $query3)){} else {echo "ERROR";};

    }
echo "\n";




        /* п╬яп╦яп╟п╣п╪ яп╣п╥яп╩яяп╦яяяяп╦п╧ п╫п╟п╠п╬я */
mysqli_free_result($result);



                        
                /* п╥п╟п╨яяп╡п╟п╣п╪ п©п╬п╢п╨п╩яяп╣п╫п╦п╣ */
                    mysqli_close($link);
    ?>