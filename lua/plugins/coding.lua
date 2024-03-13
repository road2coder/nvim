local surround = require("config.plugins.mini.surround")
local comment = require("config.plugins.comment")

return {
  -- surround 操作
  {
    "echasnovski/mini.surround",
    keys = surround.keys,
    opts = surround.opts,
  },
  -- 注释
  {
    "numToStr/Comment.nvim",
    vscode = true,
    dependencies = {
      -- 不同位置不同注释（如 vue）
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
        },
      },
    },
    event = "VeryLazy",
    keys = comment.keys,
    config = comment.config,
  }
}
