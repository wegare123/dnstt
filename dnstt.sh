#!/bin/bash
#dnstt (Wegare)
stop () {
host=$(cat /root/akun/jsondnstt.json | grep "Host" | tr '"' ' ' | awk '{print $3}')
route="$(cat /root/akun/ipmodem.txt | grep -i ipmodem | cut -d= -f2 | tail -n1)" 
killall -q badvpn-tun2socks dns-client httping xray
route del 8.8.8.8 gw "$route" metric 0 2>/dev/null
route del "$host" gw "$route" metric 0 2>/dev/null
ip link delete tun1 2>/dev/null
/etc/init.d/dnsmasq restart 2>/dev/null
}
touch /root/akun/jsondnstt.json
ns2="$(cat /root/akun/dnstt.txt | tr '\n' ' '  | awk '{print $1}')" 
udp2="$(cat /root/akun/dnstt.txt | tr '\n' ' '  | awk '{print $2}')"
pubkey2="$(cat /root/akun/server.pub)" 
clear
echo "Inject dnstt by wegare"
echo "1. Sett Profile"
echo "2. Start Inject"
echo "3. Stop Inject"
echo "4. Enable auto booting & auto rekonek"
echo "5. Disable auto booting & auto rekonek"
echo "e. exit"
read -p "(default tools: 2) : " tools
[ -z "${tools}" ] && tools="2"
if [ "$tools" = "1" ]; then

echo "Masukkan NS" 
read -p "default NS: $ns2 : " ns
[ -z "${ns}" ] && ns="$ns2"

echo "Masukkan pubkey" 
read -p "default pubkey: $pubkey2 : " pubkey
[ -z "${pubkey}" ] && pubkey="$pubkey2"

badvpn='tun2socks -tunAddr "10.0.0.1" -tunGw  "10.0.0.2" -tunMask "255.255.255.0" -tunName "tun1" -tunDns "8.8.8.8,8.8.4.4" -proxyType "socks" -proxyServer "127.0.0.1:10808" &'

echo ""
echo "Masukkan config json ke file /root/akun/jsondnstt.json"
read -p "Jika sudah silahkan next"
echo ""

echo "$pubkey" > /root/akun/server.pub
echo "$ns
$udp" > /root/akun/dnstt.txt
cat <<EOF> /usr/bin/gproxy-dnstt
$badvpn
EOF
chmod +x /usr/bin/gproxy-dnstt
echo "Sett Profile Sukses"
sleep 2
clear
/usr/bin/dnstt
elif [ "${tools}" = "2" ]; then
cek="$(cat /root/akun/dnstt.txt)"
if [[ -z $cek ]]; then
echo "anda belum membuat profile"
exit
fi
stop
ipmodem="$(route -n | grep -i 0.0.0.0 | head -n1 | awk '{print $2}')" 
echo "ipmodem=$ipmodem" > /root/akun/ipmodem.txt
host=$(cat /root/akun/jsondnstt.json | grep "Host" | tr '"' ' ' | awk '{print $3}')
ns="$(cat /root/akun/dnstt.txt | tr '\n' ' '  | awk '{print $1}')" 
route="$(cat /root/akun/ipmodem.txt | grep -i ipmodem | cut -d= -f2 | tail -n1)"
nohup dns-client -udp 8.8.8.8:53 -pubkey-file /root/akun/server.pub $ns 127.0.0.1:2222 > /dev/null 2>&1 &
sleep 3
xray run -c /root/akun/jsondnstt.json &
sleep 5
echo ""
echo "is connecting to the internet"
ip tuntap add dev tun1 mode tun
ifconfig tun1 10.0.0.1 netmask 255.255.255.0
/usr/bin/gproxy-dnstt
route add "$host" gw "$route" metric 0
route add default gw 10.0.0.2 metric 0
sleep 1
route add 8.8.8.8 gw "$route" metric 0

echo '
#!/bin/bash
#dnstt (Wegare)
httping m.google.com' > /usr/bin/ping-dnstt
chmod +x /usr/bin/ping-dnstt
/usr/bin/ping-dnstt > /dev/null 2>&1 &
elif [ "${tools}" = "3" ]; then
stop
echo "Stop Suksess"
sleep 2
clear
/usr/bin/dnstt
elif [ "${tools}" = "4" ]; then
cat <<EOF>> /etc/crontabs/root

# BEGIN AUTOREKONEKDNSTT
*/1 * * * *  autorekonek-dnstt
# END AUTOREKONEKDNSTT
EOF
sed -i '/^$/d' /etc/crontabs/root 2>/dev/null
/etc/init.d/cron restart
echo "Enable Suksess"
sleep 2
clear
/usr/bin/dnstt
elif [ "${tools}" = "5" ]; then
sed -i "/^# BEGIN AUTOREKONEKDNSTT/,/^# END AUTOREKONEKDNSTT/d" /etc/crontabs/root > /dev/null
/etc/init.d/cron restart
echo "Disable Suksess"
sleep 2
clear
/usr/bin/dnstt
elif [ "${tools}" = "e" ]; then
clear
exit
else 
echo -e "$tools: invalid selection."
exit
fi