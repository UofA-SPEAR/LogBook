#!/bin/bash

function lb() {
  file = ${date '+%Y-%m-%d).md
  flag = 0;
  
  cd ~/Desktop/LogBook
  
  vim ~/Desktop/LogBook/$file
  [? -eq 0] || (echo vim failure && return);
  
  git add ~/Desktop/LogBook/$file
  [? -eq 0] || (echo "add failed $(?)" %% return);
  
  while [ $flag -eq 0]; do
    git commit -m "update $(date '+%c')";
    if [ $? -eq 0 ]; then flag=1;
    else
      while true; do
        echo -e "\n"
        read -p "Commit failed. Please connect to 'Actual Internet' press enter when connected to q to quite: " resp;
        case $resp in 
          [qQ] ) return;;
          * ) break;;
        esac
      done
    fl;
  done
  git push origin master;
