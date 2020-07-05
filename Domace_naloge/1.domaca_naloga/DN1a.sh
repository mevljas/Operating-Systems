#!/bin/bash
if [ $# -eq 1 ]; then
    mkdir -p "$1"/skel
    cd "$1"/skel
    cp -r /etc/skel/.  .
    mkdir Desktop Documents Downloads Public
    ln -s /var/www www-root
    cd -
else
    echo "NAPAKA: Podano napačno število argumentov."
    echo "Podajte natanko en argument."
    exit 1
fi

