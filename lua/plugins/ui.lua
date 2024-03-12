return {
  -- 很多 ui 相关插件的插件的依赖
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        deb = { icon = "", name = "Deb" },
        lock = { icon = "󰌾", name = "Lock" },
        mp3 = { icon = "󰎆", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "󰚩", name = "Robots" },
        ttf = { icon = "", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "", name = "WebOpenFontFormat" },
        woff2 = { icon = "", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
    },
  },
  -- 全局主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function (_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-macchiato")
    end
  },
  -- 首页
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⣀⣤⣴⡶⠾⠿⠟⠛⠛⠛⠛⠛⠿⢶⠆⠀⠀⠐⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠈⠀⢀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⢀⠰⠀⠰⠈⠀⠈⠀⠀⠁⠀⠆⠈⠀⠀⢀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠄⠈⠀⠀⢀⠀⠀⠄⠂⠀⠁⠀⠄⠀⠠⠀⠠⠀⠀⡀⠘⠣⠄⠩⠩⠙⠻⢿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⠏⢀⣤⣤⡀⠂⠀⠀⠂⠈⠀⠀⠠⠀⠀⠐⠀⠠⠀⠂⣠⣶⣦⠀⠀⢀⠀⠀⠀⠀⢀⠀⠀⠘⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⡏⠀⣾⣿⣿⡟⠀⠀⠁⢰⡄⢀⣼⣶⣄⢈⣰⡆⠀⢀⢸⣿⣿⣿⠇⠀⠀⢀⠈⠀⠈⠀⠀⠠⠀⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⠁⠀⠙⠿⠋⠁⠀⠀⠂⠈⠛⠛⠉⠀⠉⠋⠉⠀⠀⡀⠀⠙⠛⠛⠀⠀⠈⠀⠀⡀⠁⠀⠂⠀⠀⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⢀⠀⠁⠀⠄⠀⡀⠠⠀⠀⠄⠀⠐⠀⠀⠠⠀⢀⠀⢀⠀⠁⠀⠄⠀⠀⠂⠀⠈⢰⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⡄⠀⠁⢀⠀⠠⠐⠀⠀⠄⠀⢀⠀⠂⠀⠐⠀⠀⠂⠀⠠⠀⠀⡀⠀⠐⠀⢀⠀⠁⠀⠈⠀⣸⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⡀⠆⠀⢀⠀⠀⠀⠆⠀⠀⠁⠀⠰⠀⠀⡀⠀⠀⠆⠈⠀⠀⠀⠁⠀⢶⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡈⠀⢀⠀⠀⠠⢀⣀⣐⣀⡀⠈⠀⠀⠂⠀⠠⠀⠀⠀⠂⠀⡀⠄⠀⠁⠀⢤⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠘⣶⣮⣥⣤⣠⣄⣤⣀⣈⣁⣂⣦⣄⠀⢐⣮⣤⣤⡀⣠⣤⣴⣌⣰⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ]]

      local header = {}
      logo = string.rep("\n", 6) .. logo .. "\n"
      for _, val in ipairs(vim.split(logo, "\n")) do
        local s = string.gsub(val, "%s+", "")
        table.insert(header, s)
      end

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = header,
          center = {
            { icon = " ", key = "f", desc = " Find file", action = "Telescope find_files" },
            { icon = " ", key = "n", desc = " New file", action = "ene | startinsert" },
            { icon = " ", key = "r", desc = " Recent files", action = "Telescope oldfiles" },
            { icon = " ", key = "g", desc = " Find text", action = "Telescope live_grep" },
            { icon = " ", key = "s", desc = " Restore Session", action = 'lua require("persistence").load()' },
            { icon = " ", key = "x", desc = " Lazy Extras", action = "LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = " Lazy", action = "Lazy" },
            { icon = " ", key = "q", desc = " Quit", action = "qa" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  -- 顶部 buffer
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<CMD>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<CMD>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<CMD>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<CMD>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "<S-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        -- diagnostics = "nvim_lsp",
        -- always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --   .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  -- 底部工具栏
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = {},
  },
  -- 缩进线
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VeryLazy",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      local mi = require("mini.indentscope")
      mi.setup({
        options = { try_as_border = true },
        draw = {
          animation = require("mini.indentscope").gen_animation.quadratic({ duration = 10 }),
        },
      })
    end
  },
  {
    "MunifTanjim/nui.nvim",
  },
  -- 更人性化的通知
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  }
}

