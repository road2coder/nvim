return {
  lazy = false,
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
