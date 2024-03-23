return {
  name = "barbecue",
  event = "VeryLazy",
  dependencies = "SmiteshP/nvim-navic",
  opts = {
    attach_navic = false,
    theme = vim.g.colorscheme or nil,
  },
  config = function(_, opts)
    require("utils").on_attach(function(client, buffer)
      if client.supports_method("textDocument/documentSymbol") then
        -- vue 文件 symbol 由 volar 提供
        local is_attch = vim.bo[buffer].filetype ~= "vue" or client.name == "volar"
        if is_attch then
          require("nvim-navic").attach(client, buffer)
        end
      end
    end)
    require("barbecue").setup(opts)
  end,
}
