FROM     ubuntu:18.04
WORKDIR /root
COPY install.sh install.sh 
RUN apt-get update && \
 apt-get install -y openssh-server iputils-ping zsh git curl vim  mysql-client redis-tools postgresql-client && \
 mkdir /var/run/sshd && \
 mkdir /root/.ssh && \
 echo 'root:root' | chpasswd && \
 sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
 sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
 chsh -s /bin/zsh root && \
 sh install.sh && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
