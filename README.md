# DNSTT
wget --no-check-certificate "https://raw.githubusercontent.com/wegare123/dnstt/main/install.sh" -O ~/install.sh && chmod 777 ~/install.sh && ~/./install.sh

# tutorial build dns-client
1. install terlebih dahulu dnstt
2. opkg update && opkg install golang ar wget gcc
3. wget --no-check-certificate "https://www.dropbox.com/s/rdbxsrj0dhbyyi5/dns-client.zip" -O ~/ekstrak.zip && unzip ~/ekstrak.zip && rm -rf ~/ekstrak.zip && cd ~/dns-client && cd dnstt-client
4. ar -rc /usr/lib/libpthread.a
5. go build && mv dnstt-client /usr/bin/dns-client && chmod +x /usr/bin/dns-client && cd ~/ && rm -rf go && opkg remove golang


# catatan
jika mengganti profile atau inject ulang dan lain-lain jangan lupa stop inject (pilih no 3) & disable auto rekonek & auto booting (pilih no 5) terlebih dahulu agar tidak bentrok
