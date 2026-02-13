#!/bin/bash

# Auteur: Jean-Simon Cyr
# Description: Script de diagnostic réseau pour WSL. Pour le TP2 du cours Système d'exploitation.
#              Affiche les informations système, la configuration réseau, effectue des tests
#              de connectivité, affiche la table ARP et résout des noms de domaine.
# Date: 2026-02-13

# Couleurs 
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

get_length(){
    # Retourne le nombre de caractères.
    local string="$1"
    echo "${#string}"
}

print_section(){
    # Affiche un titre de section avec séparateurs.
    local section_title="$1"
    local separator="$2"
    echo ""
    echo -e "${BOLD}${BLUE}${separator}${separator}${separator} $section_title ${separator}${separator}${separator}${NC}"
}

print_error(){
    echo -e "${RED}$1${NC}"
}

print_success(){
    echo -e "${GREEN}$1${NC} $2"
}

is_wsl() {
    # Vérifie si le script est exécuté dans un terminal WSL.
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Vérification si le script est exécuté dans un terminal WSL.
# Les commandes sur d'autres terminaux pourraient ne pas fonctionner correctement.
if ! is_wsl; then
    print_error "ERREUR: Ce script doit être exécuté dans un terminal WSL!"
    print_error "Veuillez exécuter le script dans un terminal WSL."
    exit 1
fi

show_system_Informations(){
    print_section "Informations Systèmes" "-"

    if HOST_NAME=$(hostname | awk '{print $1}'); then
        print_success "Nom de l'hôte récupéré avec succès!" "${HOST_NAME}"
    else
        print_error "Erreur lors de la récupération du nom de l'hôte"
    fi

    if Date=$(date); then
        print_success "Date récupérée avec succès!" "${Date}"
    else
        print_error "Erreur lors de la récupération de la date"
    fi

    if SYSTEM_INFO=$(uname -a); then
        print_success "Informations système récupérées avec succès!" "${SYSTEM_INFO}"
    else
        print_error "Erreur lors de la récupération des informations système"
    fi
}

show_ip_config(){
    print_section "Configuration Réseau" "-"

    # Affiche l'adesse IP.
    if IP_LOCAL=$(hostname -I 2>/dev/null); then
        print_success "Adresses IP locale :" "${IP_LOCAL}"
    else
        print_error "Erreur lors de la récupération des adresses IP locales"
    fi

    # Affiche le gateway par défaut.
    if GATEWAY=$(ip route | grep default | awk '{print $3}' 2>/dev/null); then
        print_success "Passerelle par défaut :" "${GATEWAY}"
    else
        print_error "Erreur lors de la récupération de la passerelle par défaut"
    fi

    # Affiche les serveurs DNS configurés.
    if DNS=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}' | head -1 2>/dev/null); then
        print_success "Serveurs DNS configurés :" "${DNS}"
    else
        print_error "Erreur lors de la récupération des serveurs DNS configurés"
    fi
}

test_connectivity(){
    print_section "Tests de Connectivité" "-"

    # localhost
    if PING_RESULT=$(ping -c 4 -W 2 localhost 2>/dev/null); then
        print_success "Test de localhost réussi!" ""
    else
        print_error "Erreur lors du test de localhost $PING_RESULT"
    fi

    # Passerelle par défaut
    GATEWAY=$(ip route | grep default | awk '{print $3}')
    if PING_RESULT=$(ping -c 4 -W 2 $GATEWAY 2>/dev/null); then
        print_success "Test de la passerelle par défaut ($GATEWAY) réussi!" ""
    else
        print_error "Erreur lors du test de la passerelle par défaut ($GATEWAY) $PING_RESULT"
    fi

    # Adresse IP Google
    if PING_RESULT=$(ping -c 4 -W 2 8.8.8.8 2>/dev/null); then
        print_success "Test de 8.8.8.8 réussi!" ""
    else
        print_error "Erreur lors du test de 8.8.8.8 $PING_RESULT"
    fi

    # Résolution du domaine. DNS -> IP
    if IP_GOOGLE=$(dig +short google.com 2>/dev/null); then
        print_success "Résolution DNS réussie pour google.com " "$IP_GOOGLE"
    else
        print_error "Erreur de résolution pour google.com"
    fi
}

show_arp_table(){
    # Variables bidon pour connaitre la longueur maximale des champs.
    ip_adress="255.255.255.255"
    mac_adress="00:00:00:00:00:00"
    taille_total=$(($(get_length $ip_adress)+$(get_length $mac_adress)+$(get_length  "dynamique")+6))

    # En-tête avec alignement
    print_section "Table ARP" "-"
    printf "%-$(get_length $ip_adress)s | %-$(get_length $mac_adress)s | %-$(get_length " dynamique ")s\n" "IP Address" "MAC Address" "Type"
    printf '%*s\n' $taille_total | sed 's/ /-/g'  # Ligne de séparation

    # Affiche les données
    arp.exe -a 2>/dev/null | grep -iE 'dynamique|dynamic' | while read line ; do
        IP=$(echo $line | awk '{print $1}')
        MAC=$(echo $line | awk '{print $2}')
        TYPE=$(echo $line | awk '{print $3}')
        # Affichage formaté
        printf "%-$(get_length $ip_adress)s | %-$(get_length $mac_adress)s | %-$(get_length " dynamique ")s\n" "$IP" "$MAC" "$TYPE"
    done
    printf '%*s\n' $taille_total | sed 's/ /-/g'  # Ligne de séparation
}

resolve_dns(){
    print_section "Résolution DNS" "-"

    DOMAINES=("amazon.com" "github.com")

    for domaine in "${DOMAINES[@]}"; do # @ pour itérer tout les élements de l'array.
        echo -e "${CYAN}$domaine: ${NC}"

        # Résolution du domaine. DNS -> IP
        if dig +short "$domaine" 2>/dev/null; then
            print_success "Résolution réussie pour $domaine" ""
        else
            print_error "Erreur de résolution pour $domaine"
        fi
    done    
}

# Exécution du diagnostic réseau
print_section "Début du diagnostic réseau" "="
show_system_Informations
show_ip_config
test_connectivity
show_arp_table
resolve_dns
print_section "Diagnostic réseau terminé avec succès !" "="
echo ""