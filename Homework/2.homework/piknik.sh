#!/bin/bash

datoteka="besede.txt"
argumenti=("$@")
zahtevana_dolzina_besede=${#1}
znaki=""
stikalo_p=false  
j=0 #stevec stikala p


primerjaj(){
  local niz="$1"
  local beseda="$2"

  [[ "${#beseda}" -eq 0 ]] && return 1
  [[ "${#niz}" -eq 0 ]] && return 0

  primerjaj "${niz:1}" "${beseda/${niz:0:1}/}"
}



    
for ((i=0; i<$#; i++)); do  #loop skozi argumente  
  
    case "${argumenti[i]}" in 

        "-n")   
            ((i++))
            [[ "${argumenti[i]}" == "" ]] &&  echo "Napaka: napačni argumenti -n." >&2 && exit 1
            [[ "${argumenti[i]}" == "-"* ]] &&  echo "Napaka: napačni argumenti -n." >&2 && exit 2
            zahtevana_dolzina_besede="${argumenti[i]}"
            ;;

        "-f")
            ((i++))
            [[ "${argumenti[i]}" == "" ]] &&  echo "Napaka: napačni argumenti -f." >&2 && exit 3
            [[ "${argumenti[i]}" == "-"* ]] &&  echo "Napaka: napačni argumenti -f." >&2 && exit 4
            datoteka="${argumenti[i]}"
            ;;

        "-p")
            ((i++))
            [[ "${argumenti[i]}" == "" ]] &&  echo "Napaka: napačni argumenti -p." >&2 && exit 5
            tmp="${argumenti[i]}"
            [[ "${#tmp}" -gt 1 ]] &&  echo "Napaka: napačni argumenti -p." >&2 && exit 6
            [[ "${argumenti[i]}" == "-"* ]] &&  echo "Napaka: napačni argumenti -p." >&2 && exit 7
            pozicija[j]="${argumenti[i]}" #shrani pozicijo črke
            [[ "${pozicija[j]}" != *[[:digit:]]* ]] && echo "Napaka: prvi argument ni število -p." >&2 && exit 8
           
            ((pozicija[j]--))       #zmanjša pozicijo, ker se indexiranje začne z 0
            ((i++))
            tmp="${argumenti[i]}"
            [[ "${#tmp}" -gt 1 ]] &&  echo "Napaka: napačni argumenti -p." >&2 && exit 9
            crka[j]="${argumenti[i]}" #shrani crko
            [[ "${crka[j]}" == *[[:digit:]]* ]] &&  echo "Napaka: napačen drugi argument -p." >&2 && exit 10
            stikalo_p=true
            ((j++))
            ;;

        *)  
            [[ "${argumenti[i]}" == "-"* ]] &&  echo "Napaka: neznano stikalo." >&2 && exit 11 #namesto znakov imamo podano neznano stikalo
            [[ "$znaki" != "" ]] &&  echo "Napaka: neznano stikalo." >&2 && exit 12 #namesto znakov imamo podano neznano stikalo
            znaki="${argumenti[i]}"
            ;;

    esac

done

[ "$znaki" == "" ] &&  echo "Napaka: niz znakov ni podan." >&2 && exit 13

[[ "$znaki" =~ [0-9] ]] &&  echo "Napaka: niz znakov vsebuje število." >&2 && exit 14  #preverimo, da v znakih ni števil                                          
   
[ ! -e "$datoteka" ] && echo "Napaka: datoteka ne obstaja." >&2 && exit 15

