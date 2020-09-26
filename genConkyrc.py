#!/usr/bin/python
# -*- coding: utf-8 -*-

# Version 26 septembre 2020

import pdb, os, math

# Configuration
racine1 = "/home/papa/"
racine2 = racine1 + "Documents/Scripts/conky/"
interface = "wlp3s0" # Interface réseau
ring_r = 2*24 # Rayon du cercle de base
border_inner_margin = 60
offset_load = 30 # Majoration du rayon du cercle loadavg
font = 8 # Taille des caractres
line_hight = font+6 # Hauteur de ligne
minimum_width = 300 # Taille de la fenêtre
color = "0xffffff" # Couleur du texte 
color1 = "0xff6600" # Couleur des anneaux
batterie = "BAT1"
offset = border_inner_margin # Offset pour les bordures x et y
loadavg_r = offset-offset_load 

# Mise à jour du fichier lua
f1 = f1 = open(racine2 + "clock_rings.lua","r")
lignes  = f1.readlines()
f1.close()
lignes[2] = "interface = " + interface + "\n" 
lignes[3] = "ring_r = " + str(ring_r) + "\n" 
lignes[4] = "border_inner_margin = " + str(border_inner_margin) + "\n"
lignes[5] = "offset_load = " + str(offset_load) + "\n"  
lignes[6] = "color = " + color + "\n"
lignes[7] = "color1 = " + color1 + "\n"
f1 = f1 = open(racine2 + "clock_rings.lua","w")
f1.writelines(lignes)
f1.close()

# Positionnement des différentes variables
cpug = "${goto " + str(math.floor(offset+0.5*ring_r)) + "}"
cpua = "${voffset " + str(math.floor(1.5*ring_r)) + "}"
cpub = "${voffset " + str(math.floor(-(1.5*ring_r+2*line_hight))) + "}"
netg = "${goto " + str(math.floor(offset+0.5*ring_r)) + "}"
neta = "${voffset " + str(math.floor(4.5*ring_r)) + "}"
netb = "${voffset " + str(math.floor(-(4.5*ring_r+3*line_hight))) + "}"
memg = "${goto " + str(math.floor(offset+3.5*ring_r)) + "}"
mema = "${voffset " + str(math.floor(1.5*ring_r)) + "}"
memb = "${voffset " + str(math.floor(-(1.5*ring_r+3*line_hight))) + "}"
disg = "${goto " + str(math.floor(offset+3.5*ring_r)) + "}"
disa = "${voffset " + str(math.floor(4.5*ring_r)) + "}"
disb = "${voffset " + str(math.floor(-(4.5*ring_r+4*line_hight))) + "}"
loag = "${goto " + str(math.floor(offset_load)) + "}"
loaa = "${voffset " + str(math.floor(3*ring_r)) + "}"
loab = "${voffset " + str(math.floor(-(3*ring_r+2*line_hight))) + "}"
batg = "${goto " + str(math.floor(offset+2*ring_r)) + "}"
bata = "${voffset " + str(math.floor(2.5*ring_r)) + "}"
batb = "${voffset " + str(math.floor(-(2.5*ring_r+4*line_hight))) + "}"
paga = "${voffset " + str(math.floor(6.5*ring_r)) + "}"

config = "\
conky.config = {\n\
\n\
	-- Window settings\n\
	own_window = true,\n\n\
	own_window_type = \'normal\',\n\
	own_window_transparent = false,\n\
	own_window_hints = \'decorated,below,sticky,skip_taskbar,skip_pager\',\n\
	own_window_argb_visual = true,\n\
	own_window_argb_value = 180,\n\
	own_window_colour = \'000000\',\n\
	border_inner_margin = "+str(border_inner_margin)+",\n\
	minimum_width = "+str(minimum_width)+",\n\
	alignment = \'middle_right\',\n\
	gap_x = 50,\n\
	gap_y = 60,\n\
	draw_shades = false,\n\
	draw_outline = false,\n\
	draw_borders = false,\n\
	draw_graph_borders = false,\n\
\n\
	-- Buffer settings\n\
	update_interval = 1,\n\
	cpu_avg_samples = 2,\n\
	net_avg_samples = 2,\n\
	double_buffer = true,\n\
	no_buffers = true,\n\
	text_buffer_size = 2048,\n\
\n\
	-- Text settings\n\
	override_utf8_locale = true,\n\
	use_xft = true,\n\
	font = \'Sans:size="+str(font)+"\',\n\
	uppercase = false,\n\
	default_color = \'"+color.replace("0x", "")+"\',\n\
	color1 = \'"+color1.replace("0x", "")+"\',\n\
\n\
	-- Lua Load\n\
	lua_load = \'"+racine2+"clock_rings.lua\',\n\
	lua_draw_hook_pre = \'clock_rings\',\n\
}\
"

text = "\n\
conky.text = [[\n\
${color1}"+cpug+cpua+"CPU : ${color}${cpu cpu0}%"+cpub+"\n\
\n\
${color1}"+netg+neta+"Down : ${color}${downspeed "+interface+"}/s\n\
${color1}"+netg+"Up :   ${color}${upspeed "+interface+"}/s"+netb+"\n\
\n\
${color1}"+memg+mema+"Mem :  ${color}${memperc}%\n\
${color1}"+memg+"Swap : ${color}${swapperc}%"+memb+"\n\
\n\
${color1}"+disg+disa+"/home : ${color}${fs_used_perc /home}%\n\
${color1}"+disg+"/ :     ${color}${fs_used_perc /}%\n\
${color1}"+disg+"I/O :   ${color}${diskio}/s"+disb+"\n\
\n\
${color1}"+loag+loaa+"Load : ${color}${loadavg 1}"+loab+"\n\
\n\
${color }"+batg+bata+"${time %H:%M:%S}\n\
${color }"+batg+"${time %d %B %Y}\n\
${color1}"+batg+"${battery_bar 10,160 "+batterie+"}"+batb+"\n\
\n\
"+paga+"\n\
${color1}Global${color}\n\
Name${goto 200}${nodename}\n\
Kernel${goto 200}${kernel}\n\
IP${goto 200}${addr "+interface+"}\n\
Uptime${goto 200}${uptime_short}\n\
\n\
${color1}Top processes${goto 200}%cpu${goto 300}%mem${color}\n\
${top name 1}${goto 190}${top cpu 1}${goto 290}${top mem 1}\n\
${top name 2}${goto 190}${top cpu 2}${goto 290}${top mem 2}\n\
${top name 3}${goto 190}${top cpu 3}${goto 290}${top mem 3}\n\
]]\n\
"

#Génération du fichier .conkyrc
f1 = open(racine1 + ".conkyrc","wb")
f1.write((config + "\n\n" + text).encode("utf-8"))
f1.close()



