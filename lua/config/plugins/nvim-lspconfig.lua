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
        function(lsp_name)
          -- 读取 lua/config/lsp/ 同名的文件
          local ok, lsp_config = pcall(require, "config.lsp." .. lsp_name)
          if not ok then
            lsp_config = {}
          end
          require("lspconfig")[lsp_name].setup(lsp_config)
        end,
      },
    })
  end,
  keys = {
    { "gd", vim.lsp.buf.definition, desc = "[G]oto [D]efinition" },
    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    { "K", vim.lsp.buf.hover, desc = "[H]over" },
    { "gh", vim.lsp.buf.hover, desc = "[H]over" },
    { "gi", vim.lsp.buf.implementation, desc = "[G]oto [I]mplementation" },
    { "gr", vim.lsp.buf.references, desc = "[G]oto [R]eferences" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "[C]ode [A]ctoins" },
    { "\\a", vim.lsp.buf.code_action, desc = "[A]ctoins" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },
    { "\\r", vim.lsp.buf.rename, desc = "[R]ename" },
    { "\\f", vim.lsp.buf.format, desc = "[F]ormat", mode = { "n", "v" }, },
  },
}
