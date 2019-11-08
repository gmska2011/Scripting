#!/bin/bash
#rsync -r -t --size-only --delete -l -e="ssh -p 22122 -i /etc/ssh/ssh_host_dsa_key" --exclude-from='/home/scripts/rsync_excludes_sync_nod' /home/share/nodupd root@192.168.0.4:/home/nodupdate

HOST="10.0.10.63"
USER="nod"
PASS="nod"
LCD="/home/nodupdate"
lftp -c "set ftp:list-options -a;
open ftp://$USER:$PASS@$HOST; 
lcd $LCD;
mirror --reverse \
       --delete \
              --verbose \
                            --exclude-glob khy \
                                          "
 exit 0
