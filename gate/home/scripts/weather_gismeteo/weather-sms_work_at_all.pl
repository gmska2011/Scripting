#!/usr/bin/perl
#Выдирает прогноз погоды
# Вставляется в crontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$dir="/tmp/sms/";
$page="sms.html";
$imagedir="/var/www/apache2/html/weather_gon/sms/";


mkdir $dir unless ( -d $dir );

open (OUT,"</var/www/apache2/html/weather_gon/index.html");
open (OUT1,">/tmp/sms/sms.html");

#my @OUTS=qw(OUT OUT1);
#foreach $OUT (@OUTS){
#select ($OUT);
#}

#select (OUT);
#foreach $city (@city){
#    print $city;
#    $content=get("http://192.168.10.12/weather_gon/hour/index.html") || die "Cannot get URL !";
     $content=<OUT> || die "Cannot get URL !";
#    print "$content";
#    exit ;
#    print $content;
#    exit;
#    $content=~/дПСЦХЕ ЦНПНДЮ.*?(\<table.*?\<\/table\>)/s;
#    
     $content=~/\<span class\=City\>\&nbsp\;(.*?)\<\/span\>/;

     $gorod=$1;
     $content=~/\<\/td\>\<td nowrap align\=center bgcolor\=\#F0F0F0\>(.*?)\<span/;
     $day1=$1;
     $content=~/\<\/td\>\<td nowrap align\=center bgcolor\=\#F0F0F0\>.*?<span class=sml>(.*?)\<\/span\>/;
     $day1_1=$1;
     
     $content=~/\<\/td\>\<\/tr\>\<tr\>\<td bgcolor\=\#FFFFFF\>(.*?)\<\/td\>/;
     $obl=$1; 
     
     $content=~/width=40 height=40 alt=\"(.*?)\"/;
     $obl1=$1;
     $content=~/\"\>\<\/td\>\<\/tr\>\<tr\>\<td bgcolor\=\#F0F0F0\>(.*?)\<\/td\>\<td/;
     $osadki=$1;
     
     $content=~/\<img src\=.*? width\=40 height\=20 alt\=\"(.*?)\"/;
     $osadki1=$1;
     
     $content=~/\&deg\;C\<\/td\>\<td align\=center bgcolor\=\#FFF000\>(.*?)\<\/td\>/;
     $temp1=$1;
     $content=~/\#F0F0FF\>.*?\,\&deg\;C\<\/td\>\<td align\=center bgcolor\=\#FFFF00\>(.*?)\<\/td\>/;
     $temp2=$1;
#    print $1;
#    exit;
#    $content=$1;
#    $table=$1;
    #print $gorod, "\n" , $day1 , $day1_1, " ", $obl, ": ", $obl1," ", $osadki, ": ", $osadki1," ", $temp1, " ", $temp2;
    $h=(print $gorod, "\n" , $day1 , $day1_1, " ", $obl, ": ", $obl1," ", $osadki, ": ", $osadki1," ", $temp1, " ", $temp2, "  ");
#    print $h;
 


select (OUT1);
#print "dgdfgdsf";
print $gorod, "\n" , $day1 , $day1_1, " ", $obl, ": ", $obl1," ", $osadki, ": ", $osadki1," ", $temp1, " ", $temp2, "  ";
close OUT1;    
#!/bin/sh    

#    mail -s $h 79277759641@sms.mgsm.ru; 
#    $table=$content;
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;
    #$table=~s/\<a href.*?\/a>/&nbsp/g;
    #$table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
    #$table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
    #$table=~s/\[&nbsp\]/&nbsp/g;
    

#    print $table;
#    exit ;
    #Получаем иконки и записываем их в каталог icons
#    $table=$1;

    #print $table ;
    #exit 0;

    #@table=$table=~/(http.*?gif)/g;

#    foreach (@table){
#	/\w+\.gif/;
	#print $_."\n";
#	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
#    }
#    $table=~s/src=\".*?(\w+\.gif)\"/src=\"$1\"/g;
#    $table=~s/\<a.*?\/a\>//g;

    
#    print $table;
#    if  ($city eq "27890" ) { print OUT1 $table };
#    print "<hr>";

#}    

 #  print $content;

    
    