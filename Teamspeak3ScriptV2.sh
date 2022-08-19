#!/bin/bash
tarih="$(date +$(expr $(date +%d))"."%m"."%Y)"
kapat='\033[0m'
beyaz='\033[1;37m'
kirmizi='\033[0;31m'
mavi='\033[1;36m'
sari='\033[0;33m'
asari='\033[1;33m'
yesil='\033[0;32m'
ayesil='\033[1;32m'
kmavi='\033[1;34m'
pembe='\033[0;35m'
turkuaz='\033[0;36m'
gray='\033[0;37m'
akirmizi='\033[1;31m'
#Color Config End#
#################################################################

#----------------------------------------------------------------------------#

function startup {
    if [ "$(id -u)" != "0" ]; then
		echo -e "\033[0;31mScripti kullanmak için root yetkisine sahip olmanız gereklidir.\033[0m"
		exit
	fi
    if [ ! -d "/usr/lib/scroll" ]; then
        cd /usr/lib
        mkdir scroll >/dev/null 2>&1
    fi
    if [ ! -d "/usr/lib/scroll/temel_bilesen" ]; then
        echo -e "${turkuaz}+--------------------------------------------+"
        echo -e "¦                                            ¦"
        echo -e "¦         ${kirmizi}Temel bileşenler kuruluyor.        ${turkuaz}¦"
        echo -e "¦                                            ¦"
        echo -e "+--------------------------------------------+${kapat}"
        sleep 1
        mkdir /usr/lib/scroll/temel_bilesen >/dev/null 2>&1
        clear
    fi
}


#----------------------------------------------------------------------------#
                    # Anti-Blacklist Aktif Etme #
function aktif_et {
    if [ ! -d "/usr/lib/scroll/anti_blacklist" ]; then    
    clear && clear
    iptables -F
    iptables -X;
    iptables -t nat -F;
    iptables -t nat -X;
    iptables -t mangle -F;
    iptables -t mangle -X;
    iptables -P INPUT ACCEPT;
    iptables -P FORWARD ACCEPT;
    iptables -P OUTPUT ACCEPT;
    echo -e "${akirmizi}Önceden var olan iptables kuralları siliniyor.."
    sleep 0.5
    anti_blacklist
    echo -e "${kirmizi}Önceden var olan iptables kuralları silinmiştir.."
    sleep 0.5
    echo -e "${yesil}TS3 Blacklist koruması aktif edilmiştir.${kapat}"
    mkdir /usr/lib/scroll/anti_blacklist >/dev/null 2>&1
    else
    clear && clear 
    echo -e "${ayesil}Anti-Blacklist aktif gözükmektedir.${kapat}"
    fi
}

#----------------------------------------------------------------------------#
                    # Anti-Blacklist Deaktif Etme #
function deaktif_et {
    if [ -d "/usr/lib/scroll/anti_blacklist" ]; then
        clear && clear
        rm -rf /usr/lib/scroll/anti_blacklist >/dev/null 2>&1
        iptables -F
        iptables -X;
        iptables -t nat -F;
        iptables -t nat -X;
        iptables -t mangle -F;
        iptables -t mangle -X;
        iptables -P INPUT ACCEPT;
        iptables -P FORWARD ACCEPT;
        iptables -P OUTPUT ACCEPT;
        echo -e "${akirmizi}Önceden var olan iptables kuralları siliniyor.."
        sleep 0.5
        echo -e "${kirmizi}Önceden var olan iptables kuralları silinmiştir.."
        sleep 0.5
        echo -e "${beyaz}TS3 Blacklist koruması deaktif edilmiştir.${kapat}"
    else 
    clear && clear
    echo -e "${kirmizi}Anti-Blacklist koruması bulunamadı.${kapat}"
    fi
}

#----------------------------------------------------------------------------#
                    # Anti-Blacklist Silip baştan kurma #
