#!/usr/bin/sudo bash

p=$'\e[94m'
ep=$'\e[0m'

read -p "${p}service-name${ep} " name
read -p "${p}description${ep} " description
read -p "${p}execStart${ep} " start

file=/tmp/$name.service

cat /dev/null > $file
echo "[Unit]" >> $file
echo "Description=$description" >> $file
echo "" >> $file
echo "[Service]" >> $file
echo "ExecStart=$start" >> $file
echo "" >> $file
echo "[Install]" >> $file
echo "WantedBy=multi-user.target" >> $file

editor $file

read -p "Proceed? (Y/n): " yn
case $yn in
    [Nn]* ) exit;;
esac

mv $file /etc/systemd/system
systemctl daemon-reload
systemctl enable $name
systemctl start $name
