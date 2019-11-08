#!/bin/bash

mount -t cifs //192.168.0.192/nodupdate /mnt/nod/ -o username=muxa,password=456444
rsync -r -t --size-only -l  /mnt/nod/* /home/nodupdate/v6
umount /mnt/nod/
