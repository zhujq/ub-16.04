FROM       ubuntu:16.04
RUN apt-get -y update && apt-get install -y curl openssh-server && mkdir -p /var/run/sshd \
&& echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
&& curl -sLk https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz | tar xzC /usr/local/bin \
&&  apt-get purge --auto-remove -y curl && \
&&  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ADD run.sh /run.sh
ADD config.json /config.json
RUN chmod +x /run.sh 

CMD ["/bin/bash","/run.sh"]

