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

Copier conkyrc_base dans le home
```sh
cp /home/papa/Documents/Scripts/conky/conkyrc_base /home/papa/.conkyrc
```
Fichiers .conkyrc disponibles :
* conkyrc_base est le mode standard qui n'utilise pas de script lua.
* conkyrc_lua appelle des scripts lua qui dessinent les anneaux et calculent dynamiquement les positionnements. Ce conky est à utiliser pour définir la taille et le positionnement des anneaux. Lorsque les paramètres sont définis il faut générer les valeurs avec calcul.lua et les reporter dans conky_luac.
* conkyrc_luac appelle des scripts lua qui dessinent les anneaux.

Dans le fichier .conkyrc positionner la bonne interface réseau (eth0 ou wlan0) ainsi que la bonne batterie, idem pour le fichier clock_rings.lua.   

# 2 - Fonctionnement
Executer en mode détaché
```sh
conky -d
```

