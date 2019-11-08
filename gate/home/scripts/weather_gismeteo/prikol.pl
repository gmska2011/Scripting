#!/usr/bin/perl


#пїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
# пїЅпїЅпїЅпїЅпїЅпїЅпїЅcrontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;



$dir="/home/webkustoshka/html/prikol/";
$dir1="/home/webkustoshka/html/weather/";
$page="index.html";
$imagedir="/home/webkustoshka/html/prikol/";


mkdir $dir unless ( -d $dir );

@city=("27890");
#@city=("27890");
open (OUT,">$dir/$page");
open (OUT1,">$dir1/$page");

my @OUTS=qw(OUT OUT1);
foreach $OUT (@OUTS){
select ($OUT);
print "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">";
print "<html><head>";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">";
print "</head><body align=\"center\" text=\"#000000\" bgcolor=\"#FFFFFF\" link=\"#0000EF\" vlink=\"#51188E\" alink=\"#FF0000\">\n";
print "<br><a href=\"http://www.kustoshka.rus\">На главную страницу<\/a>  <br><br>";

}

select (OUT);
foreach $city (@city){
#    print $city;
    $random=int(rand(1400)+1);
    $content=get("http://prikol.i.ua/lenta/picture/?p=1") || die "Cannot get URL !";
#    print "$content";
#    exit ;
#    print $content;
#    $content=~/пїЅпїЅпїЅ пїЅпїЅпїЅ.*?(\<table.*?\<\/table\>)/s;

#    
#    $content=~/.*?/s;
    $table=$1;
    @name=$content=~/(\<div class=\"caption_border borderT\"\>.*?\<\/div\>.*?\<\/div\>)/sg; 
    print @name;
    exit;
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;
#   $table=~s/\<a href.*?\/a>/&nbsp/g;
#    $table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
#    $table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
#    $table=~s/\[&nbsp\]/&nbsp/g;
    

#    print $table;
#    exit ;
    #пїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅicons
#    $table=$1;

    #print $table ;
    #exit 0;

    @table=$content=~/(http\:\/\/i1.i.ua\/.*?.jpg)/g;
    print @table;
    
    $i=0;
    foreach (@table){
	/\w+\.jpg/;
	$pic=$_;
	print $_."\n";
	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
	$pic=~/(\d+\.jpg)/;
	print name;
        print "\<strong\>$name[$i]\n\<\/strong\><br><br>";
	print " <img src=\"$1\"><br><br>\n";
	 print "<img height=5 width=\"80\%\" src=\"$1\"><br><br><br>";	
	$i+=1;
#        $table=~s/src=\".*?(\w+\.jpg)\"/src=\"$1\"/g;	
    }
#    $table=~s/src=\".*?(\w+\.jpg)\"/src=\"$1\"/g;
#    $table=~s/\<a.*?\/a\>//g;
#    print "<img src=\"$1\"><br>";

    
#    print $table;
#    if  ($city eq "27890" ) { print OUT1 $table };
    print "<tr height=40 width=\"30\%\">";

}    
print "<br><a href=\"http://www.kustoshka.rus\">На главную страницу<\/a>  ";
print "</body></html>";
print OUT1  "</body></html>";

    close OUT;
    close OUT1;
    