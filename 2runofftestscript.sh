#!/bin/bash
whiptail --title "Welcome to Sleepy Port!" --msgbox "Use -TAB- to change between different buttons, -SPACEBAR- for choosing options, -ARROW KEYS- for navigating, and -ENTER for applying changes." 10 60

#!/bin/bash
IPTABLE=$(whiptail --title "Test Checklist Dialog" --radiolist \
"What is the Linux distro of your choice?" 20 90 15 \
"blacklist_all" "" ON \
"whitelist_all" "" OFF \
"blacklist_all_ip_addresses" "" OFF \
"blacklist_all_ports" "" OFF \
"whitelist_all_ip_addresses" "" OFF \
"whitelist_all_ports" "" OFF \
"blacklist_one_ipaddress" "" OFF \
"whitelist_one_port" "" OFF \
"blacklist_one_ipaddress_and_port_for_ipaddress_to_not_use" "" OFF \
"whitelist_one_ipaddress_and_port_for_one_ipaddress_to_use" "" OFF  3>&1 1>&2 2>&3)

exitstatus=$?
if [ $IPTABLE = 'blacklist_all' ]; then
    echo  All ipaddresses blacklisted and blocked!

fi
