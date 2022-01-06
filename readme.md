CESTINATOR usage

cestinator.sh -d  (delete) rimuovi file
cestinator.sh -r (restore) ripristina file
cestinator.sh -c (chronology) cronologia dei file e eliminati
cestinator.sh -h (help) pagina di aiuto.
esempio cestinator.sh -d /tmp/foto.png
                                    2022 Martino Cimarosti
----------------------------------------------------------

Come Utilizzare Il Programma
Nb il programma richiere privilegi di root
-------------------------------
Rimuovere un file/cartella
Per rimovre un file bisoogna utlizzare lo sript nel seguente modo
esemmpio cestinator.sh -d /path/to/file
-------------------------------
Visualizzare file eliminati e ripistinarli
utlilizzare il programma nel seguente modo
cestinator.sh -c
questo da una lista di file, segnare il nome del file/cartella
da ripristinare.
Per ripistinare il file usare la funzionre -r nel seguente modo
(bastano solo il nome del file o della directory da ripristinare)
cestinator.sh -r nomefile
Il file verrà ripristinato nella directory da cui è stato eliminato
-----------------------------
Per ripristinare i file manualmente andare sulla directory
/usr/local/bin/cestinator/
