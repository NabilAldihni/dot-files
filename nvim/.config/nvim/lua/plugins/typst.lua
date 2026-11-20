local function project_root(file)
  if vim.env.TYPST_ROOT and vim.env.TYPST_ROOT ~= "" then
    return vim.fn.fnamemodify(vim.env.TYPST_ROOT, ":p"):gsub("/$", "")
  end
  local found = vim.fs.find({ ".git" }, {
    path = vim.fs.dirname(file),
    upward = true,
  })
  if #found > 0 then
    return vim.fs.dirname(found[1])
  end
  return vim.fs.dirname(file)
end

-- A main.typ owns the other files in its folder. A main.typ at the
-- project root does not steal sibling documents such as template.typ.
local function main_file(path)
  path = vim.fn.fnamemodify(path, ":p")
  local dir = vim.fs.dirname(path)
  local root = project_root(path)
  local found = vim.fs.find("main.typ", {
    path = dir,
    upward = true,
    stop = root,
  })
  if #found == 0 then
    return path
  end
  local main = vim.fn.fnamemodify(found[1], ":p")
  local main_dir = vim.fs.dirname(main)
  if main_dir == root and dir == root and path ~= main then
    return path
  end
  return main
end

local function export(format, on_success)
  local src = vim.api.nvim_buf_get_name(0)
  if src == "" or not src:match("%.typ$") then
    vim.notify("Open a Typst file first", vim.log.levels.WARN)
    return
  end

  local main = main_file(src)
  local out
  if format == "png" or format == "svg" then
    out = main:gsub("%.typ$", "-{p}." .. format)
  else
    out = main:gsub("%.typ$", "." .. format)
  end

  local cmd = {
    "typst",
    "compile",
    "--root",
    project_root(main),
    main,
    out,
  }
  if format == "html" or format == "bundle" then
    table.insert(cmd, 3, "--features=html")
  end
  if vim.env.TYPST_PACKAGE_PATH and vim.env.TYPST_PACKAGE_PATH ~= "" then
    table.insert(cmd, 3, "--package-path=" .. vim.env.TYPST_PACKAGE_PATH)
  end

  vim.system(cmd, {}, function(result)
    vim.schedule(function()
      if result.code == 0 then
        vim.notify("Exported " .. out)
        if on_success then
          on_success(out)
        end
      else
        vim.notify(result.stderr ~= "" and result.stderr or "typst compile failed", vim.log.levels.ERROR)
      end
    end)
  end)
end

local function open_pdf()
  export("pdf", function(out)
    local opener = vim.fn.executable("zathura") == 1 and "zathura" or "xdg-open"
    vim.system({ opener, out }, { detach = true })
  end)
end

local function tinymist_cmd(title, command, arguments)
  local client = vim.lsp.get_clients({ name = "tinymist", bufnr = 0 })[1]
  if not client then
    vim.notify("tinymist is not attached", vim.log.levels.WARN)
    return
  end
  client:exec_cmd({
    title = title,
    command = command,
    arguments = arguments,
  }, { bufnr = 0 })
end

return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    follow_cursor = true,
    invert_colors = "never",
    dependencies_bin = {
      tinymist = "tinymist",
      websocat = "websocat",
    },
    -- The plugin already passes --root from TYPST_ROOT. A second --root
    -- makes tinymist exit immediately. TYPST_PACKAGE_PATH is inherited.
    get_main_file = function(path)
      return main_file(path)
    end,
  },
  keys = {
    { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Typst live preview", ft = "typst" },
    { "<leader>te", function() export("pdf") end, desc = "Export Typst PDF", ft = "typst" },
    { "<leader>to", open_pdf, desc = "Open Typst PDF", ft = "typst" },
    { "<leader>th", function() export("html") end, desc = "Export Typst HTML", ft = "typst" },
    { "<leader>tn", function() export("png") end, desc = "Export Typst PNG", ft = "typst" },
    {
      "<leader>tm",
      function()
        tinymist_cmd("pin", "tinymist.pinMain", { vim.api.nvim_buf_get_name(0) })
      end,
      desc = "Pin Typst main file",
      ft = "typst",
    },
    {
      "<leader>tu",
      function()
        tinymist_cmd("unpin", "tinymist.pinMain", { vim.v.null })
      end,
      desc = "Unpin Typst main file",
      ft = "typst",
    },
  },
  config = function(_, opts)
    require("typst-preview").setup(opts)
    vim.api.nvim_create_user_command("TypstExport", function(command)
      export(command.args ~= "" and command.args or "pdf")
    end, {
      nargs = "?",
      complete = function()
        return { "pdf", "html", "png", "svg" }
      end,
    })
  end,
}