function aktif_deaktif {
    if [ -d "/usr/lib/scroll/anti_blacklist" ]; then
        clear && clear
        rm -rf /usr/lib/scroll/anti_blacklist >/dev/null 2>&1
        iptables -F
        iptables -X;
        iptables -t nat -F;
        iptables -t nat -X;
        iptables -t mangle -F;
        iptables -t mangle -X;
        iptables -P INPUT ACCEPT;
        iptables -P FORWARD ACCEPT;
        iptables -P OUTPUT ACCEPT;
        echo -e "${akirmizi}Önceden var olan iptables kuralları siliniyor.."
        sleep 0.5
        anti_blacklist
        echo -e "${kirmizi}Önceden var olan iptables kuralları silinmiştir.."
        sleep 0.5
        echo -e "${beyaz}TS3 Blacklist koruması deaktif edilmiştir.${kapat}"
        sleep 2
    else 
    clear && clear
    echo -e "${kirmizi}Anti-Blacklist koruması bulunamadı."
    fi

    if [ ! -d "/usr/lib/scroll/anti_blacklist" ]; then    
        clear && clear
        iptables -F
        iptables -X;
        iptables -t nat -F;
        iptables -t nat -X;
        iptables -t mangle -F;
        iptables -t mangle -X;
        iptables -P INPUT ACCEPT;
        iptables -P FORWARD ACCEPT;
        iptables -P OUTPUT ACCEPT;
        echo -e "${akirmizi}Önceden var olan iptables kuralları siliniyor.."
        sleep 0.5
        anti_blacklist
        echo -e "${kirmizi}Önceden var olan iptables kuralları silinmiştir.."
        sleep 0.5
        echo -e "${yesil}TS3 Blacklist koruması aktif edilmiştir.${kapat}"
        mkdir /usr/lib/scroll/anti_blacklist >/dev/null 2>&1
        else 
        clear && clear
        echo -e "${ayesil}Anti-Blacklist aktif gözükmektedir.${kapat}"
    fi
}

                    # Anti-Blacklist işlemler bitiş #

#----------------------------------------------------------------------------#
                    # TeaSpeak Kurulumu #
function tea_kur {
clear && clear
if [ -d "/root/server" ]; then
clear
echo -e "${turkuaz}+--------------------------------------------------------+"
echo -e "¦  ${akirmizi}TeaSpeak dosyaları kurulu olduğu tespit edilmiştir.   ${turkuaz}¦"
echo -e "+--------------------------------------------------------+${kapat}"
exit
else
clear && clear
apt-get update -y
apt-get install zip -y
apt-get install unzip -y
apt install iptables-persistent netfilter-persistent -y
echo -e "${turkuaz}+--------------------------------------------------------+"
echo -e "¦             ${akirmizi}TeaSpeak kurulumu yapılıyor.               ${turkuaz}¦"
echo -e "+--------------------------------------------------------+${kapat}"
wget -q --no-check-certificate https://upload.vina-host.com/ipU51/TeaSpeak-1.4.22-beta_1.tar.gz
tar xf TeaSpeak-1.4.22-beta_1.tar.gz
rm -rf TeaSpeak-1.4.22-beta_1.tar.gz
cd server 
chmod +x tealoop.sh
chmod +x teastart.sh
chmod +x teastart_minimal.sh
su -c "./teastart.sh start"
clear && clear
echo -e "${turkuaz}+--------------------------------------------------------+"
echo -e "¦           ${akirmizi}Anti-Blacklist Koruması Ekleniyor.           ${turkuaz}¦"
echo -e "+--------------------------------------------------------+${kapat}"
aktif_deaktif
echo -e "+--------------------------------------------------------+${kapat}"
echo -e "${turkuaz}¦       ${ayesil}Anti-Blacklist Koruması aktif edilmiştir.        ${turkuaz}¦"
echo -e "+--------------------------------------------------------+${kapat}${kapat}"
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦${yesil}            Gihub @Bodrumlubebek/TeamspeakScriptV2            ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "---------------{ ${beyaz}$tarih ${turkuaz}}-----------------"
echo -e "¦                                            ¦"
echo -e "¦              ${beyaz}Yatqa Bilgileri${kapat}               ${turkuaz}¦"
echo -e "¦           ${sari}————————————————————${turkuaz}             ¦"
echo -e "¦                                            ¦"
echo -e "¦        Nickname  » ${turkuaz}serveradmin${kapat}             ${turkuaz}¦"
echo -e "¦        Şifre     » ${turkuaz}159753${kapat}                  ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "----------------------------------------------"
fi
}

