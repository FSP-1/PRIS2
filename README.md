root@nodo1:~# qm config 103
vm 103 - unable to parse value of 'usb0' - format error
host: value does not match the regex pattern
args: -device usb-kbd
bios: ovmf
boot: order=scsi0;ide2;net0
cores: 20
cpu: x86-64-v2-AES
efidisk0: local-lvm:vm-103-disk-0,efitype=4m,ms-cert=2023,pre-enrolled-keys=1,size=4M
ide2: local:iso/ubuntu-24.04.3-live-server-amd64.iso,media=cdrom,size=3226020K
machine: q35
memory: 20480
meta: creation-qemu=10.1.2,ctime=1781683576
name: MCP
net0: virtio=BC:24:11:96:18:29,bridge=vmbr1,firewall=1
numa: 0
ostype: l26
scsi0: local-lvm:vm-103-disk-1,iothread=1,size=110G
scsihw: virtio-scsi-single
smbios1: uuid=1f4c47f0-4682-4764-acce-54a29bf8e8ff
sockets: 1
tablet: 1
vmgenid: ca7e11cf-9f1c-4903-aefc-ec42906c9700
root@nodo1:~# nano /etc/pve/qemu-server/103.conf 
root@nodo1:~# qm stop 103
root@nodo1:~# qm start 103
root@nodo1:~# qm config 103
bios: ovmf
boot: order=scsi0;ide2;net0
cores: 20
cpu: x86-64-v2-AES
efidisk0: local-lvm:vm-103-disk-0,efitype=4m,ms-cert=2023,pre-enrolled-keys=1,size=4M
ide2: local:iso/ubuntu-24.04.3-live-server-amd64.iso,media=cdrom,size=3226020K
machine: q35
memory: 20480
meta: creation-qemu=10.1.2,ctime=1781683576
name: MCP
net0: virtio=BC:24:11:96:18:29,bridge=vmbr1,firewall=1
numa: 0
ostype: l26
scsi0: local-lvm:vm-103-disk-1,iothread=1,size=110G
scsihw: virtio-scsi-single
smbios1: uuid=1f4c47f0-4682-4764-acce-54a29bf8e8ff
sockets: 1
tablet: 1
vmgenid: ca7e11cf-9f1c-4903-aefc-ec42906c9700
root@nodo1:~# qm showcmd 103
/usr/bin/kvm -id 103 -name 'MCP,debug-threads=on' -no-shutdown -chardev 'socket,id=qmp,path=/var/run/qemu-server/103.qmp,server=on,wait=off' -mon 'chardev=qmp,mode=control' -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect-ms=5000' -mon 'chardev=qmp-event,mode=control' -pidfile /var/run/qemu-server/103.pid -daemonize -smbios 'type=1,uuid=1f4c47f0-4682-4764-acce-54a29bf8e8ff' -object '{"id":"throttle-drive-efidisk0","limits":{},"qom-type":"throttle-group"}' -blockdev '{"driver":"raw","file":{"driver":"file","filename":"/usr/share/pve-edk2-firmware//OVMF_CODE_4M.secboot.fd"},"node-name":"pflash0","read-only":true}' -blockdev '{"detect-zeroes":"on","discard":"ignore","driver":"throttle","file":{"cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-103-disk-0","node-name":"ea4dd8ab4d2a796772ccac6d0adf68f","read-only":false},"node-name":"fa4dd8ab4d2a796772ccac6d0adf68f","read-only":false,"size":540672},"node-name":"drive-efidisk0","read-only":false,"throttle-group":"throttle-drive-efidisk0"}' -smp '20,sockets=1,cores=20,maxcpus=20' -nodefaults -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' -vnc 'unix:/var/run/qemu-server/103.vnc,password=on' -cpu qemu64,+aes,enforce,+kvm_pv_eoi,+kvm_pv_unhalt,+pni,+popcnt,+sse4.1,+sse4.2,+ssse3 -m 20480 -object '{"id":"throttle-drive-ide2","limits":{},"qom-type":"throttle-group"}' -object 'iothread,id=iothread-virtioscsi0' -object '{"id":"throttle-drive-scsi0","limits":{},"qom-type":"throttle-group"}' -global 'ICH9-LPC.disable_s3=1' -global 'ICH9-LPC.disable_s4=1' -readconfig /usr/share/qemu-server/pve-q35-4.0.cfg -device 'vmgenid,guid=ca7e11cf-9f1c-4903-aefc-ec42906c9700' -device 'usb-tablet,id=tablet,bus=ehci.0,port=1' -device 'VGA,id=vga,bus=pcie.0,addr=0x1' -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3,free-page-reporting=on' -iscsi 'initiator-name=iqn.1993-08.org.debian:01:9d872247ece6' -blockdev '{"driver":"throttle","file":{"cache":{"direct":false,"no-flush":false},"driver":"raw","file":{"aio":"io_uring","cache":{"direct":false,"no-flush":false},"driver":"file","filename":"/var/lib/vz/template/iso/ubuntu-24.04.3-live-server-amd64.iso","node-name":"ea7cb3d70806554f36ca5e364c22231","read-only":true},"node-name":"fa7cb3d70806554f36ca5e364c22231","read-only":true},"node-name":"drive-ide2","read-only":true,"throttle-group":"throttle-drive-ide2"}' -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=101' -device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1,iothread=iothread-virtioscsi0' -blockdev '{"detect-zeroes":"on","discard":"ignore","driver":"throttle","file":{"cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-103-disk-1","node-name":"e72b86ca87ba6bc7e90fffd586061fc","read-only":false},"node-name":"f72b86ca87ba6bc7e90fffd586061fc","read-only":false},"node-name":"drive-scsi0","read-only":false,"throttle-group":"throttle-drive-scsi0"}' -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,device_id=drive-scsi0,bootindex=100,write-cache=on' -netdev 'type=tap,id=net0,ifname=tap103i0,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' -device 'virtio-net-pci,mac=BC:24:11:96:18:29,netdev=net0,bus=pci.0,addr=0x12,id=net0,rx_queue_size=1024,tx_queue_size=256,bootindex=102,host_mtu=1500' -machine 'pflash0=pflash0,pflash1=drive-efidisk0,hpet=off,type=q35+pve0'
root@nodo1:~# pveversion -v
proxmox-ve: 9.1.0 (running kernel: 6.17.2-2-pve)
pve-manager: 9.1.2 (running version: 9.1.2/9d436f37a0ac4172)
proxmox-kernel-helper: 9.0.4
proxmox-kernel-6.17.2-2-pve-signed: 6.17.2-2
proxmox-kernel-6.17: 6.17.2-2
proxmox-kernel-6.17.2-1-pve-signed: 6.17.2-1
ceph: 19.2.3-pve2
ceph-fuse: 19.2.3-pve2
corosync: 3.1.9-pve2
criu: 4.1.1-1
dnsmasq: 2.91-1
frr-pythontools: 10.4.1-1+pve1
ifupdown2: 3.3.0-1+pmx11
intel-microcode: 3.20250812.1~deb13u1
ksm-control-daemon: 1.5-1
libjs-extjs: 7.0.0-5
libproxmox-acme-perl: 1.7.0
libproxmox-backup-qemu0: 2.0.1
libproxmox-rs-perl: 0.4.1
libpve-access-control: 9.0.4
libpve-apiclient-perl: 3.4.2
libpve-cluster-api-perl: 9.0.7
libpve-cluster-perl: 9.0.7
libpve-common-perl: 9.1.0
libpve-guest-common-perl: 6.0.2
libpve-http-server-perl: 6.0.5
libpve-network-perl: 1.2.3
libpve-rs-perl: 0.11.3
libpve-storage-perl: 9.1.0
libspice-server1: 0.15.2-1+b1
lvm2: 2.03.31-2+pmx1
lxc-pve: 6.0.5-3
lxcfs: 6.0.4-pve1
novnc-pve: 1.6.0-3
proxmox-backup-client: 4.1.0-1
proxmox-backup-file-restore: 4.1.0-1
proxmox-backup-restore-image: 1.0.0
proxmox-firewall: 1.2.1
proxmox-kernel-helper: 9.0.4
proxmox-mail-forward: 1.0.2
proxmox-mini-journalreader: 1.6
proxmox-offline-mirror-helper: 0.7.3
proxmox-widget-toolkit: 5.1.2
pve-cluster: 9.0.7
pve-container: 6.0.18
pve-docs: 9.1.1
pve-edk2-firmware: 4.2025.05-2
pve-esxi-import-tools: 1.0.1
pve-firewall: 6.0.4
pve-firmware: 3.17-2
pve-ha-manager: 5.0.8
pve-i18n: 3.6.5
pve-qemu-kvm: 10.1.2-4
pve-xtermjs: 5.5.0-3
qemu-server: 9.1.1
smartmontools: 7.4-pve1
spiceterm: 3.4.1
swtpm: 0.8.0+pve3
vncterm: 1.9.1
zfsutils-linux: 2.3.4-pve1
root@nodo1:~# journalctl -u pveproxy -n 50
Jun 17 08:42:31 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 08:42:31 nodo1 pveproxy[1974]: worker 2468357 started
Jun 17 08:42:37 nodo1 pveproxy[2468357]: Clearing outdated entries from certificate cache
Jun 17 08:50:14 nodo1 pveproxy[2326810]: worker exit
Jun 17 08:50:15 nodo1 pveproxy[1974]: worker 2326810 finished
Jun 17 08:50:15 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 08:50:15 nodo1 pveproxy[1974]: worker 2470558 started
Jun 17 08:50:23 nodo1 pveproxy[2470558]: Clearing outdated entries from certificate cache
Jun 17 09:09:59 nodo1 pveproxy[2467576]: Clearing outdated entries from certificate cache
Jun 17 09:13:05 nodo1 pveproxy[2468357]: Clearing outdated entries from certificate cache
Jun 17 09:20:25 nodo1 pveproxy[2470558]: Clearing outdated entries from certificate cache
Jun 17 09:26:08 nodo1 pveproxy[2467576]: worker exit
Jun 17 09:26:08 nodo1 pveproxy[1974]: worker 2467576 finished
Jun 17 09:26:08 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 09:26:08 nodo1 pveproxy[1974]: worker 2480736 started
Jun 17 09:26:51 nodo1 pveproxy[2480736]: Clearing outdated entries from certificate cache
Jun 17 09:28:27 nodo1 pveproxy[2468357]: worker exit
Jun 17 09:28:27 nodo1 pveproxy[1974]: worker 2468357 finished
Jun 17 09:28:27 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 09:28:27 nodo1 pveproxy[1974]: worker 2481379 started
Jun 17 09:28:31 nodo1 pveproxy[2481379]: Clearing outdated entries from certificate cache
Jun 17 09:37:17 nodo1 pveproxy[2470558]: worker exit
Jun 17 09:37:17 nodo1 pveproxy[1974]: worker 2470558 finished
Jun 17 09:37:17 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 09:37:17 nodo1 pveproxy[1974]: worker 2483886 started
Jun 17 09:37:23 nodo1 pveproxy[2483886]: Clearing outdated entries from certificate cache
Jun 17 10:09:59 nodo1 pveproxy[2481379]: Clearing outdated entries from certificate cache
Jun 17 10:10:58 nodo1 pveproxy[2483886]: Clearing outdated entries from certificate cache
Jun 17 10:11:10 nodo1 pveproxy[2480736]: Clearing outdated entries from certificate cache
Jun 17 10:25:21 nodo1 pveproxy[2481379]: worker exit
Jun 17 10:25:21 nodo1 pveproxy[1974]: worker 2481379 finished
Jun 17 10:25:21 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 10:25:21 nodo1 pveproxy[1974]: worker 2498389 started
Jun 17 10:27:20 nodo1 pveproxy[2498389]: Clearing outdated entries from certificate cache
Jun 17 10:28:26 nodo1 pveproxy[2480736]: worker exit
Jun 17 10:28:26 nodo1 pveproxy[1974]: worker 2480736 finished
Jun 17 10:28:26 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 10:28:26 nodo1 pveproxy[1974]: worker 2499522 started
Jun 17 10:28:48 nodo1 pveproxy[2498389]: vm 103 - unable to parse value of 'usb' - unknown setting 'usb'
Jun 17 10:28:58 nodo1 pveproxy[2499522]: vm 103 - unable to parse value of 'usb' - unknown setting 'usb'
Jun 17 10:29:26 nodo1 pveproxy[2483886]: vm 103 - unable to parse value of 'usb' - unknown setting 'usb'
Jun 17 10:33:50 nodo1 pveproxy[2483886]: vm 103 - unable to parse value of 'usb0' - format error
                                         host: value does not match the regex pattern
