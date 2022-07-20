#!/usr/bin/bash

# TERMINAL COLORS
NO_COLOR="\e[0m"
WHITE="\e[0;17m"
BOLD_WHITE="\e[1;37m"
BLACK="\e[0;30m"
BLUE="\e[0;34m"
BOLD_BLUE="\e[1;34m"
GREEN="\e[0;32m"
BOLD_GREEN="\e[1;32m"
CYAN="\e[0;36m"
BOLD_CYAN="\e[1;36m"
RED="\e[0;31m"
BOLD_RED="\e[1;31m"
PURPLE="\e[0;35m"
BOLD_PURPLE="\e[1;35m"
BROWN="\e[0;33m"
BOLD_YELLOW="\e[1;33m"
GRAY="\e[0;37m"
BOLD_GRAY="\e[1;30m"
# END OF TERMINAL COLORS

#ABOUT
__dev__="mkdirlove"
__github__="https://github.com/mkdirlove"

function coolexit() {
clear
ifconfig $AD down > /dev/null 2>&1
macchanger -p $AD > /dev/null 2>&1
iwconfig $AD mode managed > /dev/null 2>&1
ifconfig $AD up > /dev/null 2>&1
rm RANDOM_wordlist.txt > /dev/null 2>&1
nmcli device connect $AD > /dev/null 2>&1
clear
title
echo -e "$BOLD_RED   Thanks for using this script"
echo -e "   GitHub:$BOLD_WHITE $__github__"
exit
}

function title() {
clear
echo -e "$BOLD_GREEN"                                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠃⠀⠀⠀⠀⠀⠀⠰⣶⡀⠀⠀"
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠁⣴⠇⠀⠀⠀⠀⠸⣦⠈⢿⡄⠀"
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡇⢸⡏⢰⡇⠀⠀⢸⡆⢸⡆⢸⡇⠀"
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡇⠘⣧⡈⠃⢰⡆⠘⢁⣼⠁⣸⡇⠀"
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣄⠘⠃⠀⢸⡇⠀⠘⠁⣰⡟⠀⠀"
echo "	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠃⠀⠀⢸⡇⠀⠀⠘⠋⠀⠀⠀"
echo "	 _____               ⢸⡇       _____               "
echo "	| __  |___ ___ ___ ___ ___   |   __|___ ___ _____ "
echo "	| __ -| -_| .'|  _| . |   |  |__   | . | .'|     |"
echo "	|_____|___|__,|___|___|_|_|  |_____|  _|__,|_|_|_|"
echo "	                                   |_|            "
echo -e "$BOLD_WHITE	          Developed by $__dev__"
echo " "
echo " "
}

title
sleep 1
echo -e "$BOLD_GREEN   Available wireless interfaces: "
echo -e -n "$BOLD_WHITE"
ifconfig | grep -e ": " | sed -e 's/: .*//g' | sed -e 's/^/   /'
echo " "
echo -n -e "$BOLD_BLUE   Enter your wireless interface > "
echo -n -e "$BOLD_WHITE"
read AD
clear
title
echo -e "$BOLD_BLUE  Choose an option:"
echo " "
echo -e "$BOLD_BLUE  1.$BOLD_WHITE Use default wordlist (1000 SSIDs)"
echo -e "$BOLD_BLUE  2.$BOLD_WHITE Create custom wordlist and use it"
echo -e "$BOLD_BLUE  3.$BOLD_WHITE Use existing wordlist"
echo -e "$BOLD_BLUE  4.$BOLD_WHITE Use random SSIDs wordlist"
echo " "
echo -n -e "$BOLD_BLUE  > "
echo -n -e "$BOLD_WHITE"
read DD
clear
if [ $DD == 1 ]; then
	nmcli device disconnect $AD > /dev/null 2>&1
	clear
	title
	echo -e "$BOLD_GREEN Starting process..."
	echo " If you want to stop it, press CTRL+C."
	echo " "
	trap coolexit EXIT
	sleep 1
	ifconfig $AD down
	macchanger -r $AD
	iwconfig $AD mode monitor
	ifconfig $AD up
	trap coolexit EXIT
	mdk3 $AD b -f ./SSID_List.txt -a -s 1000
fi
if [ $DD == 2 ]; then
	nmcli device disconnect $AD > /dev/null 2>&1
	clear
	title
	echo -n -e "$BOLD_BLUE Type a WiFi name (Max. length: 12) > "
	echo -n -e "$BOLD_WHITE"
	read WORD
	echo -n -e "$BOLD_BLUE How many SSIDs do you want to create? > "
	echo -n -e "$BOLD_WHITE"
	read N
	COUNT=1
	while [ $COUNT -lt $N ] || [ $COUNT -eq $N ]; do
		echo $WORD $COUNT >> $WORD"_wordlist.txt"
		let COUNT=COUNT+1
	done
	clear
	title
	echo -e "$BOLD_GREEN Starting process..."
	echo " If you wish to stop it, press CTRL+C."
	echo " "
	trap coolexit EXIT
	sleep 1
	ifconfig $AD down
	macchanger -r $AD
	iwconfig $AD mode monitor
	ifconfig $AD up
	trap coolexit EXIT
	mdk3 $AD b -f ./$WORD"_wordlist.txt" -a -s 1000
fi
if [ $DD == 3 ]; then
	nmcli device disconnect $AD > /dev/null 2>&1
	clear
	title
	echo -e "$BOLD_WHITE Note: Your wordlist mus be named as"
	echo -e " SSID_List.txt, otherwise the process won't work."
	echo " "
	echo -n -e "$BOLD_BLUE Type the name of your word list > "
	echo -n -e "$BOLD_WHITE"
	read OWN
	clear
	title
	echo -e "$BOLD_GREEN Starting process..."
	echo " If you want to stop it, press CTRL+C."
	echo -e "$BOLD_WHITE"
	sleep 1
	ifconfig $AD down
	macchanger -r $AD
	iwconfig $AD mode monitor
	ifconfig $AD up
	trap coolexit EXIT
	mdk3 $AD b -f ./$OWN -a -s $(wc -l $OWN | cut -f1 -d ' ')
fi
if [ $DD == 4 ]; then
	nmcli device disconnect $AD > /dev/null 2>&1
	clear
	title
	echo -n -e "$BOLD_BLUE How many SSIDs do you want to create? > "
	echo -n -e "$BOLD_WHITE"
	read N
	COUNT=1
	while [ $COUNT -lt $N ] || [ $COUNT -eq $N ]; do
		echo $(pwgen 14 1) >> "RANDOM_wordlist.txt"
		let COUNT=COUNT+1
	done
	clear
	title
	echo -e "$BOLD_GREEN Starting process..."
	echo " If you want to stop it, press CTRL+C."
	echo " "
	sleep 1
	ifconfig $AD down
	macchanger -r $AD
	iwconfig $AD mode monitor
	ifconfig $AD up
	trap coolexit EXIT
	mdk3 $AD b -f ./RANDOM_wordlist.txt -a -s $N
fi
