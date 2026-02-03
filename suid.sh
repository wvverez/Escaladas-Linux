#!/bin/bash

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
AZUL='\033[0;34m'
NC='\033[0m'

BASE_URL_GTFO="https://gtfobins.github.io/gtfobins/"
EXCLUDED_SUID_BINARIES="passwd sudo su chsh chfn gpasswd newgrp mount"

imprimir_seccion() {
    echo -e "\n${AZUL}--- [ $1 ] ---${NC}"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}


echo -e "${ROJO}
   _____ _    _ _____ _____      _____ _______ ______ ____  
  / ____| |  | |_   _|  __ \    / ____|__   __|  ____/ __ \ 
 | (___ | |  | | | | | |  | |  | |  __   | |  | |__ | |  | |
  \___ \| |  | | | | | |  | |  | | |_ |  | |  |  __|| |  | |
  ____) | |__| |_| |_| |__| |  | |__| |  | |  | |   | |__| |
 |_____/ \____/|_____|_____/    \_____|  |_|  |_|    \____/ 
                                                            
                                                            ${NC}"
                                                      
                                                      


echo -e "${ROJO}---------------------------------------------${NC}"
echo -e "${ROJO}[*] Creador: Wvverez, JV${NC}"
echo -e "${ROJO}[*] https://github.com/wvverez${NC}"
echo -e "${ROJO}[*] Analisis SUID en SO Linux${NC}"
echo -e "${ROJO}---------------------------------------------${NC}"


existe_en_gtfobins() {
    local binary_name="$1"
    local url="${BASE_URL_GTFO}${binary_name}/"
    local http_code=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")
    [ "$http_code" -eq 200 ]
}
          
buscar_suid() {
    echo -e "${AMARILLO}[*] Buscando y verificando binarios SUID en GTFObins... (puede tardar)${NC}"
    echo -e "${AMARILLO}[*] Excluyendo: $EXCLUDED_SUID_BINARIES${NC}"
    local encontrados=false
    while read -r binary; do
        binary_name=$(basename "$binary")
        if [[ " $EXCLUDED_SUID_BINARIES " =~ [[:space:]]${binary_name}[[:space:]] ]]; then
            continue
        fi
        if existe_en_gtfobins "$binary_name"; then
            echo -e "${VERDE}[+] SUID encontrado en GTFObins: $binary${NC}"
            gtfo_link="${BASE_URL_GTFO}${binary_name}/"
            echo ""
            echo -e " -> Enlace: ${AZUL}$gtfo_link${NC}"
            echo ""
            encontrados=true
        fi
    done < <(find / -type f -perm -u=s -xdev 2>/dev/null)
    if [ "$encontrados" = false ]; then
        echo -e "${ROJO}[*] No se encontraron binarios SUID interesantes con entrada en GTFObins.${NC}"
    fi
}


echo -e "${VERDE}[*] Iniciando análisis de seguridad filtrado por GTFObins...${NC}"

if [ "$(id -u)" -ne 0 ]; then
    echo -e "\n${AMARILLO}ADVERTENCIA: Este script se recomienda ejecutarlo como root para obtener resultados completos.${NC}"
    read -p "¿Desea continuar de todos modos? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[*] Saliendo del script."
        exit 1
    fi
fi

if ! command_exists "curl"; then
    echo -e "${ROJO}[!] Error: El comando 'curl' no está instalado. Es necesario para verificar GTFObins.${NC}"
    echo "[*] Por favor, instálalo antes de continuar (ej: 'sudo apt install curl' o 'sudo yum install curl')."
    exit 1
fi

buscar_suid
echo -e "\n${VERDE}[*] Análisis completado.${NC}"
