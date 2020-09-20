# Mise en oeuvre d'un moniteur système

# 1 - Installation
Si conky doit appeler des scripts lua, il faut installer conky via AUR
```sh
sudo pacman -S cairo
cd Admin
git clone https://aur.archlinux.org/conky-lua.git 
cd conky-lua
makepkg -si
```
Sinon :
```sh
sudo pacman -S cairo conky
```

Copier conkyrc dans le home
```sh
cp /home/papa/Documents/Scripts/conky/conkyrc /home/papa/.conkyrc
```
Dans le fichier .conkyrc positionner la bonne interface réseau (eth0 ou wlan0)
Dans Applications au démarrage la commande de lancement est sh -c "sleep 20 ; conky"
