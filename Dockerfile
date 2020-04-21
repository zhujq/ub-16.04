FROM       ubuntu:16.04
RUN apt-get update && apt-get install -y openssh-server && mkdir -p /var/run/sshd \
&& echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
&&  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



CMD    ["/usr/sbin/sshd", "-D"]


