local mod = "SUPER"

-- Main keybindings
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + D", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + F1", hl.dsp.exec_cmd("zen"))
hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" -t png - | wl-copy -t image/png]]))
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd([[
hyprctl reload
pkill -x waybar
pkill -x .waybar-wrapped
pkill -x hyprpaper
i=0
while pgrep -x waybar >/dev/null || pgrep -x .waybar-wrapped >/dev/null; do
    i=$((i + 1))
    [ "$i" -ge 20 ] && break
    sleep 0.05
done
hyprctl eval 'hl.exec_cmd("waybar")'
hyprctl eval 'hl.exec_cmd("hyprpaper")'
]]))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))

-- Workspace keybindings
for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- VIM Workspace keybindings
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Multimedia keybindings
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("toggle-mic"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Resize window keybindings
hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
    hl.bind(mod .. " + R", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)
