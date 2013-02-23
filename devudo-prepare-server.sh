
DEVUDO_PUB_KEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjqG/OUDn712Rr+s1Z1Ufvg7tYhJqf9blDMh167i0DDs3UIMH4Z1gxw6KZXiS/Ik4o0ipOi1mAEAl0H6vGmh+OlxW564T3zMDBTAk9a65ow++z+ViX6/EfPNS54GnivIoL6vYzdgkizjbvaaMCLdOmv5XzUHXH7bT6G01VG0z0j0dWb7JZXqfqA/T4/87L1SfGfoCwX/gDNf7mny+exUTyJrcnasswE/VeDARo62WSk7vW+6JK/hNNTx8ZM71pCmfHdEeb5VIu9kUMk9zfeFdluk7rDg37gj+5FUHMsZf/Sx2T9U+Sv5Q/6TJPSeByZ+UW1OVFf/28sEi7F+8UuI6H aegir@devudo.com'

# Starting off...

# Mostly from http://community.aegirproject.org/node/30
# Create me
adduser --system --group --home /home/jon jon
adduser jon www-data
adduser jon sudo
chsh -s /bin/bash jon


# Create aegir user.
adduser --system --group --home /var/aegir aegir
adduser aegir www-data    #make aegir a user of group www-data
chsh -s /bin/bash aegir

echo 'Defaults:aegir  !requiretty'
aegir ALL=NOPASSWD: /usr/sbin/apache2ctl' > /etc/sudoers.d/aegir

# Install Packages
# @TODO: Create some recipies with puppet or chef!
# @TODO: Allow this to be run in non-interactive mode!  
#        We cannot install mysql automatically without creating a root password!
apt-get install rsync apache2 php5 php5-cli php5-mysql postfix mysql-client mysql-server

# Configure
a2enmod rewrite
ln -s /var/aegir/config/apache.conf /etc/apache2/conf.d/aegir.conf



# Setup SSH
mkdir /var/aegir/.ssh
echo $DEVUDO_PUB_KEY > /var/aegir/.ssh/authorized_keys
chown aegir:aegir /var/aegir/.ssh -R
chmod 700 /var/aegir/.ssh
chmod 600 /var/aegir/.ssh/authorized_keys