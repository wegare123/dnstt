#!/bin/bash
#dnstt (Wegare)
printf 'ctrl+c' | crontab -e > /dev/null
opkg update
cek2=$(opkg list-installed | grep dnsmasq-full | awk '{print $1}')
if [ $cek2 = "dnsmasq-full" ]; then
echo > /dev/null
else
opkg remove dnsmasq && opkg install dnsmasq-full
fi
mkdir -p /usr/share/xray/
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/dnstt/main/dnstt.sh" -O /usr/bin/dnstt
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/dnstt/main/autorekonek-dnstt.sh" -O /usr/bin/autorekonek-dnstt
wget --no-check-certificate "https://github.com/wegare123/dnstt/blob/main/dns-client-v19?raw=true" -O /usr/bin/dns-client
wget --no-check-certificate "https://github.com/wegare123/vless/blob/main/xray?raw=true" -O /usr/bin/xray
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vmt/main/geoip.dat" -O /usr/share/xray/geoip.dat
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/vmt/main/geosite.dat" -O /usr/share/xray/geosite.dat
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/tun2socks?raw=true" -O /usr/bin/tun2socks
chmod +x /usr/bin/dnstt
chmod +x /usr/bin/dns-client
chmod +x /usr/bin/autorekonek-dnstt
chmod +x /usr/bin/xray
chmod +x /usr/bin/tun2socks
chmod +x /usr/share/xray/geoip.dat
chmod +x /usr/share/xray/geosite.dat
opkg install httping coreutils-nohup ip-full 
rm -r ~/install.sh
mkdir -p ~/akun/
touch ~/akun/dnstt.txt
touch ~/akun/ipmodem.txt 
sleep 2
echo "install selesai"
echo "untuk memulai tools silahkan jalankan perintah 'dnstt'"
				