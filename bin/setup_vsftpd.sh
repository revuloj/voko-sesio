#!/bin/sh

PASV_ADDRESS=$(/sbin/ip route|awk '/default/ { print $3 }')
sed -i "s/[# ]*pasv_address\s*=.*/pasv_address=${PASV_ADDRESS}/" /etc/vsftpd.conf

FTP_PASSWD=$(cat /run/secrets/voko-sesio.ftp_password)
echo "sesio:${FTP_PASSWD}"|chpasswd