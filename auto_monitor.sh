#!/bin/bash

SCRIPT="./monitor_users.sh"
LOG_FILE="file_execution.log"

NOMBRE_EXEC=${1:-1}
INTERVALLE_EXEC=${2:-2}
COMPTEUR_EXEC=0

(( INTERVALLE_EXEC < 1 )) && INTERVALLE_EXEC=1


if [ ! -x "$SCRIPT" ]; then
    echo "Erreur : le fichier $SCRIPT n'existe pas ou n'est pas exécutable !" 
    exit 1
fi


timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

# Gestion Ctrl+C
trap 'echo "$(timestamp) - Arrêt du script après $((COMPTEUR_EXEC - 1)) exécutions." | tee -a "$LOG_FILE"; exit 0' SIGINT


echo -e "\n===== Nouvelle session $(timestamp) =====" | tee -a "$LOG_FILE"
echo "$(timestamp) - Démarrage auto_monitor : $NOMBRE_EXEC exécutions, intervalle $((INTERVALLE_EXEC + 1))s" | tee -a "$LOG_FILE"


while (( COMPTEUR_EXEC < NOMBRE_EXEC ))
do

    echo "------------------------------" | tee -a "$LOG_FILE"
    echo "$(timestamp) - Début de l'exécution n° $COMPTEUR_EXEC" | tee -a "$LOG_FILE"

    # Exécuter le script et capturer stdout + stderr
    RESULTAT=$("$SCRIPT" 2>&1)
    CODE=$?

    # Vérifier si une erreur est survenue
    if [ $CODE -ne 0 ]; then
        echo "$(timestamp) - Erreur détectée ! Arrêt après $COMPTEUR_EXEC exécutions." | tee -a "$LOG_FILE"
        echo "Message d'erreur : $RESULTAT" | tee -a "$LOG_FILE"
        break
    fi

    # Affichage succès
    echo "$(timestamp) - Exécution réussie n° $COMPTEUR_EXEC" | tee -a "$LOG_FILE"
    echo "Résultat : $RESULTAT" | tee -a "$LOG_FILE"

    # Attente avant la prochaine exécution
    echo "$(timestamp) - Temps d'attente : $INTERVALLE_EXEC sec avant la prochaine exécution" | tee -a "$LOG_FILE"
    sleep "$INTERVALLE_EXEC"
	((COMPTEUR_EXEC++))

done

echo "$(timestamp) - Fin de la session auto_monitor." | tee -a "$LOG_FILE"
echo -e "==============================\n" | tee -a "$LOG_FILE"
