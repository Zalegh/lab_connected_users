#!/bin/bash


USERS_CONNECTED=$(who)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] Utilisateurs connectés : $USERS_CONNECTED"
exit 0
