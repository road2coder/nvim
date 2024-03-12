local mappings = {
  add = "ys", -- Add surrounding in Normal and Visual modes
  delete = "ds", -- Delete surrounding
  replace = "cs", -- Replace surrounding
}
return {
  keys = {
    { mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
    { mappings.delete, desc = "Delete surrounding" },
    { mappings.replace, desc = "Replace surrounding" },
  },
  opts = {
    mappings = mappings,
  }
}
