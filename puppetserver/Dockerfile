FROM jumanjiman/puppetagent

# http://superuser.com/a/817649
#RUN sed -i '/excludedocs/d' /etc/rpm/macros.imgcreate; \
#    sed -i '/nodocs/d' /etc/yum.conf

#RUN rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm; \
#    rpm -Uvh http://yum.theforeman.org/releases/latest/el7/x86_64/foreman-release.rpm; \
#    yum -y install puppet tar; \
#    yum clean all

# Install puppet master.
RUN puppet module install stephenrjohnson/puppet
RUN puppet module install puppetlabs/puppetdb
RUN puppet module install puppetlabs/vcsrepo
ADD install.pp /tmp/install.pp
RUN puppet apply /tmp/install.pp
ADD auth.conf.patch /etc/puppet/auth.conf.patch
RUN cd /etc/puppet; patch -p0 < auth.conf.patch

ADD start.sh /usr/local/sbin/start.sh
ADD ssl /var/lib/puppet/ssl
RUN chown -R puppet:puppet /var/lib/puppet/ssl

# Update system databases for user convenience.
#RUN mandb &> /dev/null; updatedb &> /dev/null

ADD puppetserver.conf /etc/puppetserver/conf.d/

# We use separate data container for SSL certs.
VOLUME ["/var/lib/puppet/ssl/"]

# We use dynamic environments.
VOLUME ["/opt/puppet/environments/"]

EXPOSE 8140

USER puppet
CMD ["/usr/local/sbin/start.sh"]
