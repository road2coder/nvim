for _, source in ipairs {
  -- "bootstrap",
  "config.options",
  "config.autocmds",
  "config.lazy",
  "config.keymaps",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end
