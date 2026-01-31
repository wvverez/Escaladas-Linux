#!/bin/bash
# Creadores: Wvverez y JV
# Kles, Analizador para escaladas de privilegios en SO Linux.

# Colores
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
RESET='\e[0m'

cleanup() {
    echo -e "${RED}[*] Abandonando el script...${RESET}"
    exit 1
}
trap cleanup SIGINT

echo -e "${RED}
██╗  ██╗██╗     ███████╗███████╗    
██║ ██╔╝██║     ██╔════╝██╔════╝    
█████╔╝ ██║     █████╗  ███████╗    
██╔═██╗ ██║     ██╔══╝  ╚════██║    
██║  ██╗███████╗███████╗███████║    
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝    
                                    ${RESET}"

echo -e "${RED}-----------------------------------------------------${RESET}"
echo -e "${RED}[*] Creadores: Wvverez & JV${RESET}"
echo -e "${RED}[*] https://github.com/wvverez${RESET}"
echo -e "${RED}[*] Kles para Escalar privilegios en SO Linux${RESET}"
echo -e "${RED}-----------------------------------------------------${RESET}"
echo ""
check_history() {
    echo -e "${RED}[*] Bash History${RESET}"
    if [ -L ~/.bash_history ]; then
        readlink ~/.bash_history | grep -q "/dev/null" && \
        echo -e "${RED}[*] History enlazado a /dev/null${RESET}" || \
        echo -e "${YELLOW}[*] History enlazado${RESET}"
    else
        [ -r ~/.bash_history ] && \
        echo -e "${GREEN}[*] History legible ($(wc -l < ~/.bash_history) lineas)${RESET}" || \
        echo -e "${RED}[*] History no legible${RESET}"
    fi
}

analyze_perms() {
    echo -e "\n${YELLOW}[*] Analizando Permisos${RESET}"
    echo -e "${YELLOW}[*] SUID:${RESET}"
    find / -type f -perm -4000 2>/dev/null | head -5 | while read f; do
        echo -e "${GREEN}[+] $f${RESET}"
    done
    echo -e "\n${YELLOW}[*] Sudoers:${RESET}"
    grep -E "^[^#].*ALL=$$ALL$$" /etc/sudoers 2>/dev/null | head -3 | while read l; do
        echo -e "${GREEN}[+] $l${RESET}"
    done
    if command -v getcap >/dev/null; then
        echo -e "\n${YELLOW}[*] Capabilities:${RESET}"
        getcap -r / 2>/dev/null | grep -v "^/" | head -3 | while read c; do
            echo -e "${GREEN}[*] $c${RESET}"
        done
    fi
}

analyze_spoof() {
    echo -e "\n${YELLOW}[*] Analizando Spoofing${RESET}"
    echo -e "${YELLOW}[*] ARP:${RESET}"
    arp -a | head -3
    echo -e "\n${YELLOW}[*] DNS:${RESET}"
    cat /etc/resolv.conf 2>/dev/null | grep nameserver | head -2
    echo -e "\n${YELLOW}[*] Captura (5 seg):${RESET}"
    command -v tcpdump >/dev/null && \
    timeout 5 tcpdump -i any -n "arp or udp port 53" 2>/dev/null | while read p; do
        echo -e "${GREEN}[*] $p${RESET}"
    done || echo -e "${RED}[*] tcpdump no encontrado${RESET}"
}

analyze_logs() {
    echo -e "\n${YELLOW}[*] Analizando Logs${RESET}"
    for f in /var/log/syslog /var/log/auth.log /var/log/messages; do
        [ -f "$f" ] && echo -e "\n${YELLOW}[*] $f:${RESET}" && \
        tail -20 "$f" | grep -iE "error|fail|denied|attack" | head -3 | while read l; do
            echo -e "${RED}[*] $l${RESET}"
        done
    done
}

check_kernel() {
    echo -e "\n${YELLOW}[*] Version del Kernel${RESET}"
    k=$(uname -r)
    echo -e "${GREEN}[*] Actual: $k${RESET}"
    major=$(echo $k | cut -d. -f1)
    minor=$(echo $k | cut -d. -f2)
    if [ "$major" -lt 6 ] || { [ "$major" -eq 6 ] && [ "$minor" -lt 6 ]; }; then
        echo -e "${RED}[*] VULNERABLE: Version antigua${RESET}"
    else
        echo -e "${GREEN}[*] Kernel actualizado${RESET}"
    fi
}

case "$1" in
    -p|--history) check_history ;;
    -a|--analyze) analyze_perms ;;
    -s|--spoofer) analyze_spoof ;;
    --log) analyze_logs ;;
    --kernel) check_kernel ;;
    *) 
        echo -e "${GREEN}[*] Uso :$0 {-p | --history} Analisis de acceso al bash history una vez accedido al sistema${RESET}"
	echo ""
	echo -e "${GREEN}[*] Uso :$0 {-a | --analyze} Analisis de capabilities, Sudoers, SUID${RESET}"
	echo ""
	echo -e "${GREEN}[*] Uso :$0 {-s | --spoofer} Analisis de spoofing en el sistema${RESET}"
	echo ""
	echo -e "${GREEN}[*] Uso :$0 {--log}  Analisis de logs en el sistema.${RESET}"
	echo ""
	echo -e "${GREEN}[*] Uso :$0 {--kernel} Analisis de version de kernel${RESET}"
	echo ""
        exit 1
        ;;
esac
