echo "NORMAL=60" > /tmp/checkvpn.sh
echo "PPTPDOWN=90" >> /tmp/checkvpn.sh
echo "ALLDOWN=240" >> /tmp/checkvpn.sh
echo "sleep \$PPTPDOWN" >> /tmp/checkvpn.sh
echo "while [ 1 ] ; do" >> /tmp/checkvpn.sh
echo "PINGSH=\`ping -c 2 192.168.77.1 2> /dev/null | awk '/packets received/ {print \$4}'\`" >> /tmp/checkvpn.sh
echo "if [ \"\$PINGSH\" -eq 1 -o \"\$PINGSH\" -eq 2 ]; then" >> /tmp/checkvpn.sh
echo "  echo \"\`date\`: Shanghai - OK\" >> /tmp/vpn.log" >> /tmp/checkvpn.sh
echo "  sleep \$NORMAL" >> /tmp/checkvpn.sh
echo "else" >> /tmp/checkvpn.sh
echo "  echo \"\`date\`: Shanghai - DOWN\" >> /tmp/vpn.log" >> /tmp/checkvpn.sh
echo "  PINGUS=\`ping -c 1 www.google.com 2> /dev/null | awk '/packets received/ {print \$4}'\`" >> /tmp/checkvpn.sh
echo "  if [ -n \"\$PINGUS\" -a \"\$PINGUS\" = \"1\" ]; then" >> /tmp/checkvpn.sh
echo "    echo \"\`date\`: US - OK\" >> /tmp/vpn.log" >> /tmp/checkvpn.sh
echo "    echo \"\`date\`: Rest PPTP to Shanghai\" >> /tmp/vpn.log" >> /tmp/checkvpn.sh
echo "    killall pptp 2> /dev/null" >> /tmp/checkvpn.sh
echo "    sleep 2" >> /tmp/checkvpn.sh
echo "    killall -9 pptp 2> /dev/null" >> /tmp/checkvpn.sh
echo "    sleep 1" >> /tmp/checkvpn.sh
echo "    sleep \$PPTPDOWN" >> /tmp/checkvpn.sh
echo "  else" >> /tmp/checkvpn.sh
echo "    echo \"\`date\`: US - DOWN. Wait longer\" >> /tmp/vpn.log" >> /tmp/checkvpn.sh
echo "    sleep \$ALLDOWN" >> /tmp/checkvpn.sh
echo "  fi" >> /tmp/checkvpn.sh
echo "fi" >> /tmp/checkvpn.sh
echo "done" >> /tmp/checkvpn.sh

sh /tmp/checkvpn.sh &
