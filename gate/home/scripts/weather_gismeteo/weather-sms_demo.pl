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

open (OUT,"</tmp/sms/sms.html");
#open (OUT1,">$dir/$page");

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
    $content=~/1(.*?)\ /;
#    print $1;
#    exit;
#    $content=$1;
#    $table=$1;
    print $1;
#    print $1;
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

    
    