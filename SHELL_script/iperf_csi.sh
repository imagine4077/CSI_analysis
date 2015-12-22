time=$(date +%y%m%d-%H%M%S)
mkdir ./${time}
echo ${time}
#sudo /home/wifitest/linux-80211n-csitool-supplementary/netlink/log_to_file ~/Documents/zw/data/${time}/csi.dat &
#iperf -s -i 0.5 -u| tee ~/Documents/zw/data/${time}/iperf.dat &
sudo /home/wifitest/linux-80211n-csitool-supplementary/netlink/log_to_file ./${time}/csi.dat &
iperf -s -i 0.5 -u| tee ./${time}/iperf.dat &
# sudo ./_clock.sh &
sleep 20
sudo killall iperf
sudo killall log_to_file
echo 'iperf_csi.sh Done'
exit
