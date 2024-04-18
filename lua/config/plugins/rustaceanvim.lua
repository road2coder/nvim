return {
  version = "^4", -- Recommended
  lazy = false, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
          end
          -- rust-lsp
          map("n", "K", "<CMD>RustLsp hover actions<CR>", "Rust hover docs")
          map("n", "J", function()
            vim.cmd.RustLsp("joinLines")
          end, "Rust join lines")
          map("n", "<Leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, "Rust Code action")
          map("n", "<Leader>rue", function()
            vim.cmd.RustLsp("explainError")
          end, "Rust error explain")
          map("n", "<Leader>rud", function()
            vim.cmd.RustLsp("openDocs")
          end, "Rust docs")
          map("n", "<Leader>rum", function()
            vim.cmd.RustLsp("expandMacro")
          end, "Rust expand macro")
        end,
      },
    }
  end,
  setup = function() end,
}
