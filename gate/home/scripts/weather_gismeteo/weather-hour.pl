#!/usr/bin/perl
#�������� ������� ������
# ����������� � crontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$dir="/home/webkustoshka/html/weather_gon/hour";
$dir1="/home/webkustoshka/html/weather/";
$page="index.html";
$imagedir="/home/html_temp/icons/";


mkdir $dir unless ( -d $dir );

@city=("4429","4618","4448");
#@city=("27890");
open (OUT,">$dir/$page");
#open (OUT1,">$dir1/$page");

my @OUTS=qw(OUT OUT1);
foreach $OUT (@OUTS){
select ($OUT);
print "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">";
print "<html><head>";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF8\">";
#print "</head><body text=\"#000000\" bgcolor=\"#FFFFFF\" link=\"#0000EF\" vlink=\"#51188E\" alink=\"#FF0000\">";
print "</head>";
print "<link rel=\"stylesheet\"  type=\"text/css\"  href=\"reset.css\" />";
print "<link rel=\"stylesheet\"  type=\"text/css\"  href=\"css5.css\" />";

#print "<table border=0 cellpadding=1 cellspacing=2>";
}

select (OUT);
foreach $city (@city){
#    print $city;

    if ($city eq '4429') { $ci='Togliatty'}
        else {if ($city eq '4618') { $ci='Samara'} else { $ci='Sizran'};}
            ;
            

print "<table border=0 cellpadding=1 cellspacing=2>";

    $content=get("http://www.gismeteo.ru/city/legacy/?city=4429") || die "Cannot get URL !";

#    print "$content";
#    exit ;
#    print $content;
#    $content=~/������ ������.*?(\<table.*?\<\/table\>)/s;
#    
    

#    $content=~/frc=\'(<table border\=0 cellpadding\=1 cellspacing\=2.*?<\/table\>\')/s;
#    $content=~/frc=(.*?)/s;
    
#    $content=~/(\<div class=\"city\"\>.*?)\<\/table\>\<div class\=\"b-info-holder\"\>/sg;
##    $content=~/(\<table\>\<tbody\>.*?\<\/tbody\>\<\/table\>\<\/div\>)/sg;
#$content=~/(.*?)/sg;
 $content=~/\<div class=\"pampers\"\>.*?\<table\>(.*?\<\/tbody\>\<\/table\>.*?)\<\/div\>/sg;


#print $table;
#exit;
    $table=$1;
    
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;
    #$table=~s/\<a href.*?\/a>/&nbsp/g;
    #$table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
    #$table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
    #$table=~s/\[&nbsp\]/&nbsp/g;
    

#    print $table;
#    exit ;
    #�������� ������ � ���������� �� � ������� icons

#    $table=~s/\<td rowspan\=\"2\" class\=\"fuckt c0\"\>.*?\<\/td\>/\<td\>Сейчас\<\/td\>/g;
#    $table=$1;

    #print $table ;
    #exit 0;

    @table=$table=~/(.*?gif)/g;
#print $table ;
#exit 0;
#http://i.gismeteo.com/images/icons/old/n.c1.gif
    foreach (@table){
	/\w+\.\w+\.gif/;
#print $_."\n";
	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
    }
    $table=~s/src=\".*?(\w+\.\w+\.gif)\"/src=\"$1\"/g;
    $table=~s/\<a.*?\/a\>//g;


    print "<b>";
        print $ci;
            print "</b>";
            
    
    print $table;
#    if  ($city eq "27890" ) { print OUT1 $table };
    print "<hr>";
    $city1=$city;

}


#print "<td><a href=http://192.168.10.12/weather_gon/hour/".$city1.".html> Click	</a></td>";

print "</body></html>";
#print OUT1  "</body></html>";

    close OUT;
#    close OUT1;