FROM ubuntu:16.04

ADD run.sh /run.sh
ADD config.json /config.json

RUN apt-get -y update && apt-get install -y curl openssh-server zip unzip net-tools inetutils-ping iproute2 lubuntu-desktop tightvncserver  \  
&& mkdir -p /var/run/sshd \
&& echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
&& apt-get purge --auto-remove -y curl  \
&& mkdir -m 777 /v2ray && chmod +x /run.sh  \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root/
COPY xstartup /root/.vnc/
RUN mkdir -p /root/.vnc && chmod a+x /root/.vnc/xstartup && touch /root/.vnc/passwd \
&& /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd" > /root/.vnc/passwd \
&& chmod 400 /root/.vnc/passwd && chmod go-rwx /root/.vnc && touch /root/.Xauthority

CMD ["/bin/bash","/run.sh"]

EXPOSE 8080 22 5091

