#!/bin/bash

# Jean-Simon Cyr
# Description: Script de diagnostic réseau pour Windows
# Date: 2024-06-15

# Couleurs 
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

print_section(){
    echo -e "${BOLD}${BLUE}=== $1 ===${NC}"
}

print_error(){
    echo -e "${RED}$1${NC}"
}

print_success(){
    echo -e "${GREEN}$1${NC} $2"
}

is_wsl(){
    if grep -qEi "Microsoft|WSL" /proc/version 2> /dev/null ; then
        return 0
    else
        return 1
    fi
}

# Afficher les informations systèmes
show_systeminformations(){
    print_section "Informations Systèmes"

    if is_wsl; then
       HOST_NAME=$(hostname.exe | awk '{print $1}')
       Date=$(date)
       SYSTEM_INFO=$(uname -a)

        print_success "Nom de l'hôte :" "${HOST_NAME}"
        print_success "Date :" "${Date}"
        print_success "Informations système :" "${SYSTEM_INFO}"
    fi

}
# Afficher la configuration réseau
#print_section "Configuration Réseau"
#echo -e "${CYAN}Adresses IP locale: ${NC}$(hostname -I)"
#echo -e "${CYAN}Adresse de la passerelle pas défaut: ${NC}$(ip route | grep default | awk '{print $3}')"
#echo -e "${CYAN}Serveurs DNS configurés: ${NC}$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' | head -1)"

# Effectuer des tests de connectivité
#print_section "Tests de Connectivité"
#echo -e "${CYAN}Test de localhost: ${NC}$(ping -c 4 localhost)"
#echo -e "${CYAN}Test de la passerelle par défaut: ${NC}$(ping -c 4 $(ip route | grep default | awk '{print $3}'))"
# Afficher la table ARP

# Effectuer des résolutions DNS

show_systeminformations