#----------------------------------------------------------------------------------------------------------------------#


function sinusbot_kur {
	if [ ! -d "/usr/lib/scroll/sinusbot_bilesen" ]; then
		clear && clear
        echo -e "${turkuaz}+--------------------------------------------+"
        echo -e "¦                                            ¦"
        echo -e "¦         ${kirmizi}Temel bileşenler kuruluyor.        ${turkuaz}¦"
        echo -e "¦                                            ¦"
        echo -e "+--------------------------------------------+${kapat}"
		sleep 3
        apt-get update -y
        apt-get install docker.io -y
        clear
        docker pull trugamr/sinusbot-docker-yt-dlp
		echo "Saved.."
		echo " "
		echo "Saved.."
		mkdir /usr/lib/scroll/sinusbot_bilesen
	fi
	clear
	echo -e -n "\e[1;36mPort(ları) Girin (Çıkış için 0'ı tuşla)\e[0m: "
	read -a yeniport
	case $yeniport in
    0)
    clear && clear
    echo -e "${turkuaz}+--------------------------------------------+"
    echo -e "¦                                            ¦"
    echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
    echo -e "¦                                            ¦"
    echo -e "+--------------------------------------------+${kapat}"
    exit
	;;
	esac
	echo -e -n "\e[1;36mPanel Şifresi:\e[0m: "
	read sbotsifre
	docker run -d -p $yeniport:8087 -e OVERRIDE_PASSWORD=$sbotsifre --name $yeniport --restart=always trugamr/sinusbot-docker-yt-dlp
	clear
	echo -e "\033[1;32mKurulum tamamlandı, kurulan portlar aşağıda listelenmiştir."
	echo "http://sunucuipadresi:$yeniport ~ admin ~ $sbotsifre"
    exit
}


#----------------------------------------------------------------------------#
                    # Script menü #
