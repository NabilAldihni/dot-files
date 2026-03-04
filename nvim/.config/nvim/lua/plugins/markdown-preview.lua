return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      
      -- Auto-close preview when leaving markdown buffer
      vim.g.mkdp_auto_close = 1
      
      -- Refresh preview on save and when leaving insert mode
      vim.g.mkdp_refresh_slow = 0
      
      -- Enable sync scrolling (browser scrolls with cursor position)
      vim.g.mkdp_preview_options = {
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
      }
      
      -- Use system default browser instead of forcing Firefox
      vim.g.mkdp_browser = ''
      
      -- Theme: 'dark' or 'light'
      vim.g.mkdp_theme = 'dark'
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Toggle Markdown Preview",
        ft = "markdown",
      },
      {
        "<leader>ms",
        "<cmd>MarkdownPreview<cr>",
        desc = "Start Markdown Preview",
        ft = "markdown",
      },
    },
  },
}
