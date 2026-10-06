return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")

        require("luasnip.loaders.from_vscode").lazy_load()

        local function insert_plain_snippet(body)
            if body:find("%$") and body:match("%(") and body:match("%$[%{0-9]") then
                local name = body:match("^([%w_%.:]+)%(")
                if name then
                    body = name .. "()"
                end
            else
                body = body:gsub("%$%{%d+:?([^}]*)%}", "%1"):gsub("%$%d+", "")
            end
            vim.api.nvim_put(vim.split(body, "\n", { plain = true }), "c", true, true)
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    insert_plain_snippet(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                }),
                documentation = cmp.config.window.bordered({
                    border = 'rounded',
                    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                    max_height = 20,
                    max_width = 80,
                }),
            },
            view = {
                docs = {
                    auto_open = true,
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ select = false })
                    else
                        fallback()
                    end
                end),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })
        
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })
        
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            }),
        })
    end,
}

