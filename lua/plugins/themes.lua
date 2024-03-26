if vim.g.vscode then
  return {}
end

local catppuccin = require("config.plugins.catppuccin")
local scheme_enabled = require("utils.ui").colorscheme_enabled

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = scheme_enabled("catppuccin"),
    opts = catppuccin.opts,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = scheme_enabled("tokyonight"),
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    enabled = scheme_enabled("onedark"),
  },
}
