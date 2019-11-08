#!/usr/bin/perl
#���� �������
# �������crontab
use LWP::Simple;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use CGI qw /:standard/;
use locale;


print header(-charset=>'Windows-1251',-expires=>'-1d');
print start_html();







$dir="/var/www/html/prikol/";
$dir1="/var/www/html/weather/";
$page="index.html";
$imagedir="/var/www/html/prikol/";


mkdir $dir unless ( -d $dir );


#@city=("27890");



#print "<!doctype html public \"-//w3c//dtd html 4.0 transitional//en\">";
#print "<html><head>";
#print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">";
#print "</head>
print "<body align=\"center\">\n";

$time=localtime;
#$f=$time=~s/.*?\s.*?\s.*?\s.\d?:.\d?//;
#print $f;
print "<em> $time </\em> <br><br>";

#    print $city;
    $random=int(rand(1400)+1);
    #$content=get("http://prikol.i.ua/lenta/picture/?p=$random") || die "Cannot get URL !";
#    $content=get("http://prikol.i.ua/lenta/picture/?p=1") || die "Cannot get URL !";
#    print "$content";
#    exit ;
#    print $content;
#    $content=~/��� ���.*?(\<table.*?\<\/table\>)/s;

#    
#    $content=~/.*?/s;
    $table=$1;
    @name=$content=~/\<div class=\"larger bold\"\>(.*?)\<\/div\>/sg; 
#    print @name;
#    exit;
#    $table=~s/\<span class=City.*?\/span\>/&nbsp/g;
#   $table=~s/\<a href.*?\/a>/&nbsp/g;
#    $table=~s/\<a target\=_blank.*?\/a>/&nbsp/g;
#    $table=~s/\(\<b\>.*?UTC\)/&nbsp/g;
#    $table=~s/\[&nbsp\]/&nbsp/g;
    

#    print $table;
#    exit ;
    #���� ��� ������ � �����icons
#    $table=$1;

    #print $table ;
    #exit 0;

    @table=$content=~/(http\:\/\/i.i.ua\/prikol\/.*?.jpg)/g;
    #print @table;
    $i=0;
    foreach (@table){
	/\w+\.jpg/;
	$pic=$_;
#	print $_."\n";
	$aaa=getstore($_,"$dir$&") unless (-e "$dir$&");
	$pic=~/(\d+\.jpg)/;
	#print name;
        print "\<strong\>$name[$i]\n\<\/strong\><br><br>";
	print " <img align=\"center\" src=\"http://192.168.10.12/prikol/$1\"><br><br>\n";
        print "<img height=5 width=\"80\%\" src=\"http://192.168.10.12/prikol/$1\"><br><br><br>";	
	$i+=1;
#        $table=~s/src=\".*?(\w+\.jpg)\"/src=\"$1\"/g;	
    }
    
    print "$time";
    print "<\/body>";
    print end_html();
    
#    $table=~s/src=\".*?(\w+\.jpg)\"/src=\"$1\"/g;
#    $table=~s/\<a.*?\/a\>//g;
#    print "<img src=\"$1\"><br>";
#print "</body></html>";
    
#    print $table;
#    if  ($city eq "27890" ) { print OUT1 $table };


#print "</body></html>";
