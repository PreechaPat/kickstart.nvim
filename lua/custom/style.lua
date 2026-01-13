vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'

-- Toggle on and off for diagnostics.
local diagnostics_virtual_text = true
vim.keymap.set('n', '<leader>tw', function()
  diagnostics_virtual_text = not diagnostics_virtual_text
  vim.diagnostic.config { virtual_text = diagnostics_virtual_text }
end, { desc = 'Toggle warnings in diagnostics' })

-- Need this for LSP to work... maybe there is a better way to add them later.
-- https://github.com/nvim-lua/kickstart.nvim/pull/1475
vim.filetype.add {
  extension = {
    nf = 'nextflow', -- Replace 'foo' with your extension, and 'python' with the desired filetype
  },
}

vim.lsp.config('nextflow_ls', {
  cmd = { 'java', '-jar', vim.fn.expand '~/.local/nextflow-language-server-all.jar' },
  filetypes = { 'nextflow' },
  settings = {
    nextflow = {
      files = {
        exclude = { '.git', '.nf-test', 'work' },
      },
    },
  },
})

vim.opt.clipboard = 'unnamedplus'

-- If you want to be explicit about using OSC 52
if vim.fn.has 'nvim-0.10' == 1 then
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
