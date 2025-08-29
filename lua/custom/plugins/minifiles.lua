return {
  'echasnovski/mini.files',
  opts = {},
  keys = {
    {
      -- Open mini.files at current working directory
      '<leader>ee',
      function()
        require('mini.files').open(vim.fn.getcwd())
      end,
      desc = 'Open Mini.files',
    },
  },
}
