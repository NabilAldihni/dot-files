return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = {
    { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason package manager" },
  },
  opts = {
    -- Nix provides core LSP servers; Mason is for optional extras only.
    PATH = "append",
  },
}
