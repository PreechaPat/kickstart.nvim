-- Need this for LSP to work... maybe there is a better way to add them later.
-- https://github.com/nvim-lua/kickstart.nvim/pull/1475
vim.filetype.add {
  extension = {
    nf = 'nextflow',
  },
}

local function show_columns_in_float()
  -- Get current line
  local line = vim.api.nvim_get_current_line()

  if line == nil or line == '' then
    vim.notify('Current line is empty', vim.log.levels.WARN)
    return
  end

  -- Split by tabs first; if no tabs, fall back to whitespace
  local cols = {}
  if line:find '\t' then
    for field in line:gmatch '[^\t]+' do
      table.insert(cols, field)
    end
  else
    for field in line:gmatch '%S+' do
      table.insert(cols, field)
    end
  end

  if #cols == 0 then
    vim.notify('No columns found', vim.log.levels.WARN)
    return
  end

  -- Format output lines
  local lines = {}
  local width = 0
  for i, col in ipairs(cols) do
    local text = string.format('%2d  %s', i, col)
    table.insert(lines, text)
    width = math.max(width, vim.fn.strdisplaywidth(text))
  end

  -- Create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'columns_preview'
  vim.bo[buf].modifiable = false

  local height = math.min(#lines, math.floor(vim.o.lines * 0.6))
  width = math.min(width + 2, math.floor(vim.o.columns * 0.8))

  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
    title = ' Columns ',
    title_pos = 'center',
  })

  -- Nice local mappings to close the float
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, silent = true })

  -- Optional: make it look a bit nicer
  --
  vim.wo[win].wrap = false
  vim.wo[win].cursorline = true
end

vim.api.nvim_create_user_command('ShowColumns', show_columns_in_float, {})
vim.keymap.set('n', '<leader>sc', show_columns_in_float, { desc = 'Show columns in float' })
