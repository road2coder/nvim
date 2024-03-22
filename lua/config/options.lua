-- 与 neovim 选项的设置的相关的命令有 set、setlocal、setglobal 和 let。使用 set 开头
-- 的用于设置一些 neovim 内置相关的项，如 ignorecase 和大小写相关。而 let 则用于设置
-- 一些变量，这些变量可以是 neovim 本身使用到的，如 mapleader，也可以是用户自己要用的
-- 一些变量。 let 默认设置的是全局变量，也可以指定范围，如 let b:key=value 则只在当前
-- buffer 生效
-- 而在 lua 中，与 set 相关的有
--    vim.go  相当于 setglobal
--    vim.bo  相当于 setlocal
--    vim.o   相当于 set（同时设置 global 和 local）
--    vim.opt 和 vim.o 作用相同，但用法不同，可以参考 :h vim.opt
-- 而和 let 相关的有 vim.g vim.w vim.b 等，它们设置的变量的生效范围不同。
local opt = vim.opt

vim.g.mapleader = " " -- leader 键，需要在设置按键映射之前设置

-- 部分选项参考了 lazyvim https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
opt.clipboard = "unnamedplus" -- 使用系统剪切板
opt.ignorecase = true -- 忽略大写小
opt.smartcase = true -- 智能忽略大小写
if not vim.g.vscode then
  vim.g.colorscheme = "tokyonight-moon"
  -- 安装了的主题，会在该主题加载后，自动设置 colorscheme
  vim.g.colorschemes = {
    "tokyonight.nvim",
    "catppuccin",
    "onedarkpro.nvim",
  }
  opt.undofile = true -- 持久化操作记录
  opt.undolevels = 10000
  opt.autowrite = true
  opt.completeopt = "menu,menuone,noselect"
  opt.conceallevel = 2
  opt.confirm = true
  opt.cursorline = true
  opt.cmdheight = 0 -- 非必要时，隐藏命令行
  opt.expandtab = true -- 使用空格（space）进行缩进而不是制表符（tab）
  opt.shiftwidth = 2 -- 一个综进的空格数
  opt.smartindent = true
  opt.fileformats="unix,dos"
  opt.formatoptions = "jcroqlnt" -- tcqj
  opt.grepformat = "%f:%l:%c:%m"
  opt.grepprg = "rg --vimgrep"
  opt.inccommand = "nosplit"
  opt.laststatus = 3
  opt.list = true -- 显示不可见字符，如 tab
  opt.mouse = "a" -- 所有模式可用鼠标
  opt.number = true -- 显示当前行号
  opt.relativenumber = true -- 显示相对行号
  opt.pumblend = 10
  opt.pumheight = 10
  opt.scrolloff = 3 -- 在最底/顶部滚动时保留的行数
  opt.sidescrolloff = 8
  opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
  opt.shiftround = true
  opt.shortmess:append({ W = true, I = true, c = true, C = true })
  opt.showmode = false -- 不显示模式（会用插件显示）
  opt.signcolumn = "yes"
  opt.spelllang = { "en" }
  opt.splitkeep = "screen"
  opt.splitright = true -- 纵向新窗口出现在右方
  opt.tabstop = 2
  opt.termguicolors = true -- 真色彩
  opt.timeoutlen = 500
  opt.updatetime = 200
  opt.virtualedit = "block"
  opt.wildmode = "longest:full,full"
  opt.winminwidth = 5
  opt.wrap = false -- 代码过长时不换行
  opt.fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "·",
    foldsep = " ",
    -- diff = "╱",
    fold = " ",
    eob = " ",
  }

  if vim.fn.has("wsl") == 1 then
    vim.g.netrw_browsex_viewer = "cmd.exe /C start" -- wsl 中按 gx 可打开 windows 浏览器
  end

  vim.o.statuscolumn = "%!v:lua.require('utils.ui').statuscolumn()"
  -- vim.o.statuscolumn = "%!v:lua.require('utils').statuscolumn()"
else
  opt.timeoutlen = 1000
end
