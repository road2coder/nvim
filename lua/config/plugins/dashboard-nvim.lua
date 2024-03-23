return {
  event = "VimEnter",
  opts = function()
    local logo = [[
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⣀⣤⣴⡶⠾⠿⠟⠛⠛⠛⠛⠛⠿⢶⠆⠀⠀⠐⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠈⠀⢀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⢀⠰⠀⠰⠈⠀⠈⠀⠀⠁⠀⠆⠈⠀⠀⢀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠄⠈⠀⠀⢀⠀⠀⠄⠂⠀⠁⠀⠄⠀⠠⠀⠠⠀⠀⡀⠘⠣⠄⠩⠩⠙⠻⢿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⠏⢀⣤⣤⡀⠂⠀⠀⠂⠈⠀⠀⠠⠀⠀⠐⠀⠠⠀⠂⣠⣶⣦⠀⠀⢀⠀⠀⠀⠀⢀⠀⠀⠘⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⡏⠀⣾⣿⣿⡟⠀⠀⠁⢰⡄⢀⣼⣶⣄⢈⣰⡆⠀⢀⢸⣿⣿⣿⠇⠀⠀⢀⠈⠀⠈⠀⠀⠠⠀⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⠁⠀⠙⠿⠋⠁⠀⠀⠂⠈⠛⠛⠉⠀⠉⠋⠉⠀⠀⡀⠀⠙⠛⠛⠀⠀⠈⠀⠀⡀⠁⠀⠂⠀⠀⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⢀⠀⠁⠀⠄⠀⡀⠠⠀⠀⠄⠀⠐⠀⠀⠠⠀⢀⠀⢀⠀⠁⠀⠄⠀⠀⠂⠀⠈⢰⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠁⢀⠀⠠⠐⠀⠀⠄⠀⢀⠀⠂⠀⠐⠀⠀⠂⠀⠠⠀⠀⡀⠀⠐⠀⢀⠀⠁⠀⠈⠀⣸⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⡀⠆⠀⢀⠀⠀⠀⠆⠀⠀⠁⠀⠰⠀⠀⡀⠀⠀⠆⠈⠀⠀⠀⠁⠀⢶⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⡈⠀⢀⠀⠀⠠⢀⣀⣐⣀⡀⠈⠀⠀⠂⠀⠠⠀⠀⠀⠂⠀⡀⠄⠀⠁⠀⢤⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠘⣶⣮⣥⣤⣠⣄⣤⣀⣈⣁⣂⣦⣄⠀⢐⣮⣤⣤⡀⣠⣤⣴⣌⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿
          ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
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
}
