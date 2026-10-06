-- Home screen layout
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

-- Default layout for any unconfigured monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

-- Mapping workspaces to screens
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
