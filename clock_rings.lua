-- Scipt lua d'affichage des différents cercles
-- Attention début de la zone générée automatiquement par genConkyrc.py. Ne pas la modifier. 
interface = "wlp3s0"
ring_r = 48
border_inner_margin = 60
offset_load = 30
color = 0xffffff
color1 = 0xff6600
-- Fin de la zone 

offset = border_inner_margin -- Offset pour les bordures x et y
loadavg_r = offset-offset_load

settings_table = {   
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+1.5*ring_r, y=offset+1.5*ring_r,
        radius=ring_r,
        thickness=5,
        start_angle=-90,
        end_angle=180
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+4.5*ring_r, y=offset+1.5*ring_r,
        radius=ring_r,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+4.5*ring_r, y=offset+1.5*ring_r,
        radius=ring_r-5,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='loadavg',
        arg='1',
        max=4, -- Nombre de process dans la file d'attente
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+3*ring_r, y=offset+3*ring_r,
        radius=loadavg_r+3*ring_r,
        thickness=5,
        start_angle=-90,
        end_angle=245
    },
    {
        name='downspeedf',
        arg=interface,
        max=3000, -- 3 Mbyte/s
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+1.5*ring_r, y=offset+4.5*ring_r,
        radius=ring_r,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='upspeedf',
        arg=interface,
        max=3000, -- 3 Mbyte/s
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+1.5*ring_r, y=offset+4.5*ring_r,
        radius=ring_r-5,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/home',
        max=100,
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+4.5*ring_r, y=offset+4.5*ring_r,
        radius=ring_r,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+4.5*ring_r, y=offset+4.5*ring_r,
        radius=ring_r-5,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='diskio',
        arg='',
        max=8000000, -- 8 Mbyte/s
        bg_colour=color,
        bg_alpha=0.2,
        fg_colour=color1,
        fg_alpha=0.8,
        x=offset+4.5*ring_r, y=offset+4.5*ring_r,
        radius=ring_r-10,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
}

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    
    -- Draw indicator ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)        
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
        str=string.gsub(str, "B", "")
        str=string.gsub(str, "i", "")        
        if (string.find(str, "K") == nil) then else str=string.gsub(str, "K", "")*1000 end
        if (string.find(str, "M") == nil) then else str=string.gsub(str, "M", "")*1000000 end
        value=tonumber(str)
        pct=value/pt['max']
        draw_ring(cr,pct,pt)
    end
    
    -- Check that Conky has been running for at least x sec
    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    local cr=cairo_create(cs)    
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)
    if update_num> 3 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
    end
end
