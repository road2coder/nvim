local map = vim.keymap.set
local utils = require("utils")
local curry = utils.curry

map("n", "gh", vim.lsp.buf.hover, { desc = "Hover" })

-- 转换选中的内容
map("v", "\\1", curry(utils.replace_selection, "kebab"), { desc = "Replace selection(kebab)" })
map("v", "\\2", curry(utils.replace_selection, "camel"), { desc = "Replace selection(camel)" })
map("v", "\\3", curry(utils.replace_selection, "pascal"), { desc = "Replace selection(pascal)" })
map("v", "\\4", curry(utils.replace_selection, "snake"), { desc = "Replace selection(snake)" })

-- 复制选中内容的指定形式到剪切板
map("v", "\\q", curry(utils.copy_selection, "snake"), { desc = "copy(kebab)" })
map("v", "\\w", curry(utils.copy_selection, "camel"), { desc = "copy(camel)" })

map("v", "\\e", curry(utils.copy_selection, "pascal"), { desc = "copy(pascal)" })
map("v", "\\r", curry(utils.copy_selection, "snake"), { desc = "copy(snake)" })

map("v", "p", '"_dP', { desc = "paste multiple times" }) -- 一次复制可粘贴多次
map("n", "\\i", "ggVG=<C-o><CR>")

if not vim.g.vscode then
  -- 更好的上下移动
  map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- 窗口之间的移动
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

  -- 移动行
  map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
  map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
  map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
  map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
  map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line(s) down" })
  map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line(s) up" })

  -- 更改 buffer
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to last active" })

  -- <esc> 的同时清除搜索高亮
  map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
  map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
  map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

  -- visual 模式下，缩进后继续选中
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" }) -- 退出
  map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" }) -- 创建新的 buffer

  -- insert 使用 ctrl + shift + v 可粘贴
  map("!", "<c-s-v>", "<c-r>+", { desc = "paste" })
  map("!", "", "<c-r>+", { desc = "paste" })
else
  local action = require("vscode-neovim").action

  map("n", "\\f", curry(action, "editor.action.formatDocument"))
  map("v", "\\f", curry(action, "editor.action.formatSelection"))
  map("n", "\\r", curry(action, "editor.action.rename"))
  map("n", "H", curry(action, "workbench.action.previousEditorInGroup"))
  map("n", "L", curry(action, "workbench.action.nextEditorInGroup"))
end


