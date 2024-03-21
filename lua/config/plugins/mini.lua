local indentscope = {
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  config = function()
    local mi = require("mini.indentscope")
    mi.setup({
      options = { try_as_border = true },
      draw = {
        animation = require("mini.indentscope").gen_animation.quadratic({ duration = 10 }),
      },
    })
  end,
}
local surround = {
  keys = {
    { "ys", desc = "Add surrounding", mode = { "n", "v" } },
    { "ds", desc = "Delete surrounding" },
    { "cs", desc = "Replace surrounding" },
  },
  opts = {
    mappings = {
      add = "ys", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      replace = "cs", -- Replace surrounding
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
      update_n_lines = "", -- Update `n_lines`
      suffix_last = "", -- Suffix to search with "prev" method
      suffix_next = "", -- Suffix to search with "next" method
    },
  },
}
local bufremove = {
  keys = {
    {
      "<leader>bd",
      function()
        local bd = require("mini.bufremove").delete
        if vim.bo.modified then
          local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
          if choice == 1 then -- Yes
            vim.cmd.write()
            bd(0)
          elseif choice == 2 then -- No
            bd(0, true)
          end
        else
          bd(0)
        end
      end,
      desc = "Delete Buffer",
    },
    { "<leader>bD", "<CMD>lua require('mini.bufremove').delete(0, true)<CR>", desc = "Delete Buffer (Force)" },
  },
}
local pairs = {
  keys = {
    {
      "<leader>up",

      function()
        local Util = require("lazy.core.util")
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          Util.warn("Disabled auto pairs", { title = "Option" })
        else
          Util.info("Enabled auto pairs", { title = "Option" })
        end
      end,
      desc = "Toggle auto pairs",
    },
  },
}

return {
  indentscope = indentscope,
  surround = surround,
  bufremove = bufremove,
  pairs = pairs,
}
