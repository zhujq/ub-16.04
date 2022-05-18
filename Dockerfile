FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
ADD . .


RUN apt-get -y update && apt-get install -y curl openssh-server zip unzip net-tools inetutils-ping iproute2 vim-common tcpdump git tmux\
&& mkdir -p /var/run/sshd \
&& echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
&& apt-get purge --auto-remove -y curl  \
&& chmod +x /run.sh  \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD ["/bin/bash","/run.sh"]

EXPOSE 8080 22 9979

