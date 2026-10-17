#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

servicos=(
    apache2
    mysql
    ssh
    NetworkManager
    postgresql
    tor
    openvpn
    docker
    bluetooth
    cups
    ufw
    nginx
    mongod
    smbd
    dnsmasq
    cloudflared
)

resolver_php_fpm() {
    systemctl list-units --type=service --all 2>/dev/null \
        | grep -Eo 'php[0-9.]*-fpm\.service' | head -n 1
}

status_servico() {
    local s="$1"
    [[ "$s" == "php-fpm" ]] && s=$(resolver_php_fpm)
    if systemctl is-active --quiet "$s" 2>/dev/null; then
        printf "%b" "${GREEN}Ativo${NC}"
    else
        printf "%b" "${RED}Inativo${NC}"
    fi
}

boot_servico() {
    local s="$1"
    [[ "$s" == "php-fpm" ]] && s=$(resolver_php_fpm)
    if systemctl is-enabled --quiet "$s" 2>/dev/null; then
        printf "%b" "${GREEN}enabled${NC}"
    else
        printf "%b" "${RED}disabled${NC}"
    fi
}

mostrar_menu() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗"
    echo -e "║             Gerenciador de Serviços v3.1                 ║"
    echo -e "╚══════════════════════════════════════════════════════════╝${NC}"
    echo
    printf "  %-4s %-16s %-10s %-10s\n" "#" "SERVIÇO" "STATUS" "BOOT"
    echo -e "${CYAN}  ──────────────────────────────────────────────────────${NC}"

    for i in "${!servicos[@]}"; do
        local nome="${servicos[$i]}"
        local st
        local bt
        st=$(status_servico "$nome")
        bt=$(boot_servico "$nome")

        printf "  ${YELLOW}[%2d]${NC} %-16s " "$((i+1))" "$nome"

        local st_txt
        local bt_txt
        st_txt=$(echo -e "$st" | sed 's/\x1b\[[0-9;]*m//g')
        bt_txt=$(echo -e "$bt" | sed 's/\x1b\[[0-9;]*m//g')
        printf "%b%*s" "$st" $((10 - ${#st_txt})) ""
        printf "%b%*s\n" "$bt" $((10 - ${#bt_txt})) ""
    done

    echo -e "${CYAN}  ──────────────────────────────────────────────────────${NC}"
    echo -e "  ${YELLOW}[ 0]${NC} Sair"
    echo
}

submenu_servico() {
    local servico="$1"
    [[ "$servico" == "php-fpm" ]] && servico=$(resolver_php_fpm)

    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗"
    printf "${CYAN}║${NC}   Gerenciando: ${YELLOW}%-40s${NC} ${CYAN}║${NC}\n" "$servico"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "  Status:  $(status_servico "$servico")"
    echo -e "  No boot: $(boot_servico "$servico")"
    echo
    echo -e "  ${YELLOW}[1]${NC} Iniciar (start)"
    echo -e "  ${YELLOW}[2]${NC} Parar (stop)"
    echo -e "  ${YELLOW}[3]${NC} Reiniciar (restart)"
    echo -e "  ${YELLOW}[4]${NC} Habilitar no boot (enable)"
    echo -e "  ${YELLOW}[5]${NC} Desabilitar no boot (disable)"
    echo -e "  ${YELLOW}[6]${NC} Status detalhado"
    echo -e "  ${YELLOW}[7]${NC} Logs recentes"
    echo -e "  ${YELLOW}[0]${NC} Voltar"
    echo
    read -p "  Escolha: " acao

    case "$acao" in
        1) sudo systemctl start "$servico"   && echo -e "  ${GREEN}✔ Iniciado.${NC}" ;;
        2) sudo systemctl stop "$servico"    && echo -e "  ${RED}✖ Parado.${NC}" ;;
        3) sudo systemctl restart "$servico" && echo -e "  ${GREEN}✔ Reiniciado.${NC}" ;;
        4) sudo systemctl enable "$servico"  && echo -e "  ${GREEN}✔ Habilitado no boot.${NC}" ;;
        5) sudo systemctl disable "$servico" && echo -e "  ${RED}✖ Desabilitado no boot.${NC}" ;;
        6) systemctl status "$servico" --no-pager ;;
        7) sudo journalctl -u "$servico" -n 30 --no-pager ;;
        0) return ;;
        *) echo -e "  ${RED}Opção inválida.${NC}" ;;
    esac

    echo
    read -p "  Pressione ENTER para continuar..."
}

while true; do
    mostrar_menu
    read -p "  Escolha: " escolha

    if [[ "$escolha" == "0" ]]; then
        echo -e "${YELLOW}Saindo...${NC}"
        exit 0
    elif [[ "$escolha" =~ ^[0-9]+$ ]] && (( escolha >= 1 && escolha <= ${#servicos[@]} )); then
        submenu_servico "${servicos[$((escolha-1))]}"
    else
        echo -e "${RED}Escolha inválida.${NC}"
        sleep 1
    fi
done
