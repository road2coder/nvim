local surround = require("config.plugins.mini.surround")

return {
  -- surround 操作
  {
    "echasnovski/mini.surround",
    keys = surround.keys,
    opts = surround.opts,
  },
  -- 不同位置不同注释（如 vue）
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  -- 注释
  {
    "numToStr/Comment.nvim",
    vscode = true,
    event = "VeryLazy",
    keys = {
      {
        "\\c",
        function()
          local fn = require("Comment.api").locked("insert.linewise.eol")
          fn("line")
        end,
        desc = "Comment insert end of line",
      },
    },
    config = function()
      local ts_comment = require('ts_context_commentstring.integrations.comment_nvim')
      require("Comment").setup({
        pre_hook = ts_comment.create_pre_hook(),
      })
    end
  }
}
