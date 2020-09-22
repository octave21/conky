-- Affichage des différents cercles, calcul des positionnements des textes

ring_r = 60 -- Rayon du cercle de base
border_inner_margin = 40
offset = border_inner_margin -- Offset pour les bordures x et y
offset_load = 10 -- Majoration du rayon du cercle loadavg
loadavg_r = offset-offset_load 
line_hight = 10+7 -- Hauteur de ligne

-- CPU
print("CPU - ${goto " .. (offset+0.5*ring_r) .. "}")
print("CPU - ${voffset " .. (1.5*ring_r) .. "}")
print("CPU - ${voffset " .. -(1.5*ring_r+2*line_hight) .. "}")
-- Réseau
print("NET - ${goto " .. (offset+0.5*ring_r) .. "}")
print("NET - ${voffset " .. (4.5*ring_r) .. "}")
print("NET - ${voffset " .. -(4.5*ring_r+3*line_hight) .. "}")
-- Mémoire
print("MEM - ${goto " .. (offset+3.5*ring_r) .. "}")
print("MEM - ${voffset " .. (1.5*ring_r) .. "}")
print("MEM - ${voffset " .. -(1.5*ring_r+3*line_hight) .. "}")
-- Disque
print("DISK - ${goto " .. (offset+3.5*ring_r) .. "}")
print("DISK - ${voffset " .. (4.5*ring_r) .. "}")
print("DISK - ${voffset " .. -(4.5*ring_r+4*line_hight) .. "}")
-- Charge globale
print("LOAD - ${goto " .. (offset_load) .. "}")
print("LOAD - ${voffset " .. (3*ring_r) .. "}")
print("LOAD - ${voffset " .. -(3*ring_r+2*line_hight) .. "}")
-- Date et batterie
print("BAT - ${goto " .. (offset+2*ring_r) .. "}")
print("BAT - ${voffset " .. (2.5*ring_r) .. "}")
print("BAT - ${voffset " .. -(2.5*ring_r+4*line_hight) .. "}")
-- Liste bas de page
print("Bas de page - ${voffset " .. (6*ring_r) .. "}")

