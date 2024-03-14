local lsp = require("config.plugins.nvim-lspconfig")
local mason = require("config.plugins.mason")
local mason_null = require("config.plugins.mason-null-ls")
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = mason.cmd,
    opts = mason.opts,
    config = mason.config,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = lsp.dependencies,
    opts = lsp.opts,
    config = lsp.config,
    keys = lsp.keys,
  },
  -- 以 null-ls 作为媒介，增强 lsp 功能，如使用 prettier 作为格式化等
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = mason_null.dependencies,
    opts = mason_null.opts,
    config = mason_null.config,
  },
}
