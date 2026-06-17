root@nodo1:~# qm vncproxy 103
LC_PVE_TICKET not set, VNC proxy without password is forbidden
root@nodo1:~# grep -iE "vnc|keyboard|mouse|input" /var/lo
local/ lock/  log/   
root@nodo1:~# grep -iE "vnc|keyboard|mouse|input" /var/log/
alternatives.log       ceph/                  frr/                   pve/                   pve-firewall.log.4.gz  runit/
alternatives.log.1     chrony/                ifupdown2/             pveam.log              pve-firewall.log.5.gz  samba/
alternatives.log.2.gz  corosync/              journal/               pve-firewall.log       pve-firewall.log.6.gz  vzdump/
apt/                   dpkg.log               lastlog                pve-firewall.log.1     pve-firewall.log.7.gz  wtmp
btmp                   dpkg.log.1             lxc/                   pve-firewall.log.2.gz  pveproxy/              wtmp.db
btmp.1                 fontconfig.log         private/               pve-firewall.log.3.gz  README                 wtmp.db.1
root@nodo1:~# grep -iE "vnc|keyboard|mouse|input" /var/log/
alternatives.log       ceph/                  frr/                   pve/                   pve-firewall.log.4.gz  runit/
alternatives.log.1     chrony/                ifupdown2/             pveam.log              pve-firewall.log.5.gz  samba/
alternatives.log.2.gz  corosync/              journal/               pve-firewall.log       pve-firewall.log.6.gz  vzdump/
apt/                   dpkg.log               lastlog                pve-firewall.log.1     pve-firewall.log.7.gz  wtmp
btmp                   dpkg.log.1             lxc/                   pve-firewall.log.2.gz  pveproxy/              wtmp.db
btmp.1                 fontconfig.log         private/               pve-firewall.log.3.gz  README                 wtmp.db.1
root@nodo1:~# grep -iE "vnc|keyboard|mouse|input" /var/log/
alternatives.log       ceph/                  frr/                   pve/                   pve-firewall.log.4.gz  runit/
alternatives.log.1     chrony/                ifupdown2/             pveam.log              pve-firewall.log.5.gz  samba/
alternatives.log.2.gz  corosync/              journal/               pve-firewall.log       pve-firewall.log.6.gz  vzdump/
apt/                   dpkg.log               lastlog                pve-firewall.log.1     pve-firewall.log.7.gz  wtmp
btmp                   dpkg.log.1             lxc/                   pve-firewall.log.2.gz  pveproxy/              wtmp.db
btmp.1                 fontconfig.log         private/               pve-firewall.log.3.gz  README                 wtmp.db.1
root@nodo1:~# lsmod | egrep 'vfio|kvm'
kvm_intel             532480  22
kvm                  1376256  21 kvm_intel
irqbypass              16384  1 kvm
root@nodo1:~# cat /proc/cmdline 
BOOT_IMAGE=/boot/vmlinuz-6.17.2-2-pve root=/dev/mapper/pve-root ro quiet
root@nodo1:~# qm config 10
101  102  103  
root@nodo1:~# qm config 10
101  102  103  
root@nodo1:~# qm config 101
bios: ovmf
boot: order=virtio0;ide2;net0
cores: 2
cpu: host
efidisk0: vm-pool:vm-101-disk-0,efitype=4m,ms-cert=2023,pre-enrolled-keys=1,size=528K
ide2: none,media=cdrom
machine: q35
memory: 4096
meta: creation-qemu=10.1.2,ctime=1765881851
name: ubuntu-server
net0: virtio=BC:24:11:18:EB:C3,bridge=vmbr1,firewall=1
numa: 0
ostype: l26
scsihw: virtio-scsi-single
smbios1: uuid=054b0a94-837f-4801-a10f-effd0994d256
sockets: 1
virtio0: vm-pool:vm-101-disk-1,cache=directsync,iothread=1,size=32G
vmgenid: b9c2b9ad-c5e4-464b-8bb9-a6e9ede7f023
root@nodo1:~# 
