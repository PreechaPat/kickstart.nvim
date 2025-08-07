vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local diagnostics_virtual_text = true
vim.keymap.set('n', '<leader>dw', function()
  diagnostics_virtual_text = not diagnostics_virtual_text
  vim.diagnostic.config { virtual_text = diagnostics_virtual_text }
end, { desc = 'Toggle warnings in diagnostics' })
