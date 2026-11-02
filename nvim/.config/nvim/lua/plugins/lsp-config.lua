local servers = {
  "ts_ls",
  "lua_ls",
  "pyright",
  "clangd",
  "eslint",
  "html",
  "cssls",
  "bashls",
  "haskell-language-server",
}

local function clangd_executable()
  local clangd = vim.fn.exepath("clangd")
  if clangd == "" then
    clangd = "clangd"
  end
  return clangd
end

-- Nix's clangd wrapper adds the host libstdc++ paths unless --query-driver is
-- set. That flag is only needed so clangd will run the Xtensa cross-compiler.
local function clangd_cmd(dispatchers, config)
  local cmd = {
    clangd_executable(),
    "--background-index",
  }

  local root = config and config.root_dir
  if type(root) == "string" and vim.uv.fs_stat(vim.fs.joinpath(root, "sdkconfig")) then
    table.insert(cmd, "--query-driver=**/xtensa-*-elf-gcc,**/xtensa-*-elf-g++")
  end

  return vim.lsp.rpc.start(cmd, dispatchers, {
    cwd = config.cmd_cwd,
    env = config.cmd_env,
    detached = config.detached,
  })
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion", ev.buf) then
          vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
      end,
    })

    vim.lsp.config("clangd", {
      cmd = clangd_cmd,
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_markers = {
        "build/compile_commands.json",
        ".clangd",
        "sdkconfig",
        "CMakeLists.txt",
      },
    })

    for _, server in ipairs(servers) do
      if server ~= "clangd" then
        vim.lsp.config(server, {})
      end
      vim.lsp.enable(server)
    end
  end,
}
