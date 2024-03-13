return {
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "jsonls",
      "eslint",
      "html",
      "cssls",
      "volar",
      "tsserver",
    },
  },
  config = function(_, opts)
    -- 自动安装 lsp
    require("mason-lspconfig").setup({
      ensure_installed = opts.ensure_installed,
      handlers = {
        function (lsp_name)
          -- 读取 lua/config/lsp/ 同名的文件
          local ok, lsp_config = pcall(require, "config.lsp."..lsp_name)
          if not ok then
            lsp_config = {}
          end
          require("lspconfig")[lsp_name].setup(lsp_config)
        end,
      },
    })
  end
}
