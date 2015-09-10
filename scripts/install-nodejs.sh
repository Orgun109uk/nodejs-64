#!/bin/bash -e

#################################################
# Install Node.js
echo "Installing NodeJS and NPM..."
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | NVM_DIR=/usr/local/nvm bash

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo "" >> /root/.bashrc
echo "export NVM_DIR=\"${NVM_DIR}\"" >> /root/.bashrc
echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"" >> /root/.bashrc
echo "" >> /root/.bashrc

echo "" >> /home/vagrant/.bashrc
echo "export NVM_DIR=\"${NVM_DIR}\"" >> /home/vagrant/.bashrc
echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"" >> /home/vagrant/.bashrc
echo "" >> /home/vagrant/.bashrc

nvm install 0.12
nvm alias default 0.12

echo "nvm use default" >> /root/.bashrc
echo "" >> /root/.bashrc

echo "nvm use default" >> /home/vagrant/.bashrc
echo "" >> /home/vagrant/.bashrc

NODE_VERSION=$(node --version)

#################################################
# Install Grunt CLI
echo "Installing Grunt CLI..."
npm install -g grunt-cli

#################################################
# Install MongoDB
echo "Installing MongoDB..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get -y install mongodb-org

#################################################
# Install Mongo-Express
echo "Installing mongo-express..."
npm install -g mongo-express

cp /usr/local/nvm/versions/node/${NODE_VERSION}/lib/node_modules/mongo-express/config.default.js /usr/local/nvm/versions/node/${NODE_VERSION}/lib/node_modules/mongo-express/config.js
sed -i.bak 's|^  useBasicAuth: true,|  useBasicAuth: false,|' /usr/local/nvm/versions/node/${NODE_VERSION}/lib/node_modules/mongo-express/config.js

touch /home/vagrant/startups/mongo-express
chmod +x /home/vagrant/startups/mongo-express

echo "#!/bin/bash -e" >> /home/vagrant/startups/mongo-express
echo "" >> /home/vagrant/startups/mongo-express
echo "echo \"Starting Mongo Express...\"" >> /home/vagrant/startups/mongo-express
echo "cd /usr/local/nvm/versions/node/${NODE_VERSION}/lib/node_modules/mongo-express" >> /home/vagrant/startups/mongo-express
echo "nohup node app.js &>/dev/null &" >> /home/vagrant/startups/mongo-express
echo "" >> /home/vagrant/startups/mongo-express

#################################################
# Install MailDev
echo "Installing maildev..."
npm install -g maildev

touch /home/vagrant/startups/maildev
chmod +x /home/vagrant/startups/maildev

echo "#!/bin/bash -e" >> /home/vagrant/startups/maildev
echo "" >> /home/vagrant/startups/maildev
echo "echo \"Starting mailDev...\"" >> /home/vagrant/startups/maildev
echo "nohup maildev &>/dev/null &" >> /home/vagrant/startups/maildev
echo "" >> /home/vagrant/startups/maildev

chown vagrant:vagrant $NVM_DIR -R
chown vagrant:vagrant /home/vagrant/.npm -R
chown vagrant:vagrant /home/vagrant/.npm/_locks -R
