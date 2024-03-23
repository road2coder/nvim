return {
  vscode = true,
  event = "VeryLazy",
  dependencies = {
    -- 不同位置不同注释（如 vue）
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
  },
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
    local opts = {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
    require("Comment").setup(opts)
  end,
}
