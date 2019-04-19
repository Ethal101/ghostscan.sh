# Ghostscan.sh

Scan a Class C network for available hosts.

Performs a ping test on a host, checks if SSH is available and if so, try to get his hostname.

Can be usefull to update your /etc/hosts ;)

It just works (usally :D)

**USAGE** : ./ghostscan.sh 192.168.42

You can modify user account and private ssh key path :
ghost_user="user"
ghost_idrsa_path="/home/user/.ssh/id_rsa" 
