local utils = {}
function utils.switch_ime_en()
  local has = vim.fn.has
  if has("win32") == 1 or has("wsl") == 1 then
    vim.fn.system({ "im-select.exe", "1033" })
  elseif vim.fn.has("linux") == 1 then
    vim.fn.system({ "fcitx5-remote", "-s", "keyboard-us" })
  end
end

function utils.switch_ime_cn()
  local has = vim.fn.has
  if has("win32") == 1 or has("wsl") == 1 then
    vim.fn.system({ "im-select.exe", "2052" })
  end
end

-- 左侧状栏的格式
function utils.statuscolumn() 
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  local show_signs = vim.wo[win].signcolumn ~= "no"

  -- TODO 计算左侧图标、gitsigns 等
  local left, middle, right = "", "", ""

  -- 中间行号部分
  local no = vim.wo[win].number
  local relno = vim.wo[win].relativenumber
  if (no or relno) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      middle = no and "%l" or "%r" -- 当前行
    else
      middle = relno and "%r" or "%l" -- 其它行
    end
    middle = "%=" .. middle .. " " -- 向右对齐
  end

  -- 右侧
  local lnum = vim.v.lnum
  local foldl = vim.fn.foldlevel
  if foldl(lnum) > foldl(lnum - 1) then
    local fcs = vim.opt.fillchars:get()
    right = vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
    right = right.." "
  else
    right = "  "
  end
  return left..middle..right
end

return utils
