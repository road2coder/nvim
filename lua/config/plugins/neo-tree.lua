return {
  keys = {
    { "<leader>e", "<cmd>Neotree left toggle<cr>", desc = "Toggle Explorer" },
    { "<leader>fe", "<cmd>Neotree float reveal toggle<cr>", desc = "Toggle Explorer(float)" },
    {
      "<leader>o",
      function()
        if vim.bo.filetype ~= "neo-tree" then
          vim.cmd.Neotree("focus")
        end
      end,
      desc = "Foces Explorer",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  -- copy from lazyvim
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  -- TODO: 增加其它命令和事件
  opts = {
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then -- 没展开时展开
            state.commands.toggle_node(state)
          else -- 聚焦到第一个子节点
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- 打开文件
          state.commands.open(state)
        end
      end,
      -- 在左边时，失去焦点
      blur_when_left = function(state)
        if state.current_position == "left" then
          vim.cmd.wincmd("p")
        end
      end,
    },
    window = {
      width = 35,
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        --["[b"] = "prev_source",
        --["]b"] = "next_source",
        h = "parent_or_close",
        l = "child_or_open",
        o = "open",
        ["<leader>o"] = "blur_when_left",
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
    },
    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    },
  },
  config = function(_, opts)
    local diagnostics = require("config").icons.diagnostics
    vim.fn.sign_define("DiagnosticSignError", { text = diagnostics.Error, texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = diagnostics.Warn, texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = diagnostics.Info, texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = diagnostics.Hint, texthl = "DiagnosticSignHint" })
    require("neo-tree").setup(opts)
  end,
}
