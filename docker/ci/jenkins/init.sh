#! /bin/bash

echo "------------------------------"
echo "| Jenkins image by jeonhwan  |"
echo "------------------------------"

# Prepare directories (ssh)
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh
touch $HOME/.ssh/known_hosts
touch $HOME/.ssh/config

# Add ssh configs
#echo "Host gitlab" >> $HOME/.ssh/config
#echo "Hostname 14.34.12.102" >> $HOME/.ssh/config
#echo "Port 7723" >> $HOME/.ssh/config
#echo "User mezzo" >> $HOME/.ssh/config

# copy ssh config
cat /tmp/.ssh/config > $HOME/.ssh/config

# Generate public private key pair
if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -q -N ""
    echo "=> Generated ssh keys"
fi
echo "=> Public key:"
cat $HOME/.ssh/id_rsa.pub


# Add known hosts
if [ -n "${KNOWN_HOSTS}" ]; then
    echo "=> Found known hosts"
    IFS=$'\n'
    arr=$(echo ${KNOWN_HOSTS} | tr "," "\n")
    for x in $arr
    do
        cat $HOME/.ssh/known_hosts | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding host to .ssh/known_hosts: $x"
            ssh-keyscan $x >> $HOME/.ssh/known_hosts
        fi
    done
fi

# Run the original jenkins script
source /usr/local/bin/jenkins.sh