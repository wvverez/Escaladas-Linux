#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
NC='\033[0m'

BASE_URL_GTFO="https://gtfobins.github.io/gtfobins/"
EXCLUDED_SUDOERS_BINARIES="passwd sudo su chsh chfn gpasswd newgrp mount"

imprimir_seccion() {
    echo -e "\n${AZUL}--- [ $1 ] ---${NC}"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${ROJO}
    _____ _    _ _____   ____  ______ _____   _____     _____ _______ ______ ____  
  / ____| |  | |  __ \ / __ \|  ____|  __ \ / ____|   / ____|__   __|  ____/ __ \ 
 | (___ | |  | | |  | | |  | | |__  | |__) | (___    | |  __   | |  | |__ | |  | |
  \___ \| |  | | |  | | |  | |  __| |  _  / \___ \   | | |_ |  | |  |  __|| |  | |
  ____) | |__| | |__| | |__| | |____| | \ \ ____) |  | |__| |  | |  | |   | |__| |
 |_____/ \____/|_____/ \____/|______|_|  \_\_____/    \_____|  |_|  |_|    \____/ 
                                                                                  
                                                                                  ${NC}"
echo -e "${ROJO}---------------------------------------------${NC}"
echo -e "${ROJO}[*] Creador: Wvverez, JV${NC}"
echo -e "${ROJO}[*] https://github.com/wvverez${NC}"
echo -e "${ROJO}[*] Análisis de permisos sudoers en SO Linux${NC}"
echo -e "${ROJO}---------------------------------------------${NC}"

existe_en_gtfobins() {
    local binary_name="$1"
    local url="${BASE_URL_GTFO}${binary_name}/"
    local http_code=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")
    [ "$http_code" -eq 200 ]
}

buscar_sudoers() {
    echo -e "${AMARILLO}[*] Buscando y verificando binarios en sudoers con GTFObins... (puede tardar)${NC}"
    echo -e "${AMARILLO}[*] Excluyendo: $EXCLUDED_SUDOERS_BINARIES${NC}"
    local encontrados=false

    # Obtenemos la lista de binarios permitidos para el usuario actual via sudo -l
    while read -r binary; do
        binary_name=$(basename "$binary")
        if [[ " $EXCLUDED_SUDOERS_BINARIES " =~ [[:space:]]${binary_name}[[:space:]] ]]; then
            continue
        fi
        if existe_en_gtfobins "$binary_name"; then
            echo -e "${VERDE}[+] Binario en sudoers encontrado en GTFObins: $binary${NC}"
            gtfo_link="${BASE_URL_GTFO}${binary_name}/"
            echo ""
            echo -e " -> Enlace: ${AZUL}$gtfo_link${NC}"
            echo ""
            encontrados=true
        fi
    done < <(sudo -l 2>/dev/null | grep -Eo '(may run|may run the following commands)*\s*[/][^\s]*' | awk '{print $NF}' | sort -u)

    if [ "$encontrados" = false ]; then
        echo -e "${ROJO}[*] No se encontraron binarios en sudoers interesantes con entrada en GTFObins.${NC}"
    fi
}

echo -e "${VERDE}[*] Iniciando análisis de seguridad filtrado por GTFObins...${NC}"

if ! command_exists "curl"; then
    echo -e "${ROJO}[!] Error: El comando 'curl' no está instalado. Es necesario para verificar GTFObins.${NC}"
    echo "[*] Por favor, instálalo antes de continuar (ej: 'sudo apt install curl' o 'sudo yum install curl')."
    exit 1
fi

buscar_sudoers

echo -e "\n${VERDE}[*] Análisis completado.${NC}"
