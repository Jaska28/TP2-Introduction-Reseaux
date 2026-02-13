
## Systèmes d'exploitation - Collège de Maisonneuve

---

**Nom :** Cyr

**Prénom :** Jean-Simon

**Groupe :** 25604

**Lien GitHub du devoir** : https://github.com/Jaska28/TP2-Introduction-Reseaux.git

## **Date de remise :** Jeudi 13 février 2026

## Barème récapitulatif

|Section|Points|Note|
|---|---|---|
|Partie 1 : Questions théoriques|20|/20|
|Partie 2 : Commandes réseau|25|/25|
|Partie 3 : Analyse Wireshark|25|/25|
|Partie 4 : Script Bash|30|/30|
|**TOTAL**|**100**|**/100**|

---

# Partie 1 : Questions théoriques (20 points)

## Question 1 - Modèle OSI (5 points)

### a) Complétez le tableau (2.5 pts)

| Protocole/Élément | N° Couche | Nom de la couche |
| ----------------- | --------- | ---------------- |
| HTTP              | 7         | Application      |
| Adresse IP        | 3         | Réseau           |
| Câble Ethernet    | 1         | Physique         |
| TCP               | 4         | Transport        |
| Adresse MAC       | 2         | Liaison          |

### b) Différence entre le modèle OSI et TCP/IP (2.5 pts)

```
Votre réponse : Le modèle OSI est un modèle théorique en sept couches conçu pour expliquer et standardiser le fonctionnement des réseaux. Le modèle TCP/IP regroupe ces fonctions en quatre couches. OSI est surtout utilisé comme modèle pédagogique, tandis que TCP/IP représente l’architecture réelle utilisée dans les réseaux.
```

---

## Question 2 - Adresses IP (5 points)

### a) Adresses privées ou publiques (2.5 pts)

| Adresse IP    | Privée / Publique |
| ------------- | ----------------- |
| 192.168.1.50  | Privée            |
| 8.8.8.8       | Publique (google) |
| 10.0.0.1      | Privé             |
| 172.20.5.100  | Privée            |
| 200.100.50.25 | Publique          |

### b) Qu'est-ce qu'un masque de sous-réseau ? À quoi sert-il ? (2.5 pts)

```
Votre réponse : Le masque de sous-réseau nous dit si une adresse IP est sur le même réseau local ou si on doit passer par un gateway.
```

---

## Question 3 - Protocoles (10 points)

### a) Expliquez le fonctionnement du protocole ARP. Pourquoi est-il nécessaire ? (3 pts)

```
Votre réponse : Protocole qui fait le lien entre les adresses IP et les adresses MAC dans un réseau local. L'ARP garde en mémoire temporairement ces liens et dirige les packets à la bonne machine. Quand un appareil veut communiquer avec un adresse IP, il envoie une requête ARP sur le réseau pour demander c'est quel machine qui a cette adresse. Par la suite, ARP garde en mémoire temporairement l'information pour que les paquets soient envoyés directement.
```

### b) Différence entre une requête DNS de type A et de type AAAA ? (2 pts)

```
Votre réponse : DNS de type A est pour IPv4 et AAAA pour IPv6. IPv6 existe au cas où qu'on manquerait d'adresse IPv4, ce qui va arriver bientôt.
```

### c) Expliquez ce que fait la commande `ping` au niveau du protocole ICMP. Quels types de messages sont échangés ? (3 pts)

```
Votre réponse : Les types de messages de ping sont Echo Request et Echo Reply avec le protocole ICMP pour tester la connectivité. On envoie une requête à l'adresse spécifiée et elle répond si le paquet a été reçu.
```

### d) Sur quel port et avec quel protocole de transport fonctionne DNS par défaut ? Pourquoi ce choix ? (2 pts)

```
Votre réponse : Par défaut, DNS utilise le port 53 avec le protocole UDP. Ce choix permet de gagner en rapidié par rapport au protocole TCP.
```

---

# Partie 2 : Commandes réseau (25 points)

## Exercice 1 : Configuration réseau (10 points)

### a) Configuration réseau

**Commande utilisée :** `ip addr show`

**Adresse IP :** `172.25.53.3`

**Masque de sous-réseau :** Le `/20` correspond à `255.255.240.0` 

**Nom de l'interface réseau principale :** eth0

### b) Passerelle par défaut

**Commande utilisée :**`ip route show`

**Adresse de la passerelle :**`172.25.48.1`

### c) Serveurs DNS

**Commande utilisée :**`nslookup www.google.com`

**Serveurs DNS configurés :**`10.255.255.254`

> 📸 **Capture d'écran 1** : Insérez votre capture montrant la configuration réseau
> ![alt text](captures/capture1_config_reseau.png)
---

## Exercice 2 : Tests de connectivité avec ping (8 points)

### a) Ping vers localhost (127.0.0.1) - 4 paquets

**Commande exacte utilisée :**`ping -c 4 localhost`

**Résultat (succès/échec) :** Succès

**Temps moyen de réponse :** 0.022ms

### b) Ping vers la passerelle - 4 paquets

**Résultat (succès/échec) :** Succès

**Temps moyen de réponse :** 0.38ms

### c) Ping vers 8.8.8.8 - 4 paquets

**Résultat (succès/échec) :** Succès

**Temps moyen de réponse :** 21.42ms

### d) Si le ping vers 8.8.8.8 fonctionne mais pas vers google.com, quel serait le problème probable ?

```
Votre réponse :
Un problème de DNS.

```

> 📸 **Capture d'écran 2** : Insérez votre capture des tests ping
>![alt text](captures/capture2_ping.png)

