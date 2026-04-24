vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'number'

-- Toggle on and off for diagnostics.
local diagnostics_virtual_text = true
vim.keymap.set('n', '<leader>tw', function()
  diagnostics_virtual_text = not diagnostics_virtual_text
  vim.diagnostic.config { virtual_text = diagnostics_virtual_text }
end, { desc = 'Toggle warnings in diagnostics' })

vim.opt.clipboard = 'unnamedplus'

if vim.fn.exists '$SSH_CONNECTION' == 1 then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end
