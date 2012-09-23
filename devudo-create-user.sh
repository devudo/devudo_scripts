#!/bin/bash

USERNAME=$1

# Check for existing username
# Thanks, http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
egrep "^$USERNAME" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
  echo "$USERNAME exists!"
  exit 1
fi 

# create password
PASSWORD=jkl4gh4jhgjui4o4y
PASSWORD_ENCRYPTED=$(perl -e 'print crypt($ARGV[0], "password")' $PASSWORD)

# create user
useradd -m -p $PASSWORD_ENCRYPTED $USERNAME
echo "User $USERNAME has been created!"

# add user to aegir group
adduser $USERNAME aegir
adduser $USERNAME www-data

# create symlink to their hostmaster
mkdir /home/$USERNAME/.drush
ln -s /var/aegir/.drush/$USERNAME.devudo.com.alias.drushrc.php /home/$USERNAME/.drush/
ln -s /var/aegir/.drush/server_localhost.alias.drushrc.php /home/$USERNAME/.drush/
ln -s /var/aegir/.drush/server_master.alias.drushrc.php /home/$USERNAME/.drush/
ln -s /var/aegir/.drush/platform_devmaster6x19.alias.drushrc.php /home/$USERNAME/.drush/

# @TODO: as the user, run hosting setup.
 