if [[ "$zahtevana_dolzina_besede" == *"-"* ]]; then #preveri, ali je dolzina podana kot range
    zahtevana_dolzina_besede="${zahtevana_dolzina_besede/-/ }" # - zamenjamo z presedkom
    temp_dolzine=($zahtevana_dolzina_besede) #ustavri začasno tabelo range, split po presledku
    
    [[ ! "${temp_dolzine[0]}" =~ ^[0-9]+$ ]] && echo "Napaka: argument ni število -n" >&2 && exit 16 #preveri. če je res podano število (regex)
    [[ "${temp_dolzine[0]}" -le 0 || "${temp_dolzine[0]}" -gt ${#znaki} ]] &&  echo "Napaka: podana napačna dolžina besede." >&2 && exit 17
    [[ ! "${temp_dolzine[1]}" =~ ^[0-9]+$ ]] && echo "Napaka: argument ni število -n" >&2 && exit 18 #preveri. če je res podano število (regex)
    [[ "${temp_dolzine[1]}" -le 0 || "${temp_dolzine[1]}" -gt ${#znaki} ]] &&  echo "Napaka: podana napačna dolžina besede." >&2 && exit 19

    [[ "${temp_dolzine[1]}" -lt "${temp_dolzine[0]}" ]] &&  echo "Napaka: napačni argumenti -n." >&2 && exit 20
    sequenca=$(seq "${temp_dolzine[0]}"  "${temp_dolzine[1]}" ) #ustavri seq v rangu
    dolzine=($sequenca) #ustvari tabelo dolzin

elif [[ "$zahtevana_dolzina_besede" == *","* ]]; then #preveri, ali je podanih več dolzin
    zahtevana_dolzina_besede="${zahtevana_dolzina_besede/,/ }"
    dolzine=($zahtevana_dolzina_besede)

    for dolzina_besede in "${dolzine[@]}"; do
    
        [[ ! "$dolzina_besede" =~ ^[0-9]+$ ]] && echo "Napaka: argument ni število -n" >&2 && exit 21 #preveri. če je res podano število (regex)
        [[ "$dolzina_besede" -le 0 || "$dolzina_besede" -gt ${#znaki} ]] &&  echo "Napaka: podana napačna dolžina besede." >&2 && exit 22

    done

else
    [[ ! "$zahtevana_dolzina_besede" =~ ^[0-9]+$ ]] && echo "Napaka: argument ni število -n" >&2 && exit 23 #preveri. če je res podano število (regex)
    [[ "$zahtevana_dolzina_besede" -le 0 || "$zahtevana_dolzina_besede" -gt ${#znaki} ]] &&  echo "Napaka: podana napačna dolžina besede." >&2 && exit 24
    dolzine=($zahtevana_dolzina_besede) #notri je ena ali nobena vredost   
fi

    ustrezna_poz_crke=true; #preverja pozicijo in črko podano s -n




if [[ "$stikalo_p" == true ]]; then
    
    for (( i=0; i<"${#crka}"; i++ )); do

        [[ "$znaki" != *"${crka[i]}"*  ]] && echo "Napaka: niz znakov ne vsebuje zahtevane črke -p." >&2 && exit 25

        [[ "${pozicija[i]}" -lt 0 || "${pozicija[i]}" -ge ${#znaki} ]] &&  echo "Napaka: podan napačen indeks -p." >&2 && exit 26

    done

fi


 

    
while read -r vrstica; do   #bere besede

    for beseda in $vrstica; do  #spremenljivka ne sme biti v narekovajih, ker ne deluje split.

        
        [[ "$beseda" == *"-"* ]] && continue #beseda vsebuje nedovoljen znak --> ignore 
        [[ "$beseda" == *","* ]] && continue #beseda vsebuje nedovoljen znak --> ignore
        [[ "$beseda" == *"."* ]] && continue #beseda vsebuje nedovoljen znak --> ignore

        [[ "$beseda" == *"("* ]] && beseda="${beseda//(/}" #beseda vsebuje oklepaje --> zamenjava
        [[ "$beseda" == *")"* ]] && beseda="${beseda//)/}" #beseda vsebuje oklepaje --> zamenjava

        for dolzina_besede in "${dolzine[@]}"; do #loopa skozi podane dolžine
            

            if [[ "${#beseda}" -eq "$dolzina_besede" ]]; then   #če dolžina ustreza..
                
                ustrezna_poz_crke=true;            
                if [ "$stikalo_p" ]; then
                
                    for (( z=0; z<"${#crka[@]}"; z++)); do #preverja pozicijo in črko podano s -n
                        
                        if [[ "${beseda:${pozicija[$z]}:1}" != "${crka[$z]}" ]]; then #če črka ali pozicija ne ustreza...
                            ustrezna_poz_crke=false  
                            break; 
                        fi                                        

                    done        

                fi
                       
                [[ "$ustrezna_poz_crke" == true ]] && { primerjaj "$znaki" "$beseda"; [[ $? -eq 1 ]] && echo "$beseda"; }
                
             fi 
            
        done
    
    done
  
done <"$datoteka"


exit 0   
