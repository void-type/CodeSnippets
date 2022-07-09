let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
upString=`printf "%d days, %02d:%02d:%02d" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read load1 load5 load15 rest < /proc/loadavg

echo "$(tput setaf 2)
   .~~.   .~~.    `hostname`
  '. \ ' ' / .'   `date +"%A, %e %B %Y, %r"`
   .~ .~~~..~.    `uname -srmo` $(tput setaf 1)
  : .~.'~'.~. :   $(tput setaf 2)Uptime.............: ${upString} $(tput setaf 1)
 ~ (   ) (   ) ~  $(tput setaf 2)Memory.............: `free -m | awk 'FNR == 2 {print $3}'` MB (used) / `free -m | awk 'FNR == 2 {print $2}'` MB (total) $(tput setaf 1)
( : '~'.~.'~' : ) $(tput setaf 2)Load Averages......: ${load1}, ${load5}, ${load15} (1, 5, 15 min) $(tput setaf 1)
 ~ .~ (   ) ~. ~  $(tput setaf 2)Running Processes..: `ps ax | wc -l | tr -d " "` $(tput setaf 1)
  (  : '~' :  )   $(tput setaf 2)IP Addresses.......: `ifconfig eth0 | grep "inet " | xargs | cut -d " " -f 2` and `wget -qO- http://ipecho.net/plain` $(tput setaf 1)
   '~ .~~~. ~'    $(tput setaf 2)Disk Usage.........: `df -h | grep -E '^/dev/root' | awk '{ print $5 }'` on /dev/root $(tput setaf 1)
       '~'
$(tput sgr0)"
