local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
if fname ~= 'Cargo.toml' then
  return
end

local config = require('rustaceanvim.config.internal')
local ra = require('rustaceanvim.rust_analyzer')
if config.tools.reload_workspace_from_cargo_toml then
  vim.api.nvim_create_autocmd('BufWritePost', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if #ra.get_active_rustaceanvim_clients(nil) > 0 then
        vim.cmd.RustLsp { 'reloadWorkspace', mods = { silent = true } }
      end
    end,
    group = vim.api.nvim_create_augroup('RustaceanCargoReloadWorkspace', { clear = false }),
  })
end