function main {
clear && clear
startup
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦${yesil}            Gihub @Bodrumlubebek/TeamspeakScriptV2            ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "---------------{ ${beyaz}$tarih ${turkuaz}}-----------------"
echo -e "¦                                            ¦"
echo -e "¦             ${beyaz}TeaSpeak Yönetimi${kapat}              ${turkuaz}¦"
echo -e "¦           ${sari}—————————————————————${turkuaz}            ¦"
echo -e "¦                                            ¦"
echo -e "¦        (${yesil}1${turkuaz}) » ${turkuaz}TeaSpeak ~ Kur${kapat}                ${turkuaz}¦"
echo -e "¦        (${yesil}2${turkuaz}) » ${turkuaz}TeaSpeak ~ Başlat${kapat}             ${turkuaz}¦"
echo -e "¦        (${yesil}3${turkuaz}) » ${turkuaz}TeaSpeak ~ Durdur${kapat}             ${turkuaz}¦"
echo -e "¦        (${yesil}4${turkuaz}) » ${turkuaz}TeaSpeak ~ Reset At${kapat}           ${turkuaz}¦"
echo -e "¦        (${yesil}5${turkuaz}) » ${turkuaz}TeaSpeak ~ Yatqa Şifre${kapat}        ${turkuaz}¦"
echo -e "¦        (${yesil}6${turkuaz}) » ${turkuaz}TeaSpeak ~ Dosyaları Sil${kapat}      ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "¦                                            ¦"
echo -e "¦             ${beyaz}SinusBot Yönetimi${kapat}              ${turkuaz}¦"
echo -e "¦           ${sari}—————————————————————${turkuaz}            ¦"
echo -e "¦                                            ¦"
echo -e "¦       (${yesil}10${turkuaz}) » ${turkuaz}SinusBot ~ Kur${kapat}                ${turkuaz}¦"
echo -e "¦       (${yesil}11${turkuaz}) » ${turkuaz}SinusBot ~ Başlat${kapat}             ${turkuaz}¦"
echo -e "¦       (${yesil}12${turkuaz}) » ${turkuaz}SinusBot ~ Durdur${kapat}             ${turkuaz}¦"
echo -e "¦       (${yesil}13${turkuaz}) » ${turkuaz}SinusBot ~ Reset At${kapat}           ${turkuaz}¦"
echo -e "¦       (${yesil}14${turkuaz}) » ${turkuaz}SinusBot ~ Port Sil${kapat}           ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "¦                                            ¦"
echo -e "¦              ${beyaz}Anti-Blacklist${kapat}                ${turkuaz}¦"
echo -e "¦           ${sari}————————————————————${turkuaz}             ¦"
echo -e "¦                                            ¦"
echo -e "¦       (${yesil}20${turkuaz}) » ${turkuaz}Aktif Et${kapat}                      ${turkuaz}¦"
echo -e "¦       (${yesil}21${turkuaz}) » ${turkuaz}Deaktif Et${kapat}                    ${turkuaz}¦"
echo -e "¦       (${yesil}22${turkuaz}) » ${turkuaz}ServerList${kapat}                    ${turkuaz}¦"
echo -e "¦       (${yesil}23${turkuaz}) » ${turkuaz}Sil-Yeniden Kur${kapat}               ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "¦           (${kirmizi}0${turkuaz}) » Çıkış Yap                  ¦"
echo -e "¦                                            ¦"
echo -e "----------------------------------------------"
echo -e -n "¦ » ${yesil}Cevap:\033[1;33m"
read secenek
case $secenek in
#-------------------- TeaSpeak --------------------#
1)
clear && clear
tea_kur
;;
2)
clear && clear
cd /root/server
su -c "./teastart.sh start"
clear
echo -e "${yesil}TeaSpeak sunucusu başlatılmıştır."
;;
3)
clear && clear
cd /root/server
su -c "./teastart.sh stop"
clear
echo -e "${yesil}TeaSpeak sunucusu durdurulmuştur."
;;
4)
clear && clear
cd /root/server
su -c "./teastart.sh restart"
clear
echo -e "${yesil}TeaSpeak sunucusu yeniden başlatıldı."
;;
5)
clear && clear
cd /root/server
su -c "./teastart.sh stop"
echo -e "${mavi}######################################################################"
echo -e ""
echo -e "    ${sari}! KONSOL | QUERY ŞİFRE DEĞİŞTİRME REHBERİ !"
echo -e ""
echo -e "${yesil}"
echo -e "10 Saniye sonra konsol açılacak konsol açıldıktan sonra"
echo -e "5 Saniye bekleyin ardından şunu yazın"
echo -e "passwd yenişifre yenişifretekrar"
echo -e "Yazdıktan sonra ENTER tuşuna basın"
echo -e "Daha sonra konsoldan çıkmak için"
echo -e "CTRL Basılı tutup C harfine basın"
echo -e "Böylece konsol modu kapanıcaktır."
echo -e "Konsol modu açıkken lisans kapalıdır."
echo -e "Scriptten başlattığınızda normal olarak lisans başlatılır.        "           
echo -e ""
echo -e "${mavi}######################################################################"
sleep 10
su -c "./teastart_minimal.sh"
;;
6)
clear
cd /root/server
su -c "./teastart.sh stop"
cd ..
rm -rf server
clear && clear
echo -e "${yesil}TeaSpeak sunucusu silinmiştir."
;;
#-------------------- SinusBot --------------------#
10)
clear && clear
sinusbot_kur
exit
;;
11)
clear
echo -e -n "\e[1;36mBaşlatmak İstediğiniz Port(ları) Girin (Çıkış için 0'ı tuşla)\e[0m: "
read -a name2
case $name2 in
0)
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
esac
docker start $name2
echo -e "\033[1;37m(\033[1;34m$name2\033[1;37m) portu başlatıldı.\033[0m"
exit
;;
12)
clear
echo -e -n "\e[1;36mDurdurmak İstediğiniz Port(ları) Girin (Çıkış için 0'ı tuşla)\e[0m: "
read -a name2
case $name2 in
0)
clear && clea
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
esac
docker stop $name2
echo -e "\033[1;37m(\033[1;34m$name2\033[1;37m) portu durduruldu.\033[0m"
exit
;;
13)
clear
echo -e -n "\e[1;36mReset Atmak İstediğiniz Port(ları) Girin (Çıkış için 0'ı tuşla)\e[0m: "
read -a name2
case $name2 in
0)
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
esac
docker restart $name2
echo -e "\033[1;37m(\033[1;34m$name2\033[1;37m) portu reset atıldı.\033[0m"
exit
;;
14)
clear
echo -e -n "\e[1;36mSilmek İstediğiniz Port(ları) Girin (Çıkış için 0'ı tuşla)\e[0m: "
read -a name2
case $name2 in
0)
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
esac
docker rm -f $name2
echo -e "\033[1;37m(\033[1;34m$name2\033[1;37m) portu silindi.\033[0m"
exit
;;
#-------------------- Anti-Blacklist --------------------#
20)
clear && clear
aktif_et
exit
;;
21)
clear && clear
deaktif_et
exit
;;
22)
clear && clear
aktif_et && server_list
exit
;;
23)
clear && clear
aktif_deaktif
exit
;;
0)
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
*)
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦         ${akirmizi}Hatalı tuşlama yapıldı.            ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
exit
;;
esac
}

