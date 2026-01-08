## GitHub Actions / Workflow

Pour ce lab, j'ai mis en place un workflow GitHub Actions pour automatiser la vérification de mes scripts Bash.
Ce lab permet l'automatisation d'un script monitor_users.sh.


### Fonctionnalités

- Chaque push sur la branche `main` déclenche automatiquement le workflow.
- Le workflow exécute les scripts :
  - `monitor_users.sh` pour afficher l'utilisateur connecté
  - `auto_monitor.sh` pour la surveillance automatique. Il est configuré avec `timeout` pour s'arrêter après un 
  temps défini (par défaut 2 secondes) afin de ne pas bloquer le workflow.
- Les scripts utilisent `trap` pour gérer proprement l'arrêt avec `Ctrl+C` ou le signal envoyé par `timeout`.

### Paramétrage du timeout

- Le workflow permet de définir la durée du timeout directement depuis GitHub :
  1. Aller dans l'onglet **Actions** du dépôt
  2. Sélectionner le workflow **Bash scripts check**
  3. Cliquer sur **Run workflow**
  4. Saisir la valeur souhaitée pour `timeout_seconds` (ex : 3, 12, 30 secondes)
  5. Cliquer sur **Run workflow** pour lancer l'exécution

### Historique et logs

- Chaque exécution du workflow est conservée dans l'onglet **Actions**, permettant de visualiser :
  - l’évolution du workflow
  - le comportement des scripts pour différentes valeurs de timeout
  - les messages de `trap` lors de l’arrêt du script
  -

# auto_monitor.sh
## Description
`auto_monitor.sh` est un script bash permettant de **surveiller automatiquement un autre script** (`monitor_users.sh`) à intervalles réguliers.
Chaque exécution est horodatée et enregistrée dans un fichier de log (`file_execution.log`).

Il fonctionne en **mode automatique** et peut être interrompu proprement avec **Ctrl+C**.

---

## Prérequis
- Le script à surveiller doit être **exécutable** et présent dans le même dossier :
  ```bash
  chmod +x monitor_users.sh

##Utilisation

bash auto_monitor.sh [INTERVALLE]

##Fonctionnement

1. Vérifie que le script monitor_users.sh existe et est exécutable.

2. Démarre une boucle infinie qui :

3. exécute monitor_users.sh

4. récupère et affiche le résultat avec horodatage

5. enregistre le résultat dans file_execution.log

6. attend le temps spécifié avant la prochaine exécution

7. Gestion propre des interruptions avec Ctrl+C, qui arrête le script et log l’événement.


##Exemple

Exécution avec intervalle par défaut (5 secondes) :

  ./auto_monitor.sh 10
##Resultat
2026-01-06 21:10:01 - ===== Démarrage auto_monitor (intervalle = 5s) =====
2026-01-06 21:10:01 - Exécution n°1 | Utilisateurs connectés : 3
2026-01-06 21:10:01 - Temps d'attente de 5 sec avant la prochaine exécution ...!
2026-01-06 21:10:06 - Exécution n°2 | Utilisateurs connectés : 2
...
2026-01-06 21:15:42 - Arrêt du script après 50 exécutions.

##Notes

Le fichier file_execution.log est créé automatiquement si inexistant et append les nouvelles entrées.
