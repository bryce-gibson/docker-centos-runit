FROM centos:centos6
MAINTAINER Bryce Gibson <bryce.gibson@unico.com.au>

RUN yum install -y wget tar glibc-static && yum groupinstall -y "Development Tools"
RUN mkdir -p /package ; chmod 1755 /package
RUN cd /tmp; wget http://smarden.org/runit/runit-2.1.2.tar.gz && tar xvzf runit-2.1.2.tar.gz --strip-components=1 && rm runit-2.1.2.tar.gz && cd runit-2.1.2 && package/install && mkdir /service
RUN cd /tmp; wget https://s3.amazonaws.com/rubyists/aur/runit-services/runit-services-1.1.2-1.tar.gz && tar xzvf runit-services-1.1.2-1.tar.gz && cd runit-services/ && install -D -m 0755 rsvlog /usr/bin/rsvlog && install -D -d /etc/sv && for service in etc/sv/*; do cp -a $service /etc/sv/; done && mkdir -p /run/runit/sv/

#Light hearted Cleanup
#RUN yum groupremove -y "Development Tools" # Doesn't seem to work in centos 6

#Eg - sshd
#RUN yum install -y openssh-server passwd && passwd --delete root && sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config && echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
#RUN ln -s /etc/sv/sshd /service

CMD runsvdir /service
