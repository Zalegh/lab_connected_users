# Lab Connected Users
## Description

Ce projet contient deux scripts Bash pour surveiller les utilisateurs connectés sur un système Linux :

### monitor_users.sh

Affiche l’utilisateur qui exécute le script (celui qui lance auto_monitor.sh).

Affichage horodaté.

Code de sortie : 0 si succès.

### auto_monitor.sh

Automatise l’exécution de monitor_users.sh plusieurs fois avec un intervalle défini.

Gère les logs horodatés dans file_execution.log.

Arrêt propre avec Ctrl+C.

Détection des erreurs et sortie propre si monitor_users.sh échoue.


### Prérequis

Linux / macOS (ou tout système Unix compatible Bash)

Bash ≥ 4.0


### Utilisation
Rendre les scripts exécutables
 chmod +x monitor_users.sh auto_monitor.sh

### Exécuter monitor_users.sh seul
./monitor_users.sh


### Exemple de sortie :

[2026-01-08 15:32:10] Utilisateur connecté qui exécute le script : aziz

### Exécuter auto_monitor.sh
./auto_monitor.sh <nombre_d_executions> <intervalle_en_secondes>


<nombre_d_executions> : nombre de fois que monitor_users.sh sera exécuté (par défaut : 1)

<intervalle_en_secondes> : temps d’attente entre chaque exécution (par défaut : 2 sec)

### Exemple :

./auto_monitor.sh 3 5


Le script exécutera monitor_users.sh 3 fois avec un intervalle de 5 secondes.

Les résultats seront affichés dans le terminal et enregistrés dans file_execution.log.

Ctrl+C arrête proprement le script et indique combien d’exécutions ont été faites.


### Exemple de log (file_execution.log)
===== Nouvelle session 2026-01-08 15:32:10 =====
2026-01-08 15:32:10 - Démarrage auto_monitor : 3 exécutions, intervalle 5s
2026-01-08 15:32:10 - Début de l'exécution n° 1
[2026-01-08 15:32:10] Utilisateur connecté qui exécute le script : aziz
2026-01-08 15:32:10 - Exécution réussie n° 1
2026-01-08 15:32:10 - Temps d'attente : 5 sec avant la prochaine exécution
...
2026-01-08 15:32:25 - Fin de la session auto_monitor.
