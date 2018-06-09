# Restart vault which will seal them again
ansible hashicorp -m shell -u root -a "systemctl restart vault"
