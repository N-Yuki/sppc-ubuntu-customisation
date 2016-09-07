#!/bin/bash

# Set Firefox homepage to http://domserver.cosc.canterbury.ac.nz/domjudge/team/
cat << EOF_FIREPREFS > /usr/lib/firefox/defaults/pref/all.corp.js
lockPref("browser.startup.homepage","http://dmjappprd01.sit.auckland.ac.nz/domjudge/team/");
EOF_FIREPREFS

# Setup IPTABLES to block all internet traffic, except the DOMJudge servers and IP printers
iptables -F
iptables -P INPUT DROP
iptables -P FORWARD ACCEPT
iptables -P OUTPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A OUTPUT -d 132.181.7.114/32 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -d 130.216.8.43/32 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p udp -m udp --dport 631 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 631 -j ACCEPT

# Remove sudo access
rm -fr /etc/sudoers.d
sed -r -i '/%admin|%sudo/ s/^/#/' /etc/sudoers
