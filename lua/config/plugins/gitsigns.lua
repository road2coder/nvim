return {
  event = "VeryLazy",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    on_attach = function(buf)
      local gs = package.loaded.gitsigns

      local map = vim.keymap.set

      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous [H]unk", buffer = buf })

      map("n", "[h", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous [H]unk", buffer = buf })

      -- Actions
      map("n", "<leader>gp", gs.preview_hunk_inline, { buffer = buf, desc = "Preview Hunk Inline" })
      map("n", "<leader>gd", gs.diffthis, { buffer = buf, desc = "Diff This" })
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end, { buffer = buf, desc = "Diff This ~" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buf, desc = "Gitsigns Hunk" })
    end,
  },
}
