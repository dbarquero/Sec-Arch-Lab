#  Sec-Arch-Lab – Firewall Automation

Este laboratorio demuestra cómo aplicar **Security as Code** en entornos cloud mediante la automatización de un **firewall con iptables** en Linux (probado en AWS EC2).

---

##  Objetivo
- Aplicar política de seguridad de **mínimo privilegio** (*default deny*).
- Permitir únicamente los servicios esenciales:  
  - SSH (22)  
  - HTTP (80)  
  - HTTPS (443)  
- Apertura dinámica de puertos adicionales mediante variables de entorno.  
- Registrar intentos de acceso bloqueados para análisis.  
- Versionar y documentar la configuración en GitHub para asegurar reproducibilidad y auditoría.

---

##  Uso del script `firewall_rules.sh`

### Aplicar reglas básicas
```bash
sudo ./firewall_rules.sh apply

---
##  Ejemplo de salida

Chain INPUT (policy DROP)
 pkts bytes target     prot opt in     out     source               destination
   10  1005 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
   22  6560 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0   ctstate RELATED,ESTABLISHED
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0   tcp dpt:22
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0   tcp dpt:80
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0   tcp dpt:443
    0     0 LOG        all  --  *      *       0.0.0.0/0            0.0.0.0/0   LOG flags 0 level 4 prefix "IPTables-Dropped: "
