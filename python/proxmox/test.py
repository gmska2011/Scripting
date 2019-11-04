from proxmoxer import ProxmoxAPI
proxmox = ProxmoxAPI('10.63.0.11', user='root@pam',
                     password='uk.rjyfn', verify_ssl=False)

#print(proxmox.cluster.resources.get(type='vm'))
for vm in proxmox.cluster.resources.get(type='vm'):
    try:
        print("{0}. {1} => {2}" .format(vm['vmid'], vm['name'], vm['status']))
    except:
        pass