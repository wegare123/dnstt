#!/bin/bash
#dnstt (Wegare)
printf 'ctrl+c' | crontab -e > /dev/null
opkg update && opkg install unzip
cek=$(cat /etc/openwrt_r*)
if [[ $cek == *"LEDE"* ]] && [[ $cek == *"ar71xx"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/lede/ar71xx.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ar71xx/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ar71xx
elif [[ $cek == *"LEDE"* ]] && [[ $cek == *"brcm63xx"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/lede/brcm63xx.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/brcm63xx/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/brcm63xx
elif [[ $cek == *"LEDE"* ]] && [[ $cek == *"ramips"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/lede/ramips.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ramips/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ramips
elif [[ $cek == *"LEDE"* ]] && [[ $cek == *"sunxi"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/lede/sunxi.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/sunxi/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/sunxi
elif [[ $cek == *"Chaos Calmer"* ]] && [[ $cek == *"ar71xx"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/cc/ar71xx.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ar71xx/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ar71xx
elif [[ $cek == *"Chaos Calmer"* ]] && [[ $cek == *"brcm63xx"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/cc/brcm63xx.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/brcm63xx/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/brcm63xx
elif [[ $cek == *"Chaos Calmer"* ]] && [[ $cek == *"ramips"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/cc/ramips.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ramips/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ramips
elif [[ $cek == *"Chaos Calmer"* ]] && [[ $cek == *"sunxi"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/cc/sunxi.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/sunxi/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/sunxi
elif [[ $cek == *"OpenWrt"* ]] && [[ $cek == *"aarch64_cortex-a53"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/openwrt/sunxi.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/sunxi/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/sunxi
elif [[ $cek == *"OpenWrt"* ]] && [[ $cek == *"mips_24kc"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/openwrt/ar71xx.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ar71xx/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ar71xx
elif [[ $cek == *"OpenWrt"* ]] && [[ $cek == *"mipsel_24kc"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/openwrt/ramips.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/ramips/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/ramips
####elif [[ $cek == *"OpenWrt"* ]] && [[ $cek == *"x86"* ]]; then
#wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/openwrt/i386-pentium.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/i386-pentium/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/i386-pentium
elif [[ $cek == *"OpenWrt"* ]] && [[ $cek == *"x86_64"* ]]; then
wget --no-check-certificate "https://github.com/wegare123/backup/blob/main/openwrt/x86_64.zip?raw=true" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && cp ~/x86_64/*.ipk ~/ && rm -rf ~/ekstrak.zip && rm -rf ~/x86_64
else
echo -e "version anda tidak terdeteksi!"
exit
fi
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
chmod +x /usr/share/xray/geoip.dat
chmod +x /usr/share/xray/geosite.dat
opkg install ip-full && opkg install --force-depends *.ipk && opkg install lsof && opkg install fping screen python python3 coreutils-nohup
rm -r ~/*.ipk
rm -r ~/install.sh
mkdir -p ~/akun/
touch ~/akun/dnstt.txt
touch ~/akun/ipmodem.txt 
sleep 2
echo "install selesai"
echo "untuk memulai tools silahkan jalankan perintah 'dnstt'"
				