#!/bin/bash

# Set Firefox homepage to http://domserver.cosc.canterbury.ac.nz/domjudge/team/
cat << EOF_FIREPREFS > /usr/lib/firefox/defaults/pref/all.corp.js
lockPref("browser.startup.homepage","http://dmjappprd01.sit.auckland.ac.nz/domjudge/team/");
EOF_FIREPREFS

# Setup IPTABLES to block all internet traffic, except the DOMJudge servers and IP printers


# Remove sudo access
rm -fr /etc/sudoers.d
sed -r -i '/%admin|%sudo/ s/^/#/' /etc/sudoers
