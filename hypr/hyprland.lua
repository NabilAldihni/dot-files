-- https://wiki.hypr.land/Configuring/Start/

-- Standard desktop pointer (Adwaita), instead of Hyprland's built-in cursor.
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")

require("config.autostart")
require("config.settings")
require("config.monitors")
require("config.binds")
