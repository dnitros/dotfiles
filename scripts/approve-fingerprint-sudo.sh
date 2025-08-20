#!/usr/bin/env zsh

COUNT=$(grep -c pam_tid /etc/pam.d/sudo)
if [[ $COUNT -gt 0 ]]; then
  echo "ALREADY PRESENT - Not adding again!!!"
else
  echo "INCLUDING NEW LINE!!!"
  sudo sed -i '' '2i\
auth       sufficient     pam_tid.so\
' /etc/pam.d/sudo
fi
