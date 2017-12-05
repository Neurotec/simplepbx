#!/usr/bin/env bash

apt-get update

if ! [ -d /etc/freeswitch ]; then
  wget -O - https://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add -
  echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.6/ jessie main" > /etc/apt/sources.list.d/freeswitch.list
  mkdir -p /etc/freeswitch && cp /vagrant/freeswitch.xml /etc/freeswitch/
  apt-get update && apt-get install -y freeswitch-meta-default
  apt-get install -y freeswitch-mod-xml-rpc freeswitch-mod-xml-curl freeswitch-mod-json-cdr freeswitch-mod-http-cache freeswitch-mod-event-socket
fi

if ! [ -d /usr/local/rvm ]; then
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    apt-get install -y curl
    \curl -sSL https://get.rvm.io | bash -s stable --ruby

    /usr/local/rvm/bin/rvm default do gem install bundler foreman
    /usr/local/rvm/bin/rvm alias create simplepbx ruby
    
fi

if ! [ -e /etc/systemd/system/app-web.target ]; then
    apt-get install -y libpq-dev nodejs postgresql
    sed -i "s/peer/trust/g" /etc/postgresql/9.4/main/pg_hba.conf
    sed -i "s/md5/trust/g" /etc/postgresql/9.4/main/pg_hba.conf
    systemctl restart postgresql
    su -c "createuser -r -d simplepbx" postgres
    usermod -aG rvm root
    
    cd /vagrant
    /usr/local/rvm/bin/rvm default do bundle install
    /usr/local/rvm/bin/rvm default do bundle exec rake db:create
    /usr/local/rvm/bin/rvm default do bundle exec rake db:migrate
    /usr/local/rvm/bin/rvm default do bundle exec rake db:seed

    echo "SETUP ADMINISTRATION"
    echo "user: admin@simplepbx.com"
    echo "password: simplepbx"
    echo "PORT=3000" > .env
    /usr/local/rvm/bin/rvm default do foreman export --user root systemd /etc/systemd/system/
    systemctl daemon-reload
    systemctl start app-web@root
    systemctl restart freeswitch
fi

