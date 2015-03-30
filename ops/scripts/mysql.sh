sudo apt-get -y update

# set root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password password'
# Install requirements
sudo apt-get install -y -qq \
    mysql-server

# configure mysql
mysql --user=root --password=password -e "GRANT ALL ON *.* to 'apache'@'172.%.%.%' IDENTIFIED BY 'password'"

# consul config
sudo mv /ops/configs/consul_mysql.json /etc/consul.d/mysql.json
sudo cp /ops/upstart/consul_client.conf /etc/init/consul.conf

# install consul template
wget https://github.com/hashicorp/consul-template/releases/download/v0.6.5/consul-template_0.6.5_linux_amd64.tar.gz
tar xzf consul-template_0.6.5_linux_amd64.tar.gz
sudo mv consul-template_0.6.5_linux_amd64/consul-template /usr/bin
sudo rmdir consul-template_0.6.5_linux_amd64

# consul template upstart for mysql
sudo cp /ops/upstart/mysql_consul_template.conf /etc/init/mysql_consul_template.conf