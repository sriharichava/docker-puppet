#!/bin/sh
set -x
set -e

# Install from binary tarball with instructions from:
# http://docs.puppetlabs.com/puppetdb/2.3/install_from_source.html

packages="
  ca-certificates
  openjdk7
  ruby
  ruby-rake
"
apk add --update $packages
rm -fr /var/cache/apk/*

gem install -N facter

adduser -D puppetdb

cd /tmp

wget http://downloads.puppetlabs.com/puppetdb/puppetdb-2.3.1.tar.gz
tar xvzf puppetdb-2.3.1.tar.gz

cd puppetdb-2.3.1
FACTER_osfamily=RedHat rake install

mkdir -p /etc/puppetdb/ssl
cp -f /var/lib/puppet/ssl/certs/ca.pem /etc/puppetdb/ssl/
cp -f /var/lib/puppet/ssl/certs/puppetdb.inf.ise.com.pem /etc/puppetdb/ssl/public.pem
cp -f /var/lib/puppet/ssl/private_keys/puppetdb.inf.ise.com.pem /etc/puppetdb/ssl/private.pem
chown -R puppetdb /etc/puppetdb/ssl
chmod 0400 /etc/puppetdb/ssl/*

#rm -fr /tmp/puppetdb*

cat > /etc/puppetdb/conf.d/jetty.ini << EOF
[jetty]
host = puppetdb.inf.ise.com
port = 8080
ssl-host = puppetdb.inf.ise.com
ssl-port = 8081
ssl-cert = /etc/puppetdb/ssl/public.pem
ssl-key = /etc/puppetdb/ssl/private.pem
ssl-ca-cert = /etc/puppetdb/ssl/ca.pem
EOF
