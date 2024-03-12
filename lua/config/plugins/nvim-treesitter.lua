return {
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "windwp/nvim-ts-autotag",
      -- event = "LazyFile",
      event = "VeryLazy",
      opts = {},
    },
  },
  keys = {
    { "<A-l>", desc = "Increment selection" },
    { "<A-h>", desc = "Decrement selection", mode = "x" },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "html",
      "vue",
      "javascript",
      "tsx",
      "typescript",
      "css",
      "scss",
      "bash",
      "c",
      "diff",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "python",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    },
    -- 扩选/缩选
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<A-l>",
        node_incremental = "<A-l>",
        scope_incremental = false,
        node_decremental = "<A-h>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
          ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
          ["af"] = { query = "@function.outer", desc = "around function " },
          ["if"] = { query = "@function.inner", desc = "inside function " },
          ["aa"] = { query = "@parameter.outer", desc = "around argument" },
          ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function start" },
          ["]?"] = { query = "@conditional.outer", desc = "Next contitional start" },
        },
        goto_next_end = {
          ["]F"] = { query = "@function.outer", desc = "Next function end" },
          ["]."] = { query = "@conditional.outer", desc = "Next contitional end" },
        },
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function tart" },
          ["[?"] = { query = "@conditional.outer", desc = "Previous contitional start" },
        },
        goto_previous_end = {
          ["[F"] = { query = "@function.outer", desc = "Previous function end" },
          ["[."] = { query = "@conditional.outer", desc = "Previous contitional end" },
        },
      },
    },
  },
  config =  function(_, opts)
    if type(opts.ensure_installed) == "table" then
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(parser)
        if added[parser] then return false end
        added[parser] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
  end
} 
