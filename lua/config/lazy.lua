local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local not_in_vsc = not vim.g.vscode

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    cond = function(opt)
      return not_in_vsc or opt.vscode
    end,
  },
  install = {
    colorscheme = {},
  },
  checker = { enabled = not_in_vsc },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
