1. The host machine must have cfssl and vagrant installed.
On Ubuntu, the command to install cfssl is ```sudo apt install golang-cfssl```

2. Run ```./init_ca.sh```. This will create the certificate authority root key and certificate required to establish the PKI.

3. Run ```vagrant up```.
