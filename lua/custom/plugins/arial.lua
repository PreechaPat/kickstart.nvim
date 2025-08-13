return {

  'stevearc/aerial.nvim',
  opts = {
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    layout = {
      min_width = 30,
      default_direction = 'prefer_right',
    },
    show_guides = true,
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function(_, opts)
    require('aerial').setup(opts)
    -- Optional keymaps
    vim.keymap.set('n', '<leader>ta', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })
  end,
}
