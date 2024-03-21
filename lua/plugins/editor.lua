local tree = require("config.plugins.neo-tree")
local teles = require("config.plugins.telescope")
local gitsigns = require("config.plugins.gitsigns")
return {
  -- 文件树
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = tree.keys,
    deactivate = tree.deactivate,
    init = tree.init,
    opts = tree.opts,
    config = tree.config,
  },
  -- 跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    config = true,
    keys = require("config.plugins.flash").keys,
  },
  -- 搜索等
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    lazy = false,
    dependencies = teles.dependencies,
    opts = teles.opts,
    keys = teles.keys,
  },
  -- 折叠功能
  {
    "kevinhwang91/nvim-ufo",
    event = { "VeryLazy" },
    dependencies = { "kevinhwang91/promise-async" },
    config = require("config.plugins.nvim-ufo").config,
  },
  -- 删除 buffer
  {
    "echasnovski/mini.bufremove",
    keys = require("config.plugins.mini").bufremove.keys,
  },
  -- 快揵键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = require("config.plugins.which-key").config,
  },
  -- git 提示
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = gitsigns.opts,
  },
}
