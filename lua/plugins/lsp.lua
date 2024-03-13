local lsp = require("config.plugins.nvim-lspconfig")
local mason = require("config.plugins.mason")
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
}
