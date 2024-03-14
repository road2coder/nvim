return {
  dependencies = {
    "nvimtools/none-ls.nvim",
  },
  opts = {
    pattern = {
      "lua",
      "vue",
      "javascript",
      "typescript",
    },
    ensure_installed = {
      "prettier",
      "stylua",
    },
  },
  config = function(_, opts)
    require("mason").setup()
    require("mason-null-ls").setup({
      automatic_installation = false,
      handlers = {},
      ensure_installed = opts.ensure_installed,
    })
    require("null-ls").setup()

    -- 用 null-ls 来控制格式化
    -- TODO: 统一配置format key map
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("null_ls_format", { clear = true }),
      pattern = opts.pattern,
      callback = function(event)
        vim.keymap.set({ "n", "v" }, "\\f", function()
          vim.lsp.buf.format({
            async = true,
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end, { buffer = event.buf, silent = true, desc = "[F]ormat(null-ls)" })
      end,
    })
  end,
}
