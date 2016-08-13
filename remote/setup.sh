#!/bin/bash

# Set Firefox homepage to http://domserver.cosc.canterbury.ac.nz/domjudge/team/
cat << EOF_FIREPREFS > /usr/lib/firefox/defaults/pref/all.corp.js
lockPref("browser.startup.homepage","http://dmjappprd01.sit.auckland.ac.nz/domjudge/team/");
EOF_FIREPREFS

# Set timezone to Australia/Perth - Modify as necessary
echo "Pacific/Auckland" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Remove sudo access
rm -fr /etc/sudoers.d
sed -r -i '/%admin|%sudo/ s/^/#/' /etc/sudoers
