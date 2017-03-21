#!/bin/bash -e

#################################################
# Install Node.js
echo "Installing NodeJS and NPM..."
curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | NVM_DIR=/usr/local/nvm bash

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

nvm install 6.10
nvm alias default 6.10

echo "nvm use default" >> /root/.bashrc
echo "" >> /root/.bashrc

echo "nvm use default" >> /home/vagrant/.bashrc
echo "" >> /home/vagrant/.bashrc

NODE_VERSION=$(node --version)

#################################################
# Install Grunt and Gulp CLI
echo "Installing Grunt and Gulp CLI..."
npm install -g grunt-cli gulp-cli

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
