#!/bin/bash

argumenti=("$@")
p=-10   #nova stopnja prioritete ciljnega procesa
n=3     #število instanc ciljnega procesa
s=2     #stopnja nižanja prioritete drugih procesov
t=$(echo "scale=3; 300/1000" | bc -l)    # privzeti čas med posameznim kreiranjem instance v milisekundah.
#c  is a language that supports arbitrary precision numbers with interactive execution of statements.
 
ukaz=""     #kakonična pot podanega ukaza
log=""
config=""

[[ $# -eq 0 ]] && echo "Napaka: napačni argumenti" 1>&2 && exit 1           #napačni argumenti
    
if [[ "$2" != "" ]]; then       #če je podana datoteka

    config="$2"                 #shrani datoteko      

    [[ ! -e "$config" ]] && echo "Napaka: datoteka ne obstaja" 1>&2 && exit 2          #podana datoteka ne obstaja
    
    while read -r vrstica; do   #bere besede
        stikalo=$(echo "$vrstica" | cut -f 1 -d ':' )
        vrednost=$(echo "$vrstica" | cut -f 2 -d ':')

        case "$stikalo" in       
        "n")
            ((i++))   
            n="$vrednost"
            ;;
        "p")
            ((i++))   
            p="$vrednost"
            ;;
        "s")
            ((i++))   
            s="$vrednost"
            ;;
        "t")
            ((i++))
            t=$(echo "scale=3; "$vrednost"/1000" | bc -l)    #spremeni v ms
            ;;
        "log")
            ((i++))
            log="$vrednost"
            ;;
    esac  
  
  
    done <"$config"
fi


argument1=($1) #tabela arumenta
kanonicna_pot_ukaza=$( sudo readlink -f "${argument1[0]}" )     #dobi kanonično pot ukaza
st_procesov=0       #counter procesov



for pid in $(sudo ps ax --no-headers -o pid ); do            #loop skozi ps
    kanonicna_pot_procesa=$(sudo readlink -f /proc/"${pid}"/exe)

    if [[ "$kanonicna_pot_procesa" == "$kanonicna_pot_ukaza" ]]; then  #če gre za isti ukaz
        
        ((st_procesov++))       #poveča število procesov
        sudo renice -n "$p" -p "$pid" 1>/dev/null   #spremeni prioriteto

    else                        #ostali ukazi/procesi
       previous_nice=$(sudo ps --no-headers -o ni -p "$pid" )     #niceness of a process brez naslovne vrstice
       if [[ "$previous_nice" =~ [[:digit:]] ]]; then            #pazi, da ni "-" ali ""
            new_nice=$(("previous_nice"+"s"))        #zračuna vrednost
            sudo renice -n "$new_nice" -p "$pid" &>/dev/null        #spremeni prioriteto
      
       fi

    fi
    
 
done

default_nice=$(nice)
new_nice=$(("p"-"default_nice"))
if [[ $st_procesov -lt $n ]]; then              #če je zagnanih premalo procesov, jih zažene
    for (( $st_procesov; st_procesov<$n; st_procesov++ )); do
         
        sudo nice -"$new_nice" ${1}&    &>/dev/null 
        sleep $t
    done
fi

echo "Na tem mestu, $(date +"%-d. %-m.") je Zajec Veliki pomagal procesu "$kanonicna_pot_ukaza"." | tee $log
       

exit 0   
