#!/bin/perl
#$file=`cat /home/COPY/MAIL/p31`
#usl1="From shisharina@neo63.ru  Tue Apr  9 13:09:46 2013"
#usl2="------------CC1792402430E719--"
$usl1='12345';
$usl2='777';
$z = `cat /home/COPY/MAIL/bt`;
$z=~s/$usl1.*/111dfgsdfg/g;

print $z;



#echo $g
