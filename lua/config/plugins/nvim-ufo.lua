return {
  config = function()
    -- 一些必要的设置
    vim.opt.foldcolumn = "1"
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close All Folds" })

    -- 显示折叠的总行数
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end
    local opts = {
      -- 使用 treesitter 和 缩进 进行折叠
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = handler,
      close_fold_kinds_for_ft = { "imports", "comment" },
    }
    require("ufo").setup(opts)
  end,
}
