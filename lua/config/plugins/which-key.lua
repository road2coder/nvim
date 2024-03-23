return {
  event = "VeryLazy",
  config = function(_, opts)
    local mappings = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>b"] = { name = "+buffer" },
      ["\\"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>q"] = { name = "+quit/session" },
      -- ["<leader>g"] = { name = "+git" },
      -- ["<leader>gh"] = { name = "+hunks" },
      -- ["<leader>u"] = { name = "+ui" },
      -- ["<leader>w"] = { name = "+windows" },
      -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
    }
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(mappings)
  end,
}
