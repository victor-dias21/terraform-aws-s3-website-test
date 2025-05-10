#!/bin/bash
yum update -y
amazon-linux-extras enable php8.0
yum install -y php php-mysqlnd php-fpm php-cli php-mbstring php-xml php-json php-opcache php-common httpd mariadb wget unzip

# Configura www.conf
sed -i 's/^user = .*/user = apache/' /etc/php-fpm.d/www.conf
sed -i 's/^group = .*/group = apache/' /etc/php-fpm.d/www.conf
sed -i 's/^listen = .*/listen = \/run\/php-fpm\/www.sock/' /etc/php-fpm.d/www.conf
sed -i 's/^listen.owner = .*/listen.owner = apache/' /etc/php-fpm.d/www.conf
sed -i 's/^listen.group = .*/listen.group = apache/' /etc/php-fpm.d/www.conf
sed -i 's/^listen.mode = .*/listen.mode = 0660/' /etc/php-fpm.d/www.conf

# Habilita serviços
systemctl enable php-fpm
systemctl enable httpd
systemctl start php-fpm
systemctl start httpd

# Instala WordPress
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

# Permissões
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html