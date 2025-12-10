SSH Hardening

To secure my services VM, I applied basic SSH hardening steps:

Disabled password authentication and forced key-based login

Disabled root login over SSH

Installed and configured fail2ban

Ensured only necessary ports are open

These changes reduce the risk of brute-force attacks and improve the overall security posture of my homelab. Hardening SSH is a small but meaningful step toward treating the environment like a real production system.
