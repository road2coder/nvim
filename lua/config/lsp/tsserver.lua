local data_path = vim.fn.stdpath('data')
local location = data_path.."/mason/packages/vue-language-server/node_modules/@vue/language-server"

return {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = location,
        languages = {"javascript", "typescript", "vue"},
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}
