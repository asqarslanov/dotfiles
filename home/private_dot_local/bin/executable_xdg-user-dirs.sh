#/usr/bin/env sh

xdg-user-dirs-update --set DESKTOP /data/Desktop
xdg-user-dirs-update --set DOWNLOAD /data/Downloads
xdg-user-dirs-update --set TEMPLATES /data/Templates
xdg-user-dirs-update --set PUBLICSHARE /data/Public
xdg-user-dirs-update --set DOCUMENTS /data/Documents
xdg-user-dirs-update --set MUSIC /data/Music
xdg-user-dirs-update --set PICTURES /data/Pictures
xdg-user-dirs-update --set VIDEOS /data/Videos

ln -s /data/Desktop ~/Desktop
ln -s /data/Downloads ~/Downloads
ln -s /data/Templates ~/Templates
ln -s /data/Public ~/Public
ln -s /data/Documents ~/Documents
ln -s /data/Music ~/Music
ln -s /data/Pictures ~/Pictures
ln -s /data/Videos ~/Videos
