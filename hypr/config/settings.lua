hl.config({
    general = {
        gaps_out = 5,
        gaps_in = 3,
    },
    animations = {
        enabled = false,
    },
    input = {
        -- Remap capslock to ctrl
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
