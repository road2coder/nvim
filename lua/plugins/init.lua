local utils = require("utils")
local plug_is_lazy = require("config").plug_is_lazy
local plugins = require("plugins.themes")

for _, source in ipairs({
  "plugins.coding",
  "plugins.core",
  "plugins.editor",
  "plugins.lsp",
  "plugins.ui",
  "plugins.utils",
}) do
  local ok, addr_list = pcall(require, source)
  if ok then
    for _, plug_addr in ipairs(addr_list) do
      local plug_name = utils.get_plug_name(plug_addr)
      local has_config, plugin = pcall(require, "config.plugins." .. plug_name)
      if not has_config then
        plugin = { config = true, lazy = plug_is_lazy[plug_name] or false }
        if plugin.lazy then
          plugin.config = nil
        end
      end
      plugin[1] = plug_addr
      table.insert(plugins, plugin)
    end
  end
end
return plugins
