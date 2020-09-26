# Mise en oeuvre d'un moniteur système

# 1 - Installation
## 1.1 Sans script lua
```sh
sudo pacman -S conky
```
Copier le fichier conkyrc_base qui est le mode standard et qui n'utilise pas de script lua.
```sh
cp /home/papa/Documents/Scripts/conky/conkyrc_base /home/papa/.conkyrc
```

## 1.2 Avec script lua
```sh
sudo pacman -S cairo
cd Admin
git clone https://aur.archlinux.org/conky-lua.git 
cd conky-lua
makepkg -si
```
Aller dans le répertoire conky et générer les fichiers .conkyrc et clock_rings.lua
```sh
python genConkyrc.py
```

# 2 - Fonctionnement
Executer en mode détaché
```sh
conky -d
```

