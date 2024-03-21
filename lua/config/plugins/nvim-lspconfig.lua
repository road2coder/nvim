return {
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvimdev/lspsaga.nvim",
    -- lsp 支持 vim 内置 api
    { "folke/neodev.nvim", opts = {} },
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
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
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = require("config").icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = require("config").icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = require("config").icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = require("config").icons.diagnostics.Info,
        },
      },
    },
  },
  config = function(_, opts)
    -- neoconf
    local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
    require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))

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
          lsp_config.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities(),
            lsp_config.capabilities or {}
          )

          require("lspconfig")[lsp_name].setup(lsp_config)
        end,
      },
    })
    require("lspsaga").setup({})
  end,
  keys = {
    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
    { "K", vim.lsp.buf.hover, desc = "[H]over" },
    -- { "gh", vim.lsp.buf.hover, desc = "[H]over" },
    { "gi", vim.lsp.buf.implementation, desc = "[G]oto [I]mplementation" },
    { "gr", vim.lsp.buf.references, desc = "[G]oto [R]eferences" },
    { "\\f", vim.lsp.buf.format, desc = "[F]ormat(lsp)", mode = { "n", "v" } },
    -- use lspsaga
    { "gh", "<CMD>Lspsaga hover_doc<CR>", desc = "[H]over" },
    { "<leader>ca", "<CMD>Lspsaga code_action<CR>", desc = "[A]ctoins" },
    { "\\a", "<CMD>Lspsaga code_action<CR>", desc = "[A]ctoins" },
    { "<leader>rn", "<CMD>Lspsaga rename<CR>", desc = "[R]e[n]ame" },
    { "\\r", "<CMD>Lspsaga rename<CR>", desc = "[R]ename" },
    -- { "", "<CMD>Lspsaga outline<CR>", desc = "Show [O]utline" },
    -- use telescope
    { "gd", "<CMD>Telescope lsp_definitions<CR>", desc = "[G]oto [D]efinition" },
    { "<leader>sd", "<CMD>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
    { "<leader>sD", "<CMD>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
    { "<leader>ss", "<CMD>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    { "<leader>sS", "<CMD>Telescope lsp_workspace_symbols<CR>", desc = "Document symbols" },
  },
}
