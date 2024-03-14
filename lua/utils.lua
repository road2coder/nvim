local M = {}
function M.switch_ime_en()
  local has = vim.fn.has
  if has("win32") == 1 or has("wsl") == 1 then
    vim.fn.system({ "im-select.exe", "1033" })
  elseif vim.fn.has("linux") == 1 then
    vim.fn.system({ "fcitx5-remote", "-s", "keyboard-us" })
  end
end

function M.switch_ime_cn()
  local has = vim.fn.has
  if has("win32") == 1 or has("wsl") == 1 then
    vim.fn.system({ "im-select.exe", "2052" })
  end
end

-- 左侧状栏的格式
function M.statuscolumn() 
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  if not is_file then
    return ""
  end
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

function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end


-- 简单的柯里化函数
function M.curry(fn, ...)
  local args = {}
  local n1 = select("#", ...)
  for i = 1, n1 do
    table.insert(args, (select(i, ...)))
  end
  return function(...)
    local n2 = select("#", ...)
    local unpack = unpack or table.unpack
    for i = 1, n2 do
      table.insert(args, (select(i, ...)))
    end
    fn(unpack(args))
  end
end

-- 获取 visual 模式选中的文本（非 normal 为上次选中）
function M.get_selection()
  local a_orig = vim.fn.getreg("a")
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    -- vim.cmd([[normal! gv]])
    return ""
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg("a")
  vim.fn.setreg("a", a_orig)
  return text
end

-- 替换选中的内容
function M.replace_selection(case)
  local str = M.get_selection()
  if not str then
    return nil
  end
  local to_replace = M.convert_case(str, case)
  vim.api.nvim_feedkeys("c" .. to_replace, "n", true)
  local key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(key, "n", true)
end

function M.copy_selection(case)
  local str = M.get_selection()
  if not str then
    return nil
  end
  local to_copy = M.convert_case(str, case)
  vim.fn.setreg("*", to_copy)
  vim.api.nvim_input("<esc>")
end

-- 转换字符串的形式
function M.convert_case(str, case)
  -- 可转换的模式
  local separators = {
    kebab = "-",
    camel = "",
    pascal = "",
    snake = "_",
  }
  local sep = separators[case]
  if not sep then
    return nil
  end

  -- pascal case 处理
  if string.find(str, "[a-z]") ~= nil then
    str = str:gsub("%u", " %0"):gsub("^%s*(.-)%s*$", "%1")
  end

  local words = {}
  for word in str:gmatch("%a+") do
    table.insert(words, word)
  end

  local result = ""
  for i, word in ipairs(words) do
    -- kebab 或 snake: 将单词全部小写
    if case == "kebab" or case == "snake" then
      word = word:lower()
    -- camel 或 pascal: 将单词首字母大写，其余小写
    elseif case == "camel" or case == "pascal" then
      word = word:sub(1, 1):upper() .. word:sub(2):lower()
    end
    -- camel 且单词是第一个: 将单词首字母小写
    if case == "camel" and i == 1 then
      word = word:sub(1, 1):lower() .. word:sub(2)
    end
    result = result .. word
    if i < #words then
      result = result .. sep
    end
  end

  return result
end

return M
