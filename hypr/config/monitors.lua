local laptop = "desc:Sharp Corporation 0x1548"
local laptop_desc = "Sharp Corporation 0x1548"

-- Home screen layout. External positions assume the laptop is at 1.2x.
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

-- Default layout for any unconfigured monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- 1.2x when connected to monitors ; 1x when it is the only output.
local applied_scale

local function external_connected(ignoring_id)
    for _, mon in ipairs(hl.get_monitors()) do
        if mon.id ~= ignoring_id and mon.description ~= laptop_desc then
            return true
        end
    end
    return false
end

local function apply_laptop_scale(ignoring_id)
    local scale = external_connected(ignoring_id) and 1.2 or 1
    if applied_scale == scale then
        return
    end
    applied_scale = scale

    hl.monitor({
        output = laptop,
        mode = "preferred",
        position = "0x0",
        scale = scale,
    })
end

apply_laptop_scale()
hl.on("monitor.added", function()
    apply_laptop_scale()
end)
hl.on("monitor.removed", function(mon)
    -- The removed output can still be in the list when this runs.
    apply_laptop_scale(mon and mon.id)
end)

-- Mapping workspaces to screens
local function workspace_on(id, output)
    hl.workspace_rule({
        workspace = tostring(id),
        monitor = output,
        persistent = true,
        default = true,
    })
end

workspace_on(1, laptop)
workspace_on(2, "desc:ASUSTek COMPUTER INC VY249 N3LMRS028336")
workspace_on(3, "desc:Microstep MSI MP241X BA9H173200856")
workspace_on(4, laptop)
workspace_on(5, "desc:ASUSTek COMPUTER INC VY249 N3LMRS028336")
workspace_on(6, "desc:Microstep MSI MP241X BA9H173200856")
