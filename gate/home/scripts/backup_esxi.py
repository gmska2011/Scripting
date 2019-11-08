#!/usr/bin/python

# author: Paulino Padial
# software-base (dependencies)
#       bazaarvcb:      http://www.magiksys.net/bazaarvcb/index.html

import subprocess
import shutil

#<!--// VARS
# Path to bazaarvcb script
bazaarvcb='/root/bazaarvcb/bazaarvcb'
# Path to Folder where you want to store backups
backupRoot='/home/backup/vm/'
esxiCredentials=['root','cjkjdtq']
# Number of backups to store before do rollUp
rollOut=1

data = dict()                   # ESXI_SERVER   VM1,VM2,VM3
data['vm1.neo.rus'] = []
data['vm1.neo.rus'].append('Terminal10_192.168.0.202')
#data['esxi-server-2'] = []
#data['esxi-serer-2'].append('yourvirtualmachinetobackup')
#data['esxi-serer-2'].append('yourvirtualmachinetobackup2')

#<!--// SCRIPT

# Copy script because bug that binary is corrupted...
# Info: When i use sometimes bazaarvcb binary, this fails with segmentation fault, when i copy from original again
#   all works... this is a workaround
shutil.copy2(bazaarvcb, '/bin/bazaarvcb')

# Do backups
for esxi in data:
        for vm in data[esxi]:
                print "Backing up " + vm + " of " + esxi + "..."
                p = subprocess.Popen([
                                        'bazaarvcb',
                                        'backup',
                                        '-H',
                                        esxi,
                                        '-l','/tmp/esxi-backup-using-script.log',
                                        '-u',
                                        esxiCredentials[0],
                                        '-p',
                                        esxiCredentials[1],
                                        '--roll-out',
                                        str(rollOut),
                                        '--consolidate',
                                        vm,
                                        backupRoot
                                      ],
                                        stdout=subprocess.PIPE,
                                        stderr=subprocess.STDOUT)

                # Real-time command output printing
                for line in iter(p.stdout.readline,''):
                        print line
# //--!>