---

## Exercice 3 : Table ARP et résolution DNS (7 points)

### a) Table ARP

**Commande utilisée :** `arp.exe -a`

**Nombre d'entrées :** 19

**Une entrée (IP et MAC) :** IP: 10.0.0.1 MAC: 88-9e-68-a1-d9-16


### b) Requête DNS pour www.collegemaisonneuve.qc.ca

**Commande utilisée :** `nslookup www.cmaisonneuve.qc.ca`

**Adresse IP obtenue :** IP: 151.101.138.132

### c) Commande `dig` pour github.com - TTL

**TTL (Time To Live) de l'enregistrement :** 60 secondes

> 📸 **Capture d'écran 3** : Insérez votre capture de la table ARP et d'une requête DNS
> ![alt text](captures/capture3_arp_dns.png)

---

# Partie 3 : Analyse Wireshark (25 points)

## Exercice 4 : Capture et analyse ICMP (10 points)

### Analyse d'un paquet "Echo (ping) request"

| Information             | Valeur observée     |
| ----------------------- | ------------------- |
| Adresse MAC source      | `ac:19:8e:28:ce:36` |
| Adresse MAC destination | `88:9e:68:a1:d9:16` |
| Adresse IP source       | `10.0.0.177`        |
| Adresse IP destination  | `8.8.8.8`           |
| Type ICMP (numéro)      | 8                   |
| Code ICMP               | 0                   |

### Question : Différence entre le Type ICMP d'un "Echo Request" et d'un "Echo Reply" ?

```
Votre réponse : L'Echo Request est un message ICMP envoyé pour tester la connectivité, tandis que l'Echo Reply est la réponse envoyée lorsqu'un appareil rec¸oit cette requête.
```

> 📸 **Capture d'écran 4** : Capture Wireshark montrant les paquets ICMP avec le détail d'un paquet
>![alt text](captures/capture4_wireshark.icmp.png)

---

## Exercice 5 : Capture et analyse DNS (8 points)

### Analyse de la requête et réponse DNS

| Information                | Valeur observée |
| -------------------------- | --------------- |
| Port source (requête)      | 55073           |
| Port destination (requête) | 53              |
| Protocole de transport     | UDP             |
| Type de requête DNS        | A               |
| Adresse IP dans la réponse | 140.82.114.4    |

> 📸 **Capture d'écran 5** : Capture Wireshark montrant la requête et réponse DNS
>![alt text](captures/capture5_wireshark_dns.png)

---

## Exercice 6 : Capture et analyse ARP (7 points)

### Tableau d'un échange ARP observé

|Information|ARP Request|ARP Reply|
|---|---|---|
|Adresse MAC source|00.15.5d:5f:32:45|00:15:5d:fe:e1:35|
|Adresse MAC destination|ff:ff:ff:ff:ff:ff|00:15:5d:5f:32:45|
|Adresse IP recherchée|172.25.48.1|172.25.48.1|

### Question : Pourquoi l'adresse MAC de destination dans l'ARP Request est-elle `ff:ff:ff:ff:ff:ff` ?

```
Votre réponse : Parce que l'adresse MAC n'est pas connue, donc la requête ARP est envoyé en broadcast.
```

> 📸 **Capture d'écran 6** : Capture Wireshark montrant l'échange ARP
![alt text](captures/capture6_wireshark_arp.png)

---

# Partie 4 : Script de diagnostic réseau (30 points)

## Exercice 7 : Création du script

### Informations sur votre script

**Nom du fichier :** `diagnostic_reseau.sh`

### Checklist des fonctionnalités implémentées

Cochez les fonctionnalités que vous avez implémentées :

- [x] Affichage du nom de l'hôte
- [x] Affichage de la date et heure
- [x] Affichage de la version du système
- [x] Affichage de l'adresse IP locale
- [x] Affichage de l'adresse de la passerelle
- [x] Affichage des serveurs DNS
- [x] Test de connectivité localhost
- [x] Test de connectivité passerelle
- [x] Test de connectivité Internet (8.8.8.8)
- [x] Test de résolution DNS (google.com)
- [x] Affichage de la table ARP
- [x] Résolution DNS de 2+ domaines
- [x] Gestion des erreurs (messages si échec)
- [x] Commentaires dans le code
- [x] Affichage clair avec titres de sections

### Difficultés rencontrées (optionnel)

```
Décrivez ici les difficultés que vous avez rencontrées lors de la création du script : 

Je suis quelqu’un qui apprend surtout en manipulant et en expérimentant. J’ai donc eu de la difficulté à comprendre certaines étapes du script simplement en regardant les exemples faits en classe. J’ai besoin de prendre du temps par moi‑même pour essayer, tester et assimiler la matière. La création du script m’a demandé un effort supplémentaire pour analyser les exercices et bien comprendre leur logique.
```

> 📸 **Capture d'écran 7** : Capture montrant l'exécution de votre script
> ![alt text](captures/capture7_script_execution.png)

---

# Récapitulatif de la remise

## Fichiers à inclure dans votre projet

Vérifiez que votre projet contient :

- [x] `reponse.md` (ce fichier complété)
- [x] `diagnostic_reseau.sh` (votre script)
- [x] `captures/capture1_config_reseau.png`
- [x] `captures/capture2_ping.png`
- [x] `captures/capture3_arp_dns.png`
- [x] `captures/capture4_wireshark_icmp.png`
- [x] `captures/capture5_wireshark_dns.png`
- [x] `captures/capture6_wireshark_arp.png`
- [x] `captures/capture7_script_execution.png`

---

---

_Bon travail !_