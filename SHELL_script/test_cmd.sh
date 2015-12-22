time=$(date +%y%m%d-%H%M%S)
mkdir data/${time}
sudo /home/wifitest/linux-80211n-csitool-supplementary/netlink/log_to_file ~/Documents/zw/data/${time}/csi.dat &
iperf -s -i 0.5 -u| tee ~/Documents/zw/data/${time}/iperf.dat &
