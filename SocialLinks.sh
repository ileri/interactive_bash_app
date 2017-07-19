#!/bin/sh

pencere_boyut() {
  PENCERE_BOY=17
  PENCERE_EN=$(tput cols)

  if [ -z "$PENCERE_EN" ] || [ "$PENCERE_EN" -lt 60 ]; then
    PENCERE_EN=80
  fi
  if [ "$PENCERE_EN" -gt 178 ]; then
    PENCERE_EN=120
  fi
  PENCERE_MENU_BOY=$(($PENCERE_BOY-8))
}

tarayicida_ac() {
  xdg-open ${1};
  whiptail --msgbox "\
  ${1}\
   adresi tarayıcınızda açılıyor...\
  " 20 70 1
}

INTERACTIVE=True
ASK_TO_REBOOT=0
pencere_boyut
BASLIK="Serhat Celil İLERİ"
ALT_BASLIK="Sosyal Bağlantılar"
CIKIS="Çıkış"
SEC="Seç"
while true; do
  FUN=$(whiptail --title "$BASLIK" --menu "$ALT_BASLIK" $PENCERE_BOY $PENCERE_EN $PENCERE_MENU_BOY --cancel-button $CIKIS --ok-button $SEC \
    "1 Kişisel Blog" "serhatcileri.com" \
    "2 Facebook Hesabı" "facebook.com/serhatcileri" \
    "3 Twitter Hesabı" "twitter.com/serhatcileri" \
    "4 GitHub Hesabı" "github.com/ileri" \
    "5 LinkedIn Hesabı" "linkedin.com/in/serhatcileri" \
    "6 Instagram" "instagram.com/serhatcileri" \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    exit 0
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      1\ *) tarayicida_ac "http://serhatcileri.com" ;;
      2\ *) tarayicida_ac "http://facebook.com/serhatcileri" ;;
      3\ *) tarayicida_ac "http://twitter.com/serhatcileri" ;;
      4\ *) tarayicida_ac "http://github.com/ileri" ;;
      5\ *) tarayicida_ac "http://linkedin.com/in/serhatcileri" ;;
      6\ *) tarayicida_ac "http://instagram.com/serhatcileri" ;;
      *) whiptail --msgbox "Beklenmedik bir seçenek seçildi!" 20 60 1 ;;
    esac || whiptail --msgbox "$FUN özelliği çalıştırılırken bir sorun oluştu!" 20 60 1
  else
    exit 1
  fi
done
