#!/bin/bash

# Définir les variables
REPO_URL="https://github.com/keren-K/ngnixcodetp.git"
LOCAL_DIR="/home/ec2-user/tpngnix"
TEMP_DIR="/home/ec2-user/tpngnix_temp"
SERVER_PORT=5000

# Fonction pour vérifier les mises à jour du dépôt GitHub
check_github_update() {
    # Supprimer le répertoire temporaire s'il existe déjà
    rm -rf "$TEMP_DIR"

    # Cloner le dépôt dans le répertoire temporaire
    git clone "$REPO_URL" "$TEMP_DIR"
    if [ $? -eq 0 ]; then
        echo "Mise à jour du dépôt GitHub détectée."

        # Déplacer le fichier indexg.html dans le répertoire principal
        mv "$TEMP_DIR/indexg.html" "$LOCAL_DIR"
        update_nodejs_server
    else
        echo "Aucune mise à jour du dépôt GitHub."
    fi

    # Supprimer le répertoire temporaire après utilisation
    rm -rf "$TEMP_DIR"
}

# Fonction pour mettre à jour le serveur Node.js
update_nodejs_server() {
    cd "$LOCAL_DIR"

    # Comparer les deux fichiers
    diff indexg.html index.html > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Les fichiers sont identiques."
    else
        echo "Les fichiers ne sont pas identiques. Mise à jour de index."
        cp indexg.html index.html
        pm2 restart all
        echo "Serveur Node.js mis à jour avec la nouvelle version du fichier index.html."
    fi
}

# Boucle principale
while true; do
    check_github_update
    sleep 60 # Attendre 1 minute avant de vérifier à nouveau
done
