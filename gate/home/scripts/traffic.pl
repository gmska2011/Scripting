#!/usr/bin/perl
use strict;
use DBI;

my $string;
my $db;
my $result;
my $piring;
$db=DBI->connect('DBI:mysql:traffic:localhost','root','uk.rjyfn2009') || die "Error !".$DBI::errstr;

 open(IN,"/sbin/iptables  -L traffic_vpn -v -x -n -Z |")|| die "Cannot open ! $!";
 check_traff("vpn");
 close IN;


 open(IN,"/sbin/iptables  -L total_traff -v -x -n -Z |")|| die "Cannot open ! $!";

while (<IN>){
  if (/^\s+\d/){
    $string=$_ ; 
  }else{
    next;
    
  }    
 my @aaa=count_traff() ;   
 next if ($aaa[1] == 0);
 
 if ($aaa[2] eq "RETURN"){
   if (($aaa[2] eq "RETURN")&& ($aaa[7] eq "0.0.0.0/0")){
  $piring=0;}
else{
  $piring=1;
 }
}

 $result=$db->do("INSERT into total (date,bytes,net,piring) VALUES(now(),\"$aaa[1]\",\"$aaa[7]\",\"$piring\")");
}


 close IN;
   


 open(IN,"/sbin/iptables  -L OUTPUT -v -x -n -Z |")|| die "Cannot open ! $!";

while (<IN>){
  if (/^\s+\d/){
    $string=$_ ; 
  }else{
    next;
    
  }    
 my @aaa=count_traff() ;   
 next if ($aaa[1] == 0);
 
 $result=$db->do("INSERT into net10 (date,bytes) VALUES(now(),\"$aaa[1]\")");
}


 close IN;

#open(IN,"/sbin/iptables -L total_traff -vnxZ | grep dpt:25|")|| die "Cannot open ! $!";
open(IN,"/sbin/iptables -L INPUT -vnxZ | grep dpt:25|")|| die "Cannot open ! $!";

while (<IN>){
  if (/^\s+\d/){
    $string=$_ ; 
  }else{
    next;
    
  }    
 my @aaa=count_traff() ;   
# print $aaa[1]." ".$aaa[7]."2323232\n";

 next if ($aaa[1] == 0);

 $result=$db->do("INSERT into total (date,bytes,net,piring) VALUES(now(),\"$aaa[1]\",\"$aaa[7]\",\"25\")");

# print $aaa[1]." ".$aaa[7]."\n";

}
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