Jun 17 10:34:58 nodo1 pveproxy[2483886]: worker exit
Jun 17 10:34:58 nodo1 pveproxy[1974]: worker 2483886 finished
Jun 17 10:34:58 nodo1 pveproxy[1974]: starting 1 worker(s)
Jun 17 10:34:58 nodo1 pveproxy[1974]: worker 2501840 started
Jun 17 10:35:07 nodo1 pveproxy[2499522]: Clearing outdated entries from certificate cache
Jun 17 10:43:26 nodo1 pveproxy[2499522]: vm 103 - unable to parse value of 'usb0' - format error
                                         host: value does not match the regex pattern
Jun 17 10:43:28 nodo1 pveproxy[2498389]: vm 103 - unable to parse value of 'usb0' - format error
                                         host: value does not match the regex pattern
Jun 17 10:43:39 nodo1 pveproxy[2499522]: proxy detected vanished client connection
root@nodo1:~# qm showcmd 103  --pretty 
/usr/bin/kvm \
  -id 103 \
  -name 'MCP,debug-threads=on' \
  -no-shutdown \
  -chardev 'socket,id=qmp,path=/var/run/qemu-server/103.qmp,server=on,wait=off' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect-ms=5000' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/103.pid \
  -daemonize \
  -smbios 'type=1,uuid=1f4c47f0-4682-4764-acce-54a29bf8e8ff' \
  -object '{"id":"throttle-drive-efidisk0","limits":{},"qom-type":"throttle-group"}' \
  -blockdev '{"driver":"raw","file":{"driver":"file","filename":"/usr/share/pve-edk2-firmware//OVMF_CODE_4M.secboot.fd"},"node-name":"pflash0","read-only":true}' \
  -blockdev '{"detect-zeroes":"on","discard":"ignore","driver":"throttle","file":{"cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":false,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-103-disk-0","node-name":"ea4dd8ab4d2a796772ccac6d0adf68f","read-only":false},"node-name":"fa4dd8ab4d2a796772ccac6d0adf68f","read-only":false,"size":540672},"node-name":"drive-efidisk0","read-only":false,"throttle-group":"throttle-drive-efidisk0"}' \
  -smp '20,sockets=1,cores=20,maxcpus=20' \
  -nodefaults \
  -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
  -vnc 'unix:/var/run/qemu-server/103.vnc,password=on' \
  -cpu qemu64,+aes,enforce,+kvm_pv_eoi,+kvm_pv_unhalt,+pni,+popcnt,+sse4.1,+sse4.2,+ssse3 \
  -m 20480 \
  -object '{"id":"throttle-drive-ide2","limits":{},"qom-type":"throttle-group"}' \
  -object 'iothread,id=iothread-virtioscsi0' \
  -object '{"id":"throttle-drive-scsi0","limits":{},"qom-type":"throttle-group"}' \
  -global 'ICH9-LPC.disable_s3=1' \
  -global 'ICH9-LPC.disable_s4=1' \
  -readconfig /usr/share/qemu-server/pve-q35-4.0.cfg \
  -device 'vmgenid,guid=ca7e11cf-9f1c-4903-aefc-ec42906c9700' \
  -device 'usb-tablet,id=tablet,bus=ehci.0,port=1' \
  -device 'VGA,id=vga,bus=pcie.0,addr=0x1' \
  -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3,free-page-reporting=on' \
  -iscsi 'initiator-name=iqn.1993-08.org.debian:01:9d872247ece6' \
  -blockdev '{"driver":"throttle","file":{"cache":{"direct":false,"no-flush":false},"driver":"raw","file":{"aio":"io_uring","cache":{"direct":false,"no-flush":false},"driver":"file","filename":"/var/lib/vz/template/iso/ubuntu-24.04.3-live-server-amd64.iso","node-name":"ea7cb3d70806554f36ca5e364c22231","read-only":true},"node-name":"fa7cb3d70806554f36ca5e364c22231","read-only":true},"node-name":"drive-ide2","read-only":true,"throttle-group":"throttle-drive-ide2"}' \
  -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=101' \
  -device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1,iothread=iothread-virtioscsi0' \
  -blockdev '{"detect-zeroes":"on","discard":"ignore","driver":"throttle","file":{"cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"raw","file":{"aio":"io_uring","cache":{"direct":true,"no-flush":false},"detect-zeroes":"on","discard":"ignore","driver":"host_device","filename":"/dev/pve/vm-103-disk-1","node-name":"e72b86ca87ba6bc7e90fffd586061fc","read-only":false},"node-name":"f72b86ca87ba6bc7e90fffd586061fc","read-only":false},"node-name":"drive-scsi0","read-only":false,"throttle-group":"throttle-drive-scsi0"}' \
  -device 'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,device_id=drive-scsi0,bootindex=100,write-cache=on' \
  -netdev 'type=tap,id=net0,ifname=tap103i0,script=/usr/libexec/qemu-server/pve-bridge,downscript=/usr/libexec/qemu-server/pve-bridgedown,vhost=on' \
  -device 'virtio-net-pci,mac=BC:24:11:96:18:29,netdev=net0,bus=pci.0,addr=0x12,id=net0,rx_queue_size=1024,tx_queue_size=256,bootindex=102,host_mtu=1500' \
  -machine 'pflash0=pflash0,pflash1=drive-efidisk0,hpet=off,type=q35+pve0'
root@nodo1:~# 
