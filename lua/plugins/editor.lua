return {
  -- 跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      { ",s", mode = { "n", "x", "o" }, "<CMD>lua require('flash').jump()<CR>", desc = "Flash" },
      { ",,", mode = { "n", "o", "x" },  "<CMD>lua require('flash').treesitter()<CR>", desc = "Flash Treesitter" },
      { "r", mode = "o", "<CMD>lua require('flash').remote()<CR>", desc = "Remote Flash" },
      { "R", mode = "o", "<CMD>lua require('flash').treesitter_search()<CR>", desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },  "<CMD>lua require('flash').toggle()<CR>", desc = "Toggle Flash Search" },
    },
  },
  -- 折叠功能
  {
    "kevinhwang91/nvim-ufo",
    event = { "VeryLazy" },
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      -- 一些必要的设置
      vim.opt.foldcolumn = '1'
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close All Folds" })

      -- 显示折叠的总行数
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end
      require("ufo").setup({
        -- 使用 treesitter 和 缩进 进行折叠
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler,
        close_fold_kinds = {'imports', 'comment'},
      })
    end,
  },
  -- 删除 buffer
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      { "<leader>bD","<CMD>lua require('mini.bufremove').delete(0, true)<CR>", desc = "Delete Buffer (Force)" },
    },
  },
}
