# consul config
echo Configuring Consul....
echo '{"service": {"name": "consul", "tags": ["consul", "bootstrap"]}}' \
    >/etc/consul.d/bootstrap.json
sudo cp /ops/upstart/consul_bootstrap.conf /etc/init/consul.conf