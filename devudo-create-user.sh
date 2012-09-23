#!/bin/bash

USERNAME=$1

# @TODO: non-interactive mode?
adduser $USERNAME

# add user to aegir group
adduser $USERNAME aegir
adduser $USERNAME www-data

# create symlink to their hostmaster
mkdir /home/$USERNAME/.drush
ln -s /var/aegir/.drush/$USERNAME.devudo.com.alias.drushrc.php /home/$USERNAME/.drush/
