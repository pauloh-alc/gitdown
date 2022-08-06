#!/usr/bin/env bash
#
# gitdown.sh - Capaz de realizar o download de arquivos ou diretórios específicos 
#              dado a URL de um repositório no github.
#
# Autor:      Paulo Henrique Diniz de Lima Alencar.
# Manutenção: Paulo Henrique Diniz de Lima Alencar.
#
# ------------------------------------------------------------------------ #
#  Irá realizar um pseudo-download individual/específico de um arquivo ou 
#  diretório dado um repositório do github.
#
# Exemplos:
#      
#      $ ./gitdown.sh https://github.com/pauloh-alc/Estrutura-de-dados 5-Pilha
#      Nesse caso o gitdown vai realizar o download de toda pasta "5-Pilha" e
#      armazenará no diretório /home/paulo/Downloads
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 06/08/2022, Paulo:
#       - Realizando o download de diretórios e files de forma individual
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
HELP="
  $(basename $0) Options & Help 
    
    gitdown - a pseudo-download of a file or directory from a github repository

    SYNOPSIS
          
            $0 [Repository URL] [Directory or file]
    
    EXEMPLE
    
    download file.html
    user@localhost:~$ $0 https://github.com/pauloh-alc/my-repository file.html
"
RED="\033[31;1m"
GREEN="\033[32;1m"
WHITE="\033[37;0m"
REPOSITORY_LINK=$1
FILE_OR_DIRECTORY=$2
# ------------------------------------------------------------------------ #

DISTRIBUITOR=$(lsb_release -i | sed "s/.*://" | tr -d '\t')
REPOSITORY=$(echo "$1" | sed "s/https:\/\/.*.com//;s/\/.*\///;s/.git//")

# ------------------------------- TESTES ----------------------------------------- #

[ "$DISTRIBUITOR" = "Ubuntu" -o "$DISTRIBUITOR" = "Debian" ] && [ ! -x $(which git) ] && sudo apt-get install git
# Depois adicionar tratamento para outras distribuições!
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #

if [ ! $# -eq 2 ]; then
  echo -e "${RED}Hey, you made some mistake!${WHITE}"
  echo "$HELP"
  exit 1
fi

[ ! -d $REPOSITORY ] && git clone --quiet "$REPOSITORY_LINK"

cd "$REPOSITORY"

RESULT=$(echo "$FILE_OR_DIRECTORY" | sed "s/.*\.//")

[ "$FILE_OR_DIRECTORY" = "$RESULT" ] && TYPE="d" || TYPE="f";
THE_PATH=$(find . -name "$FILE_OR_DIRECTORY" -type "$TYPE")

[ "$TYPE" = "d" ] && cp -r $THE_PATH "$HOME/Downloads/" || cp $THE_PATH "$HOME/Downloads/"

echo -e "${GREEN}Successfully downloaded!${WHITE}"

read -p "Are you going to download another file or directory? [y/n]: " OPTION
OPTION=$(echo "$OPTION" | tr [a-z] [A-Z])

[ "$OPTION" = "Y" ] && echo -e "${GREEN}Run the script again!" || cd .. ; rm -rf $REPOSITORY
# ------------------------------------------------------------------------ #
