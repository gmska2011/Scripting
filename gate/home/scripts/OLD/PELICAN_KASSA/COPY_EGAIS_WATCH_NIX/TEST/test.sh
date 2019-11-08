#!/bin/sh

cp ./.bashrc_copy ./.bashrc
 
cat ./.bashrc|grep "./watch_proc.exe curl_nix.exe" ||sed -i  "s/.\/wait_nix.exe \&/.\/wait_nix.exe \&\n.\/watch_proc.exe curl_nix.exe '.\/curl_nix.exe \&' \&/g" ./.bashrc


#cat ./.bashrc|grep "killall curl_nix.exe" ||sed -i  "s/killall wait_nix.exe/killall curl_nix.exe\nkillall wait_nix.exe/g" ./.bashrc



#sed -i  "s/killall wait_nix.exe/killall curl_nix.exe\nkillall wait_nix.exe/g" ./.bashrc
#killall wait_nix.exe


