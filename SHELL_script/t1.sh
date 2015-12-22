#! /bin/sh

iw list|grep '* AP'
[ $? -ne 0 ] && echo "No device support AP mode." && exit


#系统打开转发功能
sudo sysctl -w net.ipv4.ip_forward=1

#配置hostapd
sudo cat > /etc/hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=csitool
hw_mode=g
channel=6
#channel=5
auth_algs=1
#auth_algs=3
max_num_sta=255


logger_syslog=-1
logger_syslog_level=2
logger_stdout=-1
logger_stdout_level=2
#acs_num_scans=5
beacon_int=100

#start_disabled
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0

dtim_period=2

rts_threshold=2347
fragm_threshold=2346


wmm_enabled=1
wmm_ac_bk_cwmin=4
wmm_ac_bk_cwmax=10
wmm_ac_bk_aifs=7
wmm_ac_bk_txop_limit=0
wmm_ac_bk_acm=0

wmm_ac_be_aifs=3
wmm_ac_be_cwmin=4
wmm_ac_be_cwmax=10
wmm_ac_be_txop_limit=0
wmm_ac_be_acm=0

wmm_ac_vi_aifs=2
wmm_ac_vi_cwmin=3
wmm_ac_vi_cwmax=4
wmm_ac_vi_txop_limit=94
wmm_ac_vi_acm=0

wmm_ac_vo_aifs=2
wmm_ac_vo_cwmin=2
wmm_ac_vo_cwmax=3
wmm_ac_vo_txop_limit=47
wmm_ac_vo_acm=0

ieee80211n=1
own_ip_addr=127.0.0.1

ignore_broadcast_ssid=0

#radius_acct_interim_interval=600

ht_capab=SHORT-GI-40

macaddr_acl=0
#
# 如果需要开启密码，wpa=1。
wpa=0
wpa_passphrase=yc12345678
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
#wpa_group_rekey=6000
ap_table_max_size=255
EOF

#配置dns
sudo cat > /etc/dnsmasq.conf << EOF
interface=wlan0
bind-interfaces
except-interface=lo
dhcp-range=192.168.10.100,192.168.10.199,6h
dhcp-option=3,192.168.10.1
dhcp-option=6,8.8.8.8
EOF

#编辑启动脚本
# 为无线添加路由规则
#iptables -F
#iptables -X
#iptables -t nat -F
#iptables -t nat -X
#iptables -t nat -A POSTROUTING -s 192.168.10.0/24 -o eth0 -j MASQUERADE
#iptables -A FORWARD -s 192.168.10.0/24 -o eth0 -j ACCEPT
#iptables -A FORWARD -d 192.168.10.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -i eth0 -j ACCEPT
#dnsmasq与named一般情况下bind的named会占了53端口，
#  然后dnsmasq会启动不了，所以我用killall named来杀了named再启动dnsmasq。

# TBC#
sudo ifconfig wlan0 192.168.0.2 netmask 255.255.255.0
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
# TBC#
killall hostapd
sudo killall dnsmasq
# ifconfig wlan0 192.168.10.1
#“-B”后台运行,之后的hostapd.conf需要指名路径.
hostapd -d /etc/hostapd.conf
sudo /etc/init.d/dnsmasq restart
# dnsmasq启动后会出现电脑突然上不了网，
# 因为dnsmasq更改了/etc/resolv.conf的原因。可以在/etc/resolv.conf加一行
# nameserver x.x.x.x
#填入DNS服务器地址，根据自己的情况修改。
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

