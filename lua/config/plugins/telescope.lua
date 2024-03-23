local utils = require("utils")

return {
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  lazy = false,
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
    local icons = require("config").icons
    return {
      defaults = {
        git_worktrees = vim.g.git_worktrees,
        prompt_prefix = icons.others.Selected,
        selection_caret = icons.others.Caret,
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
            ["<C-q>"] = actions.close,
          },
          n = { q = actions.close },
        },
      },
    }
  end,
  keys = {
    {
      "<leader>,",
      "<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>",
      desc = "Switch Buffer",
    },
    { "<leader>:", "<CMD>Telescope command_history<CR>", desc = "Command History" },
    -- find
    { "<leader>fb", "<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" },
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "File Files" },
    { "<leader>fg", "<CMD>Telescope git_files<CR>", desc = "Find Files (git)" },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").oldfiles({ cwd = vim.loop.cwd() })
      end,
      desc = "Recent (cwd)",
    },
    { "<leader>fR", "<CMD>Telescope oldfiles<CR>", desc = "Recent" },
    -- git
    { "<leader>gc", "<CMD>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<CMD>Telescope git_status<CR>", desc = "status" },
    -- search
    { '<leader>s"', "<CMD>Telescope registers<CR>", desc = "Registers" },
    { "<leader>sa", "<CMD>Telescope autocommands<CR>", desc = "Auto Commands" },
    { "<leader>sb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
    { "<leader>sc", "<CMD>Telescope command_history<CR>", desc = "Command History" },
    { "<leader>sC", "<CMD>Telescope commands<CR>", desc = "Commands" },
    { "<leader>sg", "<CMD>Telescope live_grep<CR>", desc = "Telescope live_grep(cwd)" },
    -- {
    --   "<leader>sG",
    --   function()
    --     require("telescope.builtin").live_grep({ cwd = vim.loop.cwd() })
    --   end,
    --   desc = "Telescope live_grep(root dir)"
    -- },
    { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "Help Pages" },
    { "<leader>sH", "<CMD>Telescope highlights<CR>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Key Maps" },
    { "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Man Pages" },
    { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "Jump to Mark" },
    { "<leader>so", "<CMD>Telescope vim_options<CR>", desc = "Options" },
    { "<leader>sR", "<CMD>Telescope resume<CR>", desc = "Resume" },
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
  },
}
