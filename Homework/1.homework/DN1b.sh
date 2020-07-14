#!/bin/bash
if [[ $# -ge 2  &&  $# -le 3 ]]; then
    datoteka="$1"
    imenik="$2"
    mkdir -p "$imenik"
    while read vrstica; do
        uporabnik=${vrstica%":"*}       #odstrani vse z zadnje strani do vključno dvopičja
        geslo=${vrstica#*":"}           #odstrani vse s sprednje strani do vključno dvopičja
        if [ ${geslo:1:1} = "6" ]; then
            if [ -n "$3" ]; then
                useradd -m -d "$imenik/$uporabnik" -s /bin/bash -k "$3" -p "$geslo" "$uporabnik"
            else
                useradd -m -d "$imenik/$uporabnik" -s /bin/bash -p "$geslo" "$uporabnik"    
            fi
        else
            echo "$uporabnik" >&2 
        fi

    done < "$datoteka"
    
   
else
    echo "NAPAKA: Podano napačno število argumentov."
    echo "Podajte natanko dva ali tri argumente."
    exit 1
fi