#----------------------------------------------------------------------------#

function anti_blacklist {
iptables -A INPUT -s 2.120.0.0/13 -j DROP
iptables -A INPUT -s 2.216.0.0/13 -j DROP
iptables -A INPUT -s 5.64.0.0/13 -j DROP
iptables -A INPUT -s 46.64.0.0/15 -j DROP
iptables -A INPUT -s 51.19.0.0/16 -j DROP
iptables -A INPUT -s 51.146.0.0/16 -j DROP
iptables -A INPUT -s 51.194.0.0/16 -j DROP
iptables -A INPUT -s 51.198.0.0/15 -j DROP
iptables -A INPUT -s 51.241.0.0/16 -j DROP
iptables -A INPUT -s 78.86.0.0/16 -j DROP
iptables -A INPUT -s 78.105.0.0/16 -j DROP
iptables -A INPUT -s 82.111.226.0/24 -j DROP
iptables -A INPUT -s 87.80.0.0/15 -j DROP
iptables -A INPUT -s 87.82.59.0/24 -j DROP
iptables -A INPUT -s 87.86.93.0/24 -j DROP
iptables -A INPUT -s 87.86.236.0/24 -j DROP
iptables -A INPUT -s 90.192.0.0/11 -j DROP
iptables -A INPUT -s 91.103.34.0/24 -j DROP
iptables -A INPUT -s 93.96.0.0/16 -j DROP
iptables -A INPUT -s 94.0.0.0/12 -j DROP
iptables -A INPUT -s 94.119.8.0/21 -j DROP
iptables -A INPUT -s 94.192.0.0/14 -j DROP
iptables -A INPUT -s 149.241.0.0/16 -j DROP
iptables -A INPUT -s 151.224.0.0/13 -j DROP
iptables -A INPUT -s 176.24.0.0/14 -j DROP
iptables -A INPUT -s 176.248.0.0/13 -j DROP
iptables -A INPUT -s 176.255.241.0/24 -j DROP
iptables -A INPUT -s 176.255.242.0/24 -j DROP
iptables -A INPUT -s 185.110.178.0/23 -j DROP
iptables -A INPUT -s 188.220.0.0/14 -j DROP
iptables -A INPUT -s 103.5.12.0/22 -j DROP
iptables -A INPUT -s 107.189.64.0/18 -j DROP
iptables -A INPUT -s 137.74.0.0/16 -j DROP
iptables -A INPUT -s 139.99.0.0/17 -j DROP
iptables -A INPUT -s 139.99.128.0/17 -j DROP
iptables -A INPUT -s 142.4.192.0/19 -j DROP
iptables -A INPUT -s 142.44.128.0/17 -j DROP
iptables -A INPUT -s 144.217.0.0/16 -j DROP
iptables -A INPUT -s 144.2.32.0/19 -j DROP
iptables -A INPUT -s 145.239.0.0/16 -j DROP
iptables -A INPUT -s 146.59.0.0/16 -j DROP
iptables -A INPUT -s 146.59.0.0/17 -j DROP
iptables -A INPUT -s 147.135.0.0/17 -j DROP
iptables -A INPUT -s 147.135.128.0/17 -j DROP
iptables -A INPUT -s 147.135.35.0/24 -j DROP
iptables -A INPUT -s 149.202.0.0/16 -j DROP
iptables -A INPUT -s 149.56.0.0/16 -j DROP
iptables -A INPUT -s 151.80.0.0/16 -j DROP
iptables -A INPUT -s 158.69.0.0/16 -j DROP
iptables -A INPUT -s 164.132.0.0/16 -j DROP
iptables -A INPUT -s 167.114.0.0/17 -j DROP
iptables -A INPUT -s 167.114.128.0/18 -j DROP
iptables -A INPUT -s 167.114.192.0/19 -j DROP
iptables -A INPUT -s 167.114.224.0/19 -j DROP
iptables -A INPUT -s 176.31.0.0/16 -j DROP
iptables -A INPUT -s 178.32.0.0/15 -j DROP
iptables -A INPUT -s 185.12.32.0/23 -j DROP
iptables -A INPUT -s 185.228.96.0/24 -j DROP
iptables -A INPUT -s 185.228.97.0/24 -j DROP
iptables -A INPUT -s 185.228.98.0/24 -j DROP
iptables -A INPUT -s 185.228.99.0/24 -j DROP
iptables -A INPUT -s 185.45.160.0/22 -j DROP
iptables -A INPUT -s 188.165.0.0/16 -j DROP
iptables -A INPUT -s 192.240.152.0/21 -j DROP
iptables -A INPUT -s 213.238.180.112/32 -j ACCEPT
iptables -A INPUT -s 192.95.0.0/18 -j DROP
iptables -A INPUT -s 192.99.0.0/16 -j DROP
iptables -A INPUT -s 193.104.19.0/24 -j DROP
iptables -A INPUT -s 193.109.63.0/24 -j DROP
iptables -A INPUT -s 193.70.0.0/17 -j DROP
iptables -A INPUT -s 195.110.30.0/23 -j DROP
iptables -A INPUT -s 195.246.232.0/23 -j DROP
iptables -A INPUT -s 198.100.144.0/20 -j DROP
iptables -A INPUT -s 198.245.48.0/20 -j DROP
iptables -A INPUT -s 198.27.64.0/18 -j DROP
iptables -A INPUT -s 198.27.92.0/24 -j DROP
iptables -A INPUT -s 198.50.128.0/17 -j DROP
iptables -A INPUT -s 205.218.49.0/24 -j DROP
iptables -A INPUT -s 213.186.32.0/19 -j DROP
iptables -A INPUT -s 213.251.128.0/18 -j DROP
iptables -A INPUT -s 213.32.0.0/17 -j DROP
iptables -A INPUT -s 216.32.192.0/24 -j DROP
iptables -A INPUT -s 217.182.0.0/16 -j DROP
iptables -A INPUT -s 23.92.224.0/19 -j DROP
iptables -A INPUT -s 37.187.0.0/16 -j DROP
iptables -A INPUT -s 37.59.0.0/16 -j DROP
iptables -A INPUT -s 37.60.48.0/21 -j DROP
iptables -A INPUT -s 37.60.56.0/21 -j DROP
iptables -A INPUT -s 46.105.0.0/16 -j DROP
iptables -A INPUT -s 46.105.198.0/24 -j DROP
iptables -A INPUT -s 46.105.199.0/24 -j DROP
iptables -A INPUT -s 46.105.200.0/24 -j DROP
iptables -A INPUT -s 46.105.201.0/24 -j DROP
iptables -A INPUT -s 46.105.202.0/24 -j DROP
iptables -A INPUT -s 46.105.203.0/24 -j DROP
iptables -A INPUT -s 46.105.204.0/24 -j DROP
iptables -A INPUT -s 46.244.32.0/20 -j DROP
iptables -A INPUT -s 51.161.0.0/17 -j DROP
iptables -A INPUT -s 51.161.128.0/17 -j DROP
iptables -A INPUT -s 51.178.0.0/16 -j DROP
iptables -A INPUT -s 51.195.0.0/16 -j DROP
iptables -A INPUT -s 51.210.0.0/16 -j DROP
iptables -A INPUT -s 51.222.0.0/16 -j DROP
iptables -A INPUT -s 51.254.0.0/15 -j DROP
iptables -A INPUT -s 5.135.0.0/16 -j DROP
iptables -A INPUT -s 51.38.0.0/16 -j DROP
iptables -A INPUT -s 51.68.0.0/16 -j DROP
iptables -A INPUT -s 51.75.0.0/16 -j DROP
iptables -A INPUT -s 51.77.0.0/16 -j DROP
iptables -A INPUT -s 51.79.0.0/17 -j DROP
iptables -A INPUT -s 51.79.128.0/17 -j DROP
iptables -A INPUT -s 51.81.0.0/17 -j DROP
iptables -A INPUT -s 51.81.128.0/17 -j DROP
iptables -A INPUT -s 51.81.128.0/24 -j DROP
iptables -A INPUT -s 51.81.129.0/24 -j DROP
iptables -A INPUT -s 51.81.145.0/24 -j DROP
iptables -A INPUT -s 51.81.146.0/24 -j DROP
iptables -A INPUT -s 51.81.147.0/24 -j DROP
iptables -A INPUT -s 51.81.148.0/24 -j DROP
iptables -A INPUT -s 51.81.153.0/24 -j DROP
iptables -A INPUT -s 51.81.225.0/24 -j DROP
iptables -A INPUT -s 51.81.231.0/24 -j DROP
iptables -A INPUT -s 51.81.234.0/24 -j DROP
iptables -A INPUT -s 51.81.235.0/24 -j DROP
iptables -A INPUT -s 51.83.0.0/16 -j DROP
iptables -A INPUT -s 51.89.0.0/16 -j DROP
iptables -A INPUT -s 51.91.0.0/16 -j DROP
iptables -A INPUT -s 5.196.0.0/16 -j DROP
iptables -A INPUT -s 5.39.0.0/17 -j DROP
iptables -A INPUT -s 54.36.0.0/16 -j DROP
iptables -A INPUT -s 54.37.0.0/16 -j DROP
iptables -A INPUT -s 46.105.112.65/32 -j DROP 
iptables -A INPUT -s 51.68.181.92/32 -j DROP  
iptables -A INPUT -s 34.249.40.203/32 -j DROP 
iptables -A INPUT -s 51.89.9.102/32 -j DROP 
iptables -A INPUT -s 194.97.114.3/32 -j DROP 
iptables -A INPUT -s 93.184.220.29/32 -j DROP
iptables -A INPUT -s 151.0.0.0/8 -j DROP
iptables -A INPUT -s 199.0.0.0/8 -j DROP
iptables -A INPUT -s 206.0.0.0/8 -j DROP
iptables -A INPUT -s 208.0.0.0/8 -j DROP
iptables -A INPUT -s 209.0.0.0/8 -j DROP
iptables -A INPUT -s 216.0.0.0/8 -j DROP
iptables -A INPUT -s 64.0.0.0/8 -j DROP
iptables -A INPUT -s 66.0.0.0/8 -j DROP
iptables -A INPUT -s 99.0.0.0/8 -j DROP
iptables -A INPUT -s 108.0.0.0/8 -j DROP
iptables -A INPUT -s 141.174.0.0/16 -j DROP
iptables -A INPUT -s 45.24.40.0/22 -j DROP
iptables -A INPUT -s 45.25.248.0/22 -j DROP
iptables -A INPUT -s 150.0.0.0/8 -j DROP
iptables -A INPUT -s 205.0.0.0/8 -j DROP
iptables -A INPUT -s 172.0.0.0/8 -j DROP
iptables -A INPUT -s 104.0.0.0/8 -j DROP
sudo service netfilter-persistent save
sudo service netfilter-persistent reload
}
function server_list {
iptables -D INPUT -s 51.68.181.92/32 -j DROP 
iptables -I INPUT -p tcp --dport 2010 -j ACCEPT
sudo service netfilter-persistent save
sudo service netfilter-persistent reload
}
case "$1" in
install)
clear && clear
echo -e -n "${asari}Şifre:${mavi}"
read sifre
if [ "$sifre" = "teamspeak3123" ]; then
tea_kur
else
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦               ${akirmizi}Yanlış şifre                 ${turkuaz}¦"
echo -e "¦         ${asari}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
fi
;;
menu)
clear && clear
echo -e -n "${asari}Şifre:${mavi}"
read sifre
if [ "$sifre" = "teamspeak3123" ]; then
main
else
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦               ${akirmizi}Yanlış şifre                 ${turkuaz}¦"
echo -e "¦         ${asari}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
fi
;;
anti_on)
clear && clear
echo -e -n "${asari}Şifre:${mavi}"
read sifre
if [ "$sifre" = "teamspeak3123" ]; then
aktif_et
else
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦               ${akirmizi}Yanlış şifre                 ${turkuaz}¦"
echo -e "¦         ${asari}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
fi
;;
anti_off)
clear && clear
echo -e -n "${asari}Şifre:${mavi}"
read sifre
if [ "$sifre" = "teamspeak3123" ]; then
deaktif_et
else
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦               ${akirmizi}Yanlış şifre                 ${turkuaz}¦"
echo -e "¦         ${asari}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
fi
;;
anti_reinstall)
clear && clear
echo -e -n "${asari}Şifre:${mavi}"
read sifre
if [ "$sifre" = "teamspeak3123" ]; then
aktif_deaktif
else
clear && clear
echo -e "${turkuaz}+--------------------------------------------+"
echo -e "¦                                            ¦"
echo -e "¦               ${akirmizi}Yanlış şifre                 ${turkuaz}¦"
echo -e "¦         ${asari}Çıkış yapıldı, iyi günler.         ${turkuaz}¦"
echo -e "¦                                            ¦"
echo -e "+--------------------------------------------+${kapat}"
fi
;;
    *)
    clear && clear
    echo -e "${kirmizi}izinsiz giriş işlemi yapıldi.${kapat}"
    exit
esac