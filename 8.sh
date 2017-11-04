#!/bin/bash
whiptail --title "Welcome to Sleepy Port!" --msgbox "Use -TAB- to change between different buttons, -SPACEBAR- for choosing options, -ARROW KEYS- for navigating, and -ENTER- for applying changes." 10 60

#!/bin/bash
IPTABLE=$(whiptail --title "Test Checklist Dialog" --radiolist \
"Selection of Commands Select One" 20 90 15 \
"blacklist_all" "" OFF \
"whitelist_all" "" OFF \
"blacklist_one_ipaddress" "" OFF \
"whitelist_one_ipaddress" "" OFF \
"blacklist_one_port" "" OFF \
"whitelist_one_port" "" OFF 3>&1 1>&2 2>&3)



exitstatus=$?
if [ $IPTABLE = 'blacklist_all' ]; then
    sudo iptables -P INPUT DROP && sudo iptables -P OUTPUT DROP
    whiptail --title "blacklist_all" --msgbox "All ipaddresses blaklisted and blocked!" 10 60
fi

exitstatus=$?
if [ $IPTABLE = 'whitelist_all' ]; then
    sudo iptables -P OUTPUT ACCEPT && sudo iptables -P INPUT ACCEPT
    whiptail --title "whitelist_all" --msgbox "All ipaddresses whitelisted and accepted!" 10 60
fi

exitstatus=$?
if [ $IPTABLE = 'blacklist_one_ipaddress' ]; then
    IPADDRESS=$(whiptail --title "Test Free-form Input Box" --inputbox "type in desired ipaddress to block (example: 192.168.1.1 for ipv4 and 10.10.10.10 for external ipaddress)" 10 60  3>&1 1>&2 2>&3) 
    sudo iptables -I INPUT -s $IPADDRESS -j DROP && sudo iptables -I OUTPUT -s $IPADDRESS -j DROP
fi

exitstatus=$?
if [ $IPTABLE = 'whitelist_one_ipaddress' ]; then
    IPADDRESS=$(whiptail --title "Test Free-form Input Box" --inputbox "type in desired ipaddress to accept (example: 192.168.1.1 for ipv4 and 10.10.10.10 for external ipaddress)" 10 60  3>&1 1>&2 2>&3) 
    sudo iptables -I INPUT -s $IPADDRESS -j ACCEPT && sudo iptables -I OUTPUT -s $IPADDRESS -j ACCEPT
fi

exitstatus=$?
if [ $IPTABLE = 'blacklist_one_port' ]; then
    PORT=$(whiptail --title "Test Free-form Input Box" --inputbox "type in desired port to block (example 443,80,or 22)" 10 60  3>&1 1>&2 2>&3)
    -A INPUT -p tcp --destination-port $PORT -j DROP
    whiptail --title "blacklist_one_port" --msgbox "port blacklisted and disconnected!" 10 60

fi

exitstatus=$?
if [ $IPTABLE = 'whitelist_one_port' ]; then
    PORT=$(whiptail --title "Test Free-form Input Box" --inputbox "type in desired port to allow (example 443,80,or 22)" 10 60  3>&1 1>&2 2>&3)
    -A INPUT -p tcp --destination-port $PORT -j ACCEPT
    whiptail --title "whitelist_one_port" --msgbox "port whitelisted and accepted!" 10 60

fi
