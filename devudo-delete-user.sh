#!/bin/bash

USERNAME=$1

if [ $USERNAME == '' ]; then
  echo "You must provide a username."
  exit 1
fi

# Check for existing username
# Thanks, http://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html
egrep "^$USERNAME" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
  echo "$USERNAME found..."
else 
  echo "$USERNAME does not exist!"
  exit 1
fi 

# Delete user
userdel -rf $USERNAME
echo "User $USERNAME has been deleted!"



