# Bash Snippets

## SSH keys

On each ssh client, setup ssh keys, this is needed for the certbot script on Server2, but is also nice to have for admin <http://www.linuxproblem.org/art_9.html>

`ssh-keygen -t rsa`

Accept defaults

On ssh server (pi) `mkdir ~/.ssh`

From client run the following to copy key to server

`cat .ssh/id_rsa.pub | ssh pi@raspberrypi 'cat >> .ssh/authorized_keys'`

Test, shouldn't need password

`ssh pi@raspberrypi`

## See if reboot needed

see if a reboot is needed after update

cat /var/run/reboot-required

## Concise docker ps

Put into your .bashrc
`alias ctop='docker ps -a --format "table {{.Names}}\t{{.Status}}" | (read -r; printf "%s\n" "$REPLY"; sort -k 1 )'`

## Docker compose

Stop `docker compose down`
Start or apply changes `docker compose up -d`
Update image `docker compose pull && docker compose up -d`
