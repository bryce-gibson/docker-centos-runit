docker-centos-runit
===================

Mucking around installing [runit](http://smarden.org/runit/) as a process supervisor in docker.

Runit is used by [docker-baseimage](https://github.com/phusion/baseimage-docker) which is a great option, but I needed something RHEL-y... So thought I'd try it out :-)

The runsvdir command runs against the /service dir, so an example of adding ssh could be:

    FROM ...
    ...

    RUN yum install -y openssh-server passwd && passwd --delete root && sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config && echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config
    RUN ln -s /etc/sv/sshd /service
