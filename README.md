# Mise en oeuvre d'un moniteur système

# 1 - Installation
## 1.1 Sans script lua
```sh
sudo pacman -S conky
```
Copier le fichier conkyrc_base qui est le mode standard et qui n'utilise pas de script lua.
```sh
cp ~/Documents/Scripts/conky/conkyrc_base ~/.conkyrc
```
Mettre à jour l'interface réseau et le nom de la batterie.

## 1.2 Avec script lua
Installer le package avec lua intégré.
```sh
sudo pacman -S cairo
cd Admin
git clone https://aur.archlinux.org/conky-lua.git 
cd conky-lua
makepkg -si
```
Aller dans le répertoire conky et modifier les paramètres de configuration (répertoire, interface réseau, batterie) dans genConkyrc.   
Générer les fichiers .conkyrc et clock_rings.lua
```sh
python genConkyrc.py
```

# 2 - Fonctionnement
Executer en mode détaché
```sh
conky -d
```

