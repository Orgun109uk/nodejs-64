#!/bin/bash -e

nvm use default

#################################################
# Install MongoDB
echo "Installing MongoDB..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get -y install mongodb-org

mkdir /data/db

echo "#!/bin/bash -e" >> /home/vagrant/startups/mongodb
echo "" >> /home/vagrant/startups/mongodb
echo "echo \"Starting MongoDB...\"" >> /home/vagrant/startups/mongodb
echo "mongod --fork --logpath /var/log/mongodb.log" >> /home/vagrant/startups/mongodb
echo "" >> /home/vagrant/startups/mongodb

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
