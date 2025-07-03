return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }

      -- Custom browser open function (Lua version of Vimscript function)
      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

      -- Define Vimscript function in Lua-compatible way
      vim.cmd([[
        function! OpenMarkdownPreview(url)
          execute "silent !firefox --new-window " . a:url
        endfunction
      ]])
    end,
  },
}
