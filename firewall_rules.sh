#!/usr/bin/env bash
# firewall_rules.sh - Configuración de firewall con iptables
# Autor: CyberBalance CR

set -e

ACTION=$1

apply_rules() {
  echo "[+] Aplicando reglas de firewall..."

  # Limpiar reglas previas
  iptables -F
  iptables -X
  iptables -Z

  # Política por defecto: DROP
  iptables -P INPUT DROP
  iptables -P FORWARD DROP
  iptables -P OUTPUT ACCEPT

  # Permitir loopback
  iptables -A INPUT -i lo -j ACCEPT

  # Permitir conexiones establecidas
  iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

  # Permitir SSH, HTTP y HTTPS
  iptables -A INPUT -p tcp --dport 22 -j ACCEPT
  iptables -A INPUT -p tcp --dport 80 -j ACCEPT
  iptables -A INPUT -p tcp --dport 443 -j ACCEPT

  # Abrir puertos adicionales desde variables de entorno
  if [ -n "$EXTRA_TCP" ]; then
    for p in $(echo $EXTRA_TCP | tr "," " "); do
      iptables -A INPUT -p tcp --dport $p -j ACCEPT
      echo "TCP extra abierto: $p"
    done
  fi
  if [ -n "$EXTRA_UDP" ]; then
    for p in $(echo $EXTRA_UDP | tr "," " "); do
      iptables -A INPUT -p udp --dport $p -j ACCEPT
      echo "UDP extra abierto: $p"
    done
  fi

  # Log de paquetes bloqueados
  iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
}

flush_rules() {
  echo "[+] Limpiando reglas de firewall..."
  iptables -F
  iptables -X
  iptables -Z
  iptables -P INPUT ACCEPT
  iptables -P FORWARD ACCEPT
  iptables -P OUTPUT ACCEPT
}

case "$ACTION" in
  apply)
    apply_rules
    ;;
  flush)
    flush_rules
    ;;
  *)
    echo "Uso: $0 {apply|flush}"
    exit 1
    ;;
esac
