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
  keys = {
    { '<leader>ea', '<cmd>AerialToggle!<cr>', desc = 'Toggle Aerial' },
  },
}
