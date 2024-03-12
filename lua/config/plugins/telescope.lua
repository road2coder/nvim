local utils = require("utils")

return {
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
      config = function()
        utils.on_load("telescope.nvim", function()
          require("telescope").load_extension("fzf")
        end)
      end,
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    local icons = require("icons")
    return {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        prompt_prefix = icons.Selected.." ",
        selection_caret = icons.Caret.." ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.84,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = { q = actions.close },
        },
      },
    }
  end,
  keys = {
    {
      "<leader>,",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "File Files" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git)" },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").oldfiles({ cwd = vim.loop.cwd() })
      end,
      desc = "Recent (cwd)",
    },
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep(cwd)" },
    {
      "<leader>sG",
      function()
        require("telescope.builtin").live_grep({ cwd = vim.loop.cwd() })
      end,
      desc = "Telescope live_grep(root dir)"
    },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    {
      "<leader>sw",
      function()
        require("telescope.builtin").grep_string({ word_match = "-w", cwd = vim.loop.cwd() })
      end,
      mode = { "n", "v" },
      desc = "Find Word(cwd)",
    },
    {
      "<leader>sW",
      function()
        require("telescope.builtin").grep_string({ word_match = "-w" })
      end,
      mode = { "n", "v" },
      desc = "Find Word(root dir)",
    },
    {
      "<leader>uC",
      function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end,
      desc = "Colorscheme with preview",
    },
    -- {
    --   "<leader>ss",
    --   function()
    --     require("telescope.builtin").lsp_document_symbols({
    --       symbols = require("lazyvim.config").get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol",
    -- },
    -- {
    --   "<leader>sS",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = require("lazyvim.config").get_kind_filter(),
    --     })
    --   end,
    --   desc = "Goto Symbol (Workspace)",
    -- },
  },
}
