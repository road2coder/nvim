local treesitter = require("config.plugins.nvim-treesitter")

return {
  -- html jsx 自闭合标签
  {
    "windwp/nvim-ts-autotag",
    event = "User LazyFile",
    opts = {},
  },
  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- release 版本太老，在 windows 上有问题
    build = ":TSUpdate",
    event = {  "VeryLazy", "User LazyFile" },
    init = treesitter.init,
    dependencies = treesitter.dependencies,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSInstallInfo" },
    keys = treesitter.keys,
    opts = treesitter.opts,
    config = treesitter.config
  },
}
