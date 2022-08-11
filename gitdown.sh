#!/usr/bin/env bash
#
# gitdown.sh - Capaz de realizar o download de arquivos ou diretórios específicos 
#              dado a URL de um repositório no github.
# 
# Site......: https://github.com/pauloh-alc  
# Autor.....: Paulo Henrique Diniz de Lima Alencar.
# Manutenção: Paulo Henrique Diniz de Lima Alencar.
#
# ------------------------------------------------------------------------ #
#  Irá realizar um pseudo-download individual/específico de um arquivo ou 
#  diretório dado um repositório do github.
#
# Exemplos:
#      
#      $ ./gitdown.sh https://github.com/pauloh-alc/Estrutura-de-dados 5-Pilha
#      
#      Nesse caso o gitdown vai realizar o download de toda pasta "5-Pilha" e
#      armazenará no diretório /home/paulo/Downloads
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 06/08/2022, Paulo:
#       - Realizando o download de diretórios e files de forma individual
#   v1.1 11/08/2022, Paulo:
#       - Adicionando expressão regular para verificar validade da URL fornecida
#       - Tratamento de erros. Existência ou não de diretórios ou arquivos para download
#       - Realizando modularização do código
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
    user@localhost:~$ $0 https://github.com/user-name/my-repository file.html
"
# COLORS
RED="\033[31;1m"
GREEN="\033[32;1m"
WHITE="\033[37;0m"

REPOSITORY_LINK=$1
FILE_OR_DIRECTORY=$2
DISTRIBUITION=$(lsb_release -i | sed "s/.*://" | tr -d '\t')
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

[ "$DISTRIBUITION" = "Ubuntu" -o "$DISTRIBUITION" = "Debian" ] && [ ! -x $(which git) ] && sudo apt-get install git 1> /dev/null 2>&1
# Falta dicionar tratamento para outras distribuições, caso o git não esteja instalado e distro utilize outro gerenciador de pacotes!

# Quantidade de parâmetros é a correta?
if [ ! $# -eq 2 ]; then
  echo -e "${RED}Hey, you made some mistake!${WHITE}"
  echo "$HELP"
  exit 1
fi

# Verifica se URL passa na expressão regular, isto é, URL é válida ou não?
if [[ "$REPOSITORY_LINK" =~ ^https://github.com/[a-zA-Z0-9_.-]{1,39}[/]{1}[a-zA-Z0-9_.-]{1,101}$ ]]; then 
  REPOSITORY=$(echo "$1" | sed "s/https:\/\/.*.com//;s/\/.*\///;s/.git//")
else
  echo "Invalid parameter: '$1'"
  exit 1
fi
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

msg () {
  [ "$2" = "err" ] && echo -e "${RED}$1${WHITE}" || echo -e "${GREEN}$1${WHITE}"
}

remove_directory () {
  rm -rf $1
}

look_file_or_dir () {
  [ ! -d "$REPOSITORY" ] && git clone --quiet "$REPOSITORY_LINK"

  cd "$REPOSITORY"
  
  THE_PATH=$(find . -name "$FILE_OR_DIRECTORY" -type d)
  [ ! "$THE_PATH" ] && THE_PATH=$(find . -name "$FILE_OR_DIRECTORY" -type f)
}

check_existence_of_file_or_dir () {
  if [ ! "$THE_PATH" ]; then 
    msg "Hey! file or directory you want to download does not exist." "err"
    cd ..
    remove_directory $REPOSITORY
    exit 1
  fi
}

move_file_or_dir_to_download () {
  [ -d "$FILE_OR_DIRECTORY" ] && cp -r $THE_PATH "$HOME/Downloads/" || cp $THE_PATH "$HOME/Downloads/"
  msg "Successfully downloaded!"
  
  read -p "Are you going to download another file or directory? [y/n]: " OPTION
  OPTION=$(echo "$OPTION" | tr [a-z] [A-Z])
  [ "$OPTION" = "Y" ] && msg "Run the script again!" || cd .. ; remove_directory $REPOSITORY
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #

look_file_or_dir 

check_existence_of_file_or_dir

move_file_or_dir_to_download

# ------------------------------------------------------------------------ #
