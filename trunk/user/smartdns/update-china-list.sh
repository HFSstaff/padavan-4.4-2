#/bin/sh

mkdir -p /tmp/smartdns/

wget -O /tmp/smartdns/china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
wget -O /tmp/smartdns/apple.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf
wget -O /tmp/smartdns/google.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf
#wget -O /tmp/smartdns/ad.conf https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf

#合并
cat /tmp/smartdns/apple.conf >> /tmp/smartdns/china.conf 2>/dev/null
cat /tmp/smartdns/google.conf >> /tmp/smartdns/china.conf 2>/dev/null

#删除不符合规则的域名
sed -i "s/^server=\/\(.*\)\/[^\/]*$/nameserver \/\1\/china/g;/^nameserver/!d" /tmp/smartdns/china.conf 2>/dev/null
#sed -i "s/^server=\/\(.*\)\/[^\/]*$/domain-rules \/\1\/ -c tcp:80,tcp:443 -n china -d yes/g;/^domain-rules/!d" /tmp/smartdns/china.conf 2>/dev/null

fsz=`stat -c %s /tmp/smartdns/china.conf 2>/dev/null`

if [ -n "$fsz" ] && [ $fsz -ge 1000000 ] ; then

	mv -f /tmp/smartdns/china.conf  /etc/storage/smartdns-domains.china.conf
	#mv -f /tmp/smartdns/ad.conf   /etc/storage/anti-ad-smartdns.conf

	killall smartdns

	sleep 8

	restart_dhcpd

	restart_dns

	rm -rf /tmp/smartdns.cache

	smartdns -c /etc_ro/smartdns_custom.conf

	#smartdns -c /etc/storage/smartdns_custom.conf

	mtd_storage.sh save >/dev/null 2>&1
	
	logger -st "smartdns" "China-list Update Done"
	
else
	
	logger -st "smartdns" "China-list Download Failed"

fi

rm -rf /tmp/smartdns/
