#!/bin/bash
RED='\e[1;31m'; GREEN='\e[1;32m'; YELLOW='\e[1;33m'; MAGENTA='\e[1;35m'; CYAN='\e[1;36m'; RESET='\e[0m'
rainbow=("RED" "CYAN" "BLUE" "YELLOW" "GREEN" "MAGENTA")
cleanup() { printf "\n${RED}[x] Saliendo...${RESET}\n"; exit 1; }
trap cleanup SIGINT

printf "${RED}
 ::::::::: ::::::::::: ::::    :::  ::::::::   ::::::::  :::::::::      :::      ::::::::  :::    :::
:+:    :+:    :+:     :+:+:   :+: :+:    :+: :+:    :+: :+:    :+:   :+: :+:   :+:    :+: :+:   :+:
+:+    +:+    +:+     :+:+:+  +:+ +:+        +:+        +:+    +:+  +:+   +:+  +:+        +:+  +:+
+#++:++#+     +#+     +#+ +:+ +#+ +#++:++#++ +#+        +#++:++#:  +#++:++#++: +#+        +#++:++
+#+    +#+    +#+     +#+  +#+#+#        +#+ +#+        +#+    +#+ +#+     +#+ +#+        +#+  +#+
#+#    #+#    #+#     #+#   #+#+# #+#    #+# #+#    #+# #+#    #+# #+#     #+# #+#    #+# #+#   #+#
######### ########### ###    ####  ########   ########  ###    ### ###     ###  ########  ###    ###${RESET}"

echo ""
printf "${RED}---------------------------------------------------------------------------${RESET}\n"
printf "${GREEN}[-] Abuso de permisos sudoers - Capabilites - SUID\n[-] https://github.com/wvverez\n[-] Creador : @wvverez & @JVJIXFMCQ=\n${RED}---------------------------------------------------------------------------${RESET}\n"

ping -c 1 gtfobins.org >/dev/null 2>&1 || { printf "${RED}[x] Sin conexión a gtfobins.org${RESET}\n"; cleanup; }
[[ "$@" =~ "-u" ]] && rm -f binscrack.json
[ ! -f "binscrack.json" ] && { curl -s --url https://gtfobins.org/api.json -o "binscrack.json" || cleanup; }
gtfobins="$(cat binscrack.json)" || { printf "${RED}[x] Error cargando binscrack.json${RESET}\n"; cleanup; }
command -v jq >/dev/null 2>&1 || { printf "${RED}[x] Instala jq: sudo apt install jq${RESET}\n"; cleanup; }

ejecutables=($(echo "$gtfobins" | jq -r '.executables | keys[]'))
contextos=($(echo "$gtfobins" | jq -r '.contexts | keys[]'))
funciones=($(echo "$gtfobins" | jq -r '.functions | keys[]'))
cols=$(($(tput cols)/26)) || cols=3

hazlistas() {
    local color="${!rainbow[$((RANDOM % 6))]}"
    printf "\n${color}[-] Buscando $1 con: $2${RESET}"
    local n=1
    
    for ((i=0;i<$1;i++)); do
        printf "${color}%2d)%-12s " "$((i+1))" "${2[$i]}"
        (( (i+1) % cols == 0 )) && echo
    done
}

buscaen() {
    local color="${!rainbow[$((RANDOM % 6))]}"
    printf "\n${color}[-] Buscando $1 con: $2${RESET}\n"
    local n=1
    expanded_array="$1[@]"
    for item in "${!expanded_array}"; do
   [[ "$item" =~ $2 ]] && printf "${color}%2d)%-12s " "$((n++))" "$item" && (( n % cols == 0 )) && echo
    done
}

types_of_bins() {
    read -r ejec
    # Comprobar si el binario existe en la base de datos
    if ! echo "$gtfobins" | jq -e ".executables.\"$ejec\"" > /dev/null; then
        printf "${RED}[x] El binario '$ejec' no se encuentra en la base de datos.${RESET}\n"
        return
    fi

    # Obtener la lista de tipos de funciones (ej: shell, file-read)
    local eje_tipos=($(echo "$gtfobins" | jq -r ".executables.\"$ejec\".functions | keys[]"))

    for ejet in "${eje_tipos[@]}"; do
        echo -e "\n${YELLOW}[-] $ejec - $ejet${RESET}"

        # Obtener los datos de la función específica
        local func_data=$(echo "$gtfobins" | jq -r ".executables.\"$ejec\".functions.\"$ejet\"")

        # Comprobar si 'func_data' es un array o un objeto
        if echo "$func_data" | jq -e 'if type == "array" then .[0] else . end' > /dev/null; then
            # Es un array (como file-read, file-write). Usamos el primer elemento [0]
            echo "Código: $(echo "$func_data" | jq -r '.[0].code // "N/A"')"
            echo "Notas: $(echo "$func_data" | jq -r '.[0].comment // "N/A"')"
            echo "SUID: $(echo "$func_data" | jq -r '.[0].contexts.suid.code // "N/A"')"
        else
            # Es un objeto (como shell). Accedemos directamente.
            echo "Código: $(echo "$func_data" | jq -r '.code // "N/A"')"
            echo "Notas: $(echo "$func_data" | jq -r '.comment // "N/A"')"
            echo "SUID: $(echo "$func_data" | jq -r '.contexts.suid.code // "N/A"')"
        fi
    done
}

main_loop() {
    while true; do
        printf "\n${CYAN}[#] Buscar binarios (escribe término, '&' para detalles, '\$' para salir):${RESET} "
        read -r selec_menu
        case "$selec_menu" in
            '$') cleanup ;;
            '&') types_of_bins ;;
            *) [ -n "$selec_menu" ] && buscaen ejecutables "$selec_menu" ;;
        esac
    done
}

main_loop
