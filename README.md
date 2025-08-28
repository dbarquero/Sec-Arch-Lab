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
