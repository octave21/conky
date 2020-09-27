# Mise en oeuvre d'un moniteur système

![conky](/conky.png)

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
Modifier dans genConkyrc.py les paramètres de configuration (racine, interface réseau, batterie, hauteur de ligne) qui correspondent à votre installation.   
Générer les fichiers .conkyrc et clock_rings.lua
```sh
python genConkyrc.py
```

# 2 - Fonctionnement
Executer en mode détaché
```sh
conky -d
```

# 3 - Paramétrage
Certains paramètres peuvent être modifiés :
* Ne pas décorer la fenêtre : "own_window_hints" valorisé à undecorated.
* Transparence de la fenêtre : "own_window_argb_value" valorisé entre 0 et 255.
* Position de la fenêtre : "alignment" valorisé avec une combinaison de 
top, middle, bottom, left, right.
