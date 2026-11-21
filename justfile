edit:
    sudo setfacl -R -m u:$USER:rwx /etc/nixos/OakdenOS/
restore:
    sudo setfacl -R -x u:$USER /etc/nixos/OakdenOS/

