local surround = require("config.plugins.mini").surround
local comment = require("config.plugins.comment")
local cmp = require("config.plugins.nvim-cmp")

return {
  -- surround 操作
  {
    "echasnovski/mini.surround",
    -- event = "VryLazy",
    lazy = false,
    keys = surround.keys,
    opts = surround.opts,
  },
  -- 注释
  {
    "numToStr/Comment.nvim",
    vscode = true,
    event = "VeryLazy",
    dependencies = comment.dependencies,
    keys = comment.keys,
    config = comment.config,
  },
  -- 自动括号
  {

    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    keys = require("config.plugins.mini").pairs.keys,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    opts = cmp.opts,
    dependencies = cmp.dependencies,
    config = cmp.config,
  },
}
