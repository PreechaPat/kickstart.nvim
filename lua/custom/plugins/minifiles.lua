return {
  'echasnovski/mini.files',
  opts = {},
  keys = {
    {
      -- Open mini.files at current working directory
      '-',
      function()
        require('mini.files').open(vim.fn.getcwd())
      end,
      desc = 'Open Mini.files',
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    -- Create an autocmd to add custom mappings every time mini.files opens
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        -- Helper function to open file in a specific way and close the explorer
        local map_split = function(lhs, direction)
          vim.keymap.set('n', lhs, function()
            local fs_entry = require('mini.files').get_fs_entry()
            if fs_entry ~= nil and fs_entry.fs_type == 'file' then
              -- Close the explorer first so the split opens in the main window
              require('mini.files').close()
              vim.cmd(direction .. ' ' .. vim.fn.fnameescape(fs_entry.path))
            end
          end, { buffer = buf_id, desc = 'Open in ' .. direction })
        end

        -- Add your custom mappings here
        map_split('<C-t>', 'tabedit')
        map_split('<C-s>', 'split')
        map_split('<C-v>', 'vsplit')
      end,
    })
  end,
}
