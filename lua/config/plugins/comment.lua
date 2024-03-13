return {
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
