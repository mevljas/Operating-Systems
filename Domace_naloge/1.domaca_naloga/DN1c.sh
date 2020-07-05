#!/bin/bash
if [ $# -ge 2 ]; then
    datoteka="$1"
    for user in ${*:2}; do
        setfacl -m "u:$user:r-x" "$datoteka"
    done 
    
   
else
    echo "NAPAKA: Podano napačno število argumentov."
    echo "Podajte vsaj dva argumenta."
    exit 1
fi

