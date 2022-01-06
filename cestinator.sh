#/bin/bash/

#COLORI PER TESTI
RED=`tput setaf 1` #per gli errori
GREEN=`tput setaf 2` #per le operazioni riusite
YELLOW=`tput setaf 3` #per avvisi generici importanti all'utente
reset=`tput sgr0` #RESETTA IL COLORE UTILIZZATO A TERMINALE

#installazione cestinator
echo -e "${GREEN}-Benvenuto su Cestinator-${reset}"
#controlla se la folder Cesinator esiste
if [ -d "/usr/local/bin/cestinator" ]
then
    echo "${GREEN}Cestinator è installato sul sistema.${reset}"
else
    echo "${YELLOW}Cestinator non è instllato sul tuo sistema${reset}"
    echo "${YELLOW}Installazione Cestinator sul sistema, permessi di root richiesti."
    sudo mkdir "/usr/local/bin/cestinator"
    sudo mkdir "/usr/local/bin/cestinator/data"
    if [ -d "/usr/local/bin/cestinator" ]
    then
        echo "${GREEN}Cestinator installato!${reset}"
        echo "${GREEN}Cestinator installato in /usr/local/bin/cestinator/${reset}"
    else
        #ULTERIORE CONTROLLO INSTALLAZIONE
        echo "${RED}---Installazione fallita---"
        echo "${RED}Sei sicuro di avere i premessi di root?${reset}"
        sleep 10
    fi
fi
# banner and usage
sleep 0.8
clear
  
                                             
echo "${GREEN}CESTINATOR usage${reset}"


echo "${YELLOW}cestinator.sh -d  (delete) rimuovi file"
echo "cestinator.sh -r (restore) ripristina file"
echo "cestinator.sh -c (chronology) cronologia dei file e eliminati"
echo "cestinator.sh -h (help) pagina di aiuto."
echo "${reset}${GREEN}esempio cestinator.sh -d /tmp/foto.png${reset}"
echo "                                    2022 Martino Cimarosti"
echo "----------------------------------------------------------"
echo "${reset}"

while getopts d:r:ch flag
do
    case "${flag}" in
        d) delete=${OPTARG}
        if [ -f "$delete" ]; then
        base="$(basename -- $delete)"
        checkfile="/usr/local/bin/cestinator/data/${base}"           
        #echo "check è${checkfile}"
            if [ -f "$checkfile" ]; then
            echo "${YELLOW}File con stesso nome presente sul cestino"
            echo "Il file verrà rinominato come ${base}-copy${reset}"
            echo "${delete} trovato"
            echo "Permessi di Root richiesti per l'eleiminazione."
            sudo cp -v ${delete} /usr/local/bin/cestinator/${base}-copy
            #sudo touch "/usr/local/bin/cestinator/data/$(basename $delete)"
            #base= basename $delete
            #echo "${base}"
            sudo bash -c "echo ${delete} > /usr/local/bin/cestinator/data/${base}-copy"
            sudo rm $delete
            echo "${GREEN}file elininato con successo!${reset}"
            echo "${YELLOW}Il file può essere recuperato con -r nomefile${reset}"          
            else
            echo "${delete} trovato"
            echo "Permessi di Root richiesti per l'eleiminazione."
            sudo cp -v ${delete} /usr/local/bin/cestinator/
            #sudo touch "/usr/local/bin/cestinator/data/$(basename $delete)"
            #base= basename $delete
            #echo "${base}"
            sudo bash -c "echo ${delete} > /usr/local/bin/cestinator/data/${base}"
            sudo rm $delete
            echo "${GREEN}file elininato con successo!${reset}"
            echo "${YELLOW}Il file può essere recuperato con -r nomefile${reset}"
        fi
        #cartella
        elif [ -d "$delete" ]; then
            echo "${GREEN}cartella ${delete} esiste${reset}"
            base="$(basename -- $delete)"
            basefolder= basename ${delete}
            checkfile="/usr/local/bin/cestinator/data/${base}"
            if [ -f "$checkfile" ]; then
            echo "${YELLOW}File con stesso nome presente sul cestino"
            echo "Il file verrà rinominato come ${base}-copy${reset}"
                echo "${basefolder}"
                sudo mv ${delete} /usr/local/bin/cestinator/${base}--copy
                base="$(basename -- $delete)"
                sudo bash -c "echo ${delete} > /usr/local/bin/cestinator/data/${base}--copy"
                echo "${GREEN} Cartella eliminata!${reset}"           
            else
            echo "${basefolder}"
            sudo mv ${delete} /usr/local/bin/cestinator/
            base="$(basename -- $delete)"
            sudo bash -c "echo ${delete} > /usr/local/bin/cestinator/data/${base}"
            echo "${GREEN}Cartella eliminata!${reset}"
            fi
        else
            echo "${RED}File non trovato, controlla il percorso.${reset}"
        fi;;
        r) restore=${OPTARG}
            frestore=/usr/local/bin/cestinator/data/${restore}
            ogfile=/usr/local/bin/cestinator/${restore}
            if [ -f "$ogfile" ]; then
                echo "$restore esiste."
                ogpath=`sudo cat ${frestore}`
                echo "${ogpath}"
                sudo cp -v ${ogfile} ${ogpath}
                echo "${GREEN}file ripristinato correttamente${reset}"
                echo "${YELLOW}Pulizia in corso..."
                sudo rm ${frestore}
                sudo rm ${ogfile}


            elif [[ -d $ogfile ]]; then
                echo "$frestore is a directory"
                ogpath=`sudo cat ${frestore}`
                sudo mv ${ogfile} ${ogpath}
                echo "${GREEN}Cartella ripristinata correttamente${reset}"
                echo "${YELLOW}Pulizia in corso..."
                sudo rm ${frestore}
                sudo rm -d ${ogfile}
            else
            echo "${RED}$restore il file non è presente nel cestino${reset}"
            fi;;
        c) chronology=${OPTARG}
            echo "${GREEN}LISTA FILE ELIMINATI IN ORNINE CRONOLOGICO${reset}"
            
            echo "${GREEN}---Inizio lista---${reset}${YELLOW}"
            sudo ls -t /usr/local/bin/cestinator/data/
            echo "${reset}${GREEN}----Fine lista----"
			echo "6a05968dc6d7607f14f39bb3bbde4b2d";;
			

        h) folder=${OPTARG}
            echo "${GREEN}Come Utilizzare Il Programma${reset}"
            echo "${RED}Nb il programma richiere privilegi di root${reset}"
            echo "${YELLOW}-------------------------------"
            echo "Rimuovere un file/cartella"
            echo "Per rimovre un file bisoogna utlizzare lo sript nel seguente modo"
            echo "esemmpio cestinator.sh -d /path/to/file"
            echo "-------------------------------"
            echo "Visualizzare file eliminati e ripistinarli"
            echo "utlilizzare il programma nel seguente modo"
            echo "cestinator.sh -c"
            echo "questo da una lista di file, segnare il nome del file/cartella"
            echo "da ripristinare."
            echo "Per ripistinare il file usare la funzionre -r nel seguente modo"
            echo "(bastano solo il nome del file o della directory da ripristinare)"
            echo "cestinator.sh -r nomefile"
            echo "Il file verrà ripristinato nella directory da cui è stato eliminato"
            echo "-----------------------------"
            echo "Per ripristinare i file manualmente andare sulla directory"
            echo "/usr/local/bin/cestinator/"
            echo ""
            
            ;;
    esac
done