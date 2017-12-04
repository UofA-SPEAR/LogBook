#!/bin/bash

function lb () {
  file=$(date '+%Y-%m-%d').md
  flag=0;
  
  cd ~/Desktop/LogBook
  
  vim ~/Desktop/LogBook/$file
  [ $? -eq 0 ] || (echo vim failure && return);
  #[ -f ~/Desktop/LogBook/$file ] && chmod 0444 ~/Desktop/LogBook/$file

  echo git pull...  
  git pull
  
  git add ~/Desktop/LogBook/$file
  [ $? -eq 0 ] || (echo "add failed" && return);

  read -p "Name: " name
  read -p "Email " email

  while [ $flag -eq 0 ]; do
    git commit -m "update $(date '+%c')" -a --author="${name} <$email>";
    if [ $? -eq 0 ]; then flag=1;
    else
      while true; do
        echo -e "\nCommit failed. If you are not connected to 'Actual Internet', please connect and press enter.\n"

        read -p "Or you can exit, by typing q: " resp;
        case $resp in 
          [qQ] ) git checkout ~/Desktop/LogBook/$file; return;;
          * ) break;;
        esac
      done
    fi;
  done
  git push origin master;
  }
