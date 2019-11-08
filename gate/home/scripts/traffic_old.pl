#!/usr/bin/perl
use strict;
use DBI;

my $string;
my $db;
my $result;

$db=DBI->connect('DBI:mysql:traffic:localhost','traffuser','traff') || die "Error !".$DBI::errstr;

 open(IN,"/sbin/iptables  -L traffic_vpn -v -x -n -Z |")|| die "Cannot open ! $!";
 check_traff("vpn");
 close IN;
   
   
 $db->disconnect;
 exit 0;
      
#============================  
sub count_traff{
  my @bbb=split(" ",$string);
  return @bbb ;
} 
	
sub check_traff{
my $flag=$_[0];
while (<IN>){
  if (/^\s+\d/){
    $string=$_ ; 
  }else{
    next;
  }    
 my @aaa=count_traff() ;   
 if ($aaa[9]){
   $aaa[9]=(split(/:/,$aaa[9]))[1];
 }
 $aaa[9]="vpn" if ($flag eq "vpn");    
 $result=$db->do("INSERT into traff (bytes,proto,sip,dip,port) VALUES(\"$aaa[1]\",\"$aaa[2]\",\"$aaa[6]\",\"$aaa[7]\",\"$aaa[9]\")") if ($aaa[1]!=0);    
}
}