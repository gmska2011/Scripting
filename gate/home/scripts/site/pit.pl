#!/usr/bin/perl
#ڄʒԠђЇϏڠяȏř
# Ԕ͑Ɣԑ נcrontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
no warnings 'layer';

$dir="/home/web/public_html/pit/";
$page="index.html";
$imagedir="/home/web/public_html/pit/icons/";
use POSIX qw(strftime);

my $date = strftime "%d.%m.%Y", localtime;
print $date;

mkdir $dir unless ( -d $dir );

@city=("70");
#@city=("toljati");
#binmode (OUT,">$dir/$page",":utf8");
open (OUT,">$dir/$page");
#open (OUT1,">$dir1/$page");

my @OUTS=qw(OUT OUT1);
foreach $OUT (@OUTS){
select ($OUT);
print "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">";
print "<html><head>";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF8\">";
print "<title>Питание. Шк.№70</title>";
print "</head><body text=\"#000000\" bgcolor=\"#FFFFFF\" link=\"#0000EF\" vlink=\"#51188E\" alink=\"#FF0000\">";
print "</head>";
print "<link rel=\"stylesheet\"  type=\"text/css\"  href=\"reset.css\" />";
print "<link rel=\"stylesheet\"  type=\"text/css\"  href=\"styles.css\" />";

#print "<table border=0 cellpadding=1 cellspacing=2>";
}

select (OUT);
foreach $city (@city){
#    print $city;

#    if ($city eq 'toljati') { $ci='ТОЛЬЯТТИ'}
#        else {if ($city eq 'samara') { $ci='САМАРА'} else { $ci='СЫЗРАНЬ'};}
#            ;
#    if ($city eq 'toljati') { $ci='tlt.png'}
#        else {if ($city eq 'samara') { $ci='smr.png'} else { $ci='szn.png'};}
#            ;
            
		 
print "<table border=0 cellpadding=1 cellspacing=2>";
		 
    $content=get("http://pitanie-tlt.ru/pmenu/ou/418/date/$date") || die "Cannot get URL !";

#    print "$content";
#    exit ;
#    print $content;
#    $content=~/Ű䩥 䯰怒.*?(\<table.*?\<\/table\>)/s;
#    
    

#    $content=~/frc=\'(<table border\=0 cellpadding\=1 cellspacing\=2.*?<\/table\>\')/s;
#    $content=~/frc=(.*?)/s;
    
#    $content=~/(\<div class=\"city\"\>.*?)\<\/table\>\<div class\=\"b-info-holder\"\>/sg;
##    $content=~/(\<table\>\<tbody\>.*?\<\/tbody\>\<\/table\>\<\/div\>)/sg;
#$content=~/(.*?)/sg;
 #$content=~/\<div class=\"pampers\"\>.*?\<table\>(.*?\<\/tbody\>\<\/table\>.*?)\<\/div\>/sg;

#$content=~/\<\/script\>\<\/td\>(\<td.*?)\<\/div\>/sg;
$content=~/(\<div class=pmenu_ou_name\>.*?)\<div class="clear"\> \<\/div\>/sg;
#$content=~s/\<h3\>/\<h2\>/g;
#$content=~/\<div class=\"pampers\"\>.*?\<table\>(.*?\<\/tbody\>\<\/table\>.*?)\<\/div\>/sg;

$table=$1;

#print $table;
#exit;
#print $content;
#    $table=$1;
    
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;

#    $table=~s/\<h3\>/\<h2\>/g;
    #$table=~s/\<a href.*?\/a>/&nbsp/g;
    #$table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
    #$table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
#    $table=~/(\<td align\=center\>.*?\<\/td\>)/sg;  
#    $dd=$1;
    
#    $table=~s/$dd/\<td align\=center\>\<\/td\>$dd/g;

#    $table=~/(\<tr height\=41\>.*?\<\/tr\>)/sg;  
#    $dd2=$1;
    
#    $table=~s/$dd2//g;
#    $table=~s/\<td background\=.*?\<\/td\>//g;
#    $table=~s/bgcolor\=\"\#6699FF\"//g;
#    $table=~s/Суббота/\<font color\=red\>Cуббота/g;
#    $table=~s/Воскресенье/\<font color\=red\>Воскресенье/g;
#    $table=~s/height\=40 width\=40/height\=100%/g;
#    $table=~s/height\=50/height\=20/g;
#    $table=~s/\&nbsp\;//g;
#    $table=~s/Атмосферное давление/Атм.давл./g;
    

#    print $table;
#    exit ;
    #Ќ֞͠ʋЎ̉ ɠہщԙ؁ƍ ʈ נ́Ձ͏Ǡicons

#    $table=~s/\<td rowspan\=\"2\" class\=\"fuckt c0\"\>.*?\<\/td\>/\<td\>Сейчас\<\/td\>/g;
#    $table=$1;

#    print $table ;
    #exit 0;

#    @table=$table=~/(.*?gif)/g;
#print $table ;
#exit 0;
#http://i.gismeteo.com/images/icons/old/n.c1.gif
#    foreach (@table){
#	/\w+\.\w+\.gif/;
#print $_."\n";
#	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
#    }
#    $table=~s/src=\".*?(\w+\.\w+\.gif)\"/src=\"$1\"/g;
#    $table=~s/\<a.*?\/a\>//g;

#    print "<table>";

#    print "<b>";
#print "Меню в Школе №".$city;
        #print $ci;
#	print "<img height=70 src=/images/";
#	print $ci;
#	 print ">";
#            print "</b>";
            print "<br>";
    
#    print $content;
    print $table;
#    if  ($city eq "27890" ) { print OUT1 $table };
#print "<img align=right src=/images/logo_weather.png>";
print "<br>";
#    print "<hr size=4>";
#    $city1=$city;

#}


#print "<td><a href=http://192.168.10.12/weather_gon/hour/".$city1.".html> Click	</a></td>";

print "</body></html>";

close OUT;
}