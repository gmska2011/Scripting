#!/usr/bin/perl
#чЩДЙТБЕФ РТПЗОПЪ РПЗПДЩ
# чУФБЧМСЕФУС Ч crontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;

$dir="/var/www/apache2/html/weather_gon/";
$dir1="/var/www/apache2/html/weather/";
$page="index.html";
$imagedir="/home/html_temp/icons/";


mkdir $dir unless ( -d $dir );

@city=("27890","28900","27983");
#@city=("27890");
open (OUT,">$dir/$page");
open (OUT1,">$dir1/$page");

my @OUTS=qw(OUT OUT1);
foreach $OUT (@OUTS){
select ($OUT);
print "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">";
print "<html><head>";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">";
print "</head><body text=\"#000000\" bgcolor=\"#FFFFFF\" link=\"#0000EF\" vlink=\"#51188E\" alink=\"#FF0000\">";
}

select (OUT);
foreach $city (@city){
#    print $city;
    $content=get("http://www.gismeteo.ru/ztowns/$city.htm") || die "Cannot get URL !";
#    print "$content";
#    exit ;
#    print $content;
#    $content=~/Другие города.*?(\<table.*?\<\/table\>)/s;
#    
    

    $content=~/frc=\'(<table border\=0 cellpadding\=1 cellspacing\=2.*?<\/table\>\')/s;
    $table=$1;
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;
    $table=~s/\<a href.*?\/a>/&nbsp/g;
    $table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
    $table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
    $table=~s/\[&nbsp\]/&nbsp/g;
    

#    print $table;
#    exit ;
    #рПМХЮБЕН ЙЛПОЛЙ Й ЪБРЙУЩЧБЕН ЙИ Ч ЛБФБМПЗ icons
#    $table=$1;

    #print $table ;
    #exit 0;

    @table=$table=~/(http.*?gif)/g;

    foreach (@table){
	/\w+\.gif/;
	#print $_."\n";
	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
    }
    $table=~s/src=\".*?(\w+\.gif)\"/src=\"$1\"/g;
    $table=~s/\<a.*?\/a\>//g;

    
    print $table;
    if  ($city eq "27890" ) { print OUT1 $table };
    print "<hr>";
    $city1=$city;

}


print "<td><a href=http://192.168.10.12/weather_gon/hour/".$city1.".html> Click	</a></td>";

print "</body></html>";
print OUT1  "</body></html>";

    close OUT;
    close OUT1;