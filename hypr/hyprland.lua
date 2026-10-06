-- Hyprland config. The compositor loads this instead of hyprland.conf.
-- https://wiki.hypr.land/Configuring/Start/

local mod = "SUPER"

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("sh -c '[ -f ~/.cache/wal/colors-waybar.css ] || wal --theme base16-default-dark -n; waybar'")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
end)

hl.config({
    general = {
        gaps_out = 5,
        gaps_in = 3,
    },
    animations = {
        enabled = false,
    },
    input = {
        kb_options = "ctrl:nocaps",
        follow_mouse = 2,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.5,
            disable_while_typing = false,
        },
    },
    misc = {
        disable_hyprland_logo = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

hl.monitor({
    output = "desc:Sharp Corporation 0x1548",
    mode = "preferred",
    position = "0x0",
    scale = 1.2,
})
hl.monitor({
    output = "desc:ASUSTek COMPUTER INC VY249 N3LMRS028336",
    mode = "preferred",
    position = "1600x-200",
    scale = 1,
})
hl.monitor({
    output = "desc:Microstep MSI MP241X BA9H173200856",
    mode = "preferred",
    position = "3520x150",
    scale = 1,
})
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

local function workspace_on(id, output)
    hl.workspace_rule({
        workspace = tostring(id),
        monitor = output,
        persistent = true,
        default = true,
    })
end

workspace_on(1, "desc:Sharp Corporation 0x1548")
workspace_on(2, "desc:ASUSTek COMPUTER INC VY249 N3LMRS028336")
workspace_on(3, "desc:Microstep MSI MP241X BA9H173200856")
workspace_on(4, "desc:Sharp Corporation 0x1548")
workspace_on(5, "desc:ASUSTek COMPUTER INC VY249 N3LMRS028336")
workspace_on(6, "desc:Microstep MSI MP241X BA9H173200856")

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + D", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + F1", hl.dsp.exec_cmd("zen"))
hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" -t png - | wl-copy -t image/png]]))
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload && pkill waybar && hyprctl dispatch exec waybar && pkill hyprpaper && hyprctl dispatch exec hyprpaper"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))

for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("toggle-mic"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
    hl.bind(mod .. " + R", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)
