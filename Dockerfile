FROM alpine:latest
LABEL Author=<diestel@steloj.de>
ARG FTP_USER=sesio

RUN apk --update add vsftpd && rm -f /var/cache/apk/* 

COPY ./etc/* /etc/
COPY ./bin/* /usr/local/bin/

RUN adduser -D -u 13731 ${FTP_USER} \
    && mkdir -p "/home/vsftpd/alveno" && chown -R ftp:ftp /home/vsftpd \
    && chmod a-w /home/vsftpd && chown ${FTP_USER}:${FTP_USER} /home/vsftpd/alveno
#    && mkdir -p "/home/vsftpd/${FTP_USER}" && chown -R ftp:ftp /home/vsftpd/

# Create / update vsftpd user db:
# tion ni faros nur ĉe lanĉo, kiam ni scias la sekreton per 'docker stack'
#echo -e "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.txt
## /usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db

# komparu kun: 
# https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-16-04
# https://github.com/fauria/docker-vsftpd/blob/master/run-vsftpd.sh

##	Usage="docker run -d -p [HOST PORT NUMBER]:21 -v [HOST FTP HOME]:/home/vsftpd voko-sesio" \
##
##
##COPY vsftpd_virtual /etc/pam.d/
##COPY run-vsftpd.sh /usr/sbin/
##
##
##VOLUME /home/vsftpd
##VOLUME /var/log/vsftpd
##
EXPOSE 21
  
# Run vsftpd:
#/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

#USER vsftp:ftp
USER root

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/vsftpd"]