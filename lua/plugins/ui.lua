local catppuccin = require("config.plugins.catppuccin")
local bufferline = require("config.plugins.bufferline")
local indentscope = require("config.plugins.mini").indentscope
local lualine = require("config.plugins.lualine")
local noice = require("config.plugins.noice")
local barbecue = require("config.plugins.barbecue")
local scheme_enabled = require("utils.ui").colorscheme_enabled

return {
  -- 很多 ui 相关插件的插件的依赖
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = require("config.plugins.nvim-web-devicons").opts,
  },
  -- 全局主题
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
  -- 首页
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = require("config.plugins.dashboard-nvim").opts,
  },

  -- 顶部 buffer
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = bufferline.keys,
    opts = bufferline.opts,
    config = bufferline.config,
  },
  -- 底部工具栏
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = lualine.init,
    opts = lualine.opts,
  },
  -- 缩进线
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VeryLazy",
    init = indentscope.init,
    config = indentscope.config,
  },
  -- 更人性化的通知
  {
    "folke/noice.nvim",
    -- event = "VeryLazy",
    lazy = false,
    dependencies = noice.dependencies,
    opts = noice.opts,
    keys = noice.keys,
  },
  -- 顶部 symbols，需要 lsp 支持
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    dependencies = "SmiteshP/nvim-navic",
    opts = barbecue.opts,
    config = barbecue.config,
  },
}
