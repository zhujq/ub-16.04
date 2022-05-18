FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
ADD . .

RUN apt-get -y update && apt-get install -y curl openssh-server zip unzip net-tools inetutils-ping iproute2 vim-common tcpdump git tmux  tzdata\
&& mkdir -p /var/run/sshd \
&& echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/^#?ClientAliveInterval\s+.*/ClientAliveInterval 60/' /etc/ssh/sshd_config \
&& sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config \
&& sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
&& sed -ri 's/^#PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
&& echo "Asia/Shanghai" > /etc/timezone &&  rm -f /etc/localtime   && dpkg-reconfigure -f noninteractive tzdata \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
&& rm -rf /var/lib/apt/lists/* \
&& apt-get purge --auto-remove -y \
&& chmod +x /run.sh  \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD ["/bin/bash","/run.sh"]

EXPOSE 8080 22

