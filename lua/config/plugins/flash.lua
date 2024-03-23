return {
  event = "VeryLazy",
  vscode = true,
  config = true,
  keys = {
    { ",s", mode = { "n", "x", "o" }, "<CMD>lua require('flash').jump()<CR>", desc = "Flash" },
    { ",,", mode = { "n", "o", "x" }, "<CMD>lua require('flash').treesitter()<CR>", desc = "Flash Treesitter" },
    { "r", mode = "o", "<CMD>lua require('flash').remote()<CR>", desc = "Remote Flash" },
    { "R", mode = "o", "<CMD>lua require('flash').treesitter_search()<CR>", desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, "<CMD>lua require('flash').toggle()<CR>", desc = "Toggle Flash Search" },
  },
}
