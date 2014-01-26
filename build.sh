sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
cd /tmp
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.gz
tar -xvzf ruby-2.0.0-p353.tar.gz
cd ruby-2.0.0-p353/
./configure --prefix=/usr/local
make
sudo make install
cd /vagrant
sudo gem install bundler
bundle install
echo "cd /usr/local/lib/ruby/2.0.0/webrick"
echo "sudo vim config.rb"
echo "Change ':DoNotReverseLookup' to be true"
