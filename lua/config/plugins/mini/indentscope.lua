return {
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
}
