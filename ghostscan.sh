#!/bin/bash
clear
echo "=============================================="
echo "IP - PING/SSH/HOSTNAME - $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================================="

if [[ -z $1 ]]; then
  echo "IPscan.sh {192.168.42 (class C)}"
exit 0
fi

RED='\033[0;31m'
LRED='\033[1;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
WHITE='\033[1;37m'
LGREY='\033[0;37m'
DGREY='\033[1;30m'
NC='\033[0m' # No Color

# RANGE IP
RANGE="$1"
PREFIX="tk_"

GHOST_USER="monitoring"  ## Nom de l'utilisateur qui execute la récupération du hostname
GHOST_IDRSA_PATH="/home/monit/.ssh/id_rsa" ## Chemin d'accès de la clé idrsa privée de l'utilisateur

for IP in `seq 1 254`;do
PINGOK=""
SSHOK=""
MYHOST=""

  if [[ $( ping ${RANGE}.${IP} -c 1 | grep -oP "(?<=from )([0-9]{1,3}[\.]){3}[0-9]{1,3}" ) ]]; then
      PINGOK="${GREEN}POK${NC}"
    else
      PINGOK="${RED}PKO${NC}"
  fi

  if [[ $( ssh-keyscan ${RANGE}.${IP} 2>&1 | grep -E "[a-zA-Z0-9\\\/\+\-\_]{20}" ) ]]; then
      SSHOK="${GREEN}SOK${NC}"
      MYHOST=$(ssh -o StrictHostKeyChecking=no -o BatchMode=yes -i ${GHOST_IDRSA_PATH} -qt -l ${GHOST_USER} ${RANGE}.${IP} "hostname")
    else
      SSHOK="${RED}SKO${NC}"
  fi

  if [[ ${MYHOST} ]]; then
     MYHOST=${PREFIX}${MYHOST}
  fi

  printf "${RANGE}.${IP} ${PINGOK} ${SSHOK} ${MYHOST}\n"
done
