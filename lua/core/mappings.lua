local wk = require 'which-key'

function BetterGX(uri)
  local redir = '&> /dev/null'
  local viewer
  if vim.fn.exists 'g:netrw_browsex_viewer' then
    viewer = vim.g.netrw_browsex_viever
  elseif vim.fn.has 'unix' and vim.fn.executable 'xdg-open' then
    viewer = 'xdg-open'
  elseif vim.fn.has 'macunix' and vim.fn.executable 'open' then
    viewer = 'open'
  elseif vim.fn.has 'win64' or vim.fn.has 'win32' then
    viewer = 'start'
    redir = '> null'
  else
    return
  end

  vim.fn.execute('silent !' .. viewer .. ' ' .. vim.fn.shellescape(uri, 1) .. redir)
  vim.fn.redraw()
end

wk.register {
  s = { ':w<cr>', 'Save current file' },
  q = { ':Bdelete<cr>', 'Close current buffer' },
  ['<Tab>'] = { '<Plug>(cokeline-focus-next)', 'Next buffer' },
  ['<S-Tab>'] = { '<Plug>(cokeline-focus-prev)', 'Previous buffer' },
  ['<C-/>'] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", 'Comment current line' },
  ['<C-f>'] = { '<cmd>Telescope live_grep<CR>', 'Telescope live grep' },
  ['<C-o>'] = { '<cmd>Telescope find_files<CR>', 'Telescope find files' },
  ['<C-Left>'] = { '<C-w>h', 'To the left tab' },
  ['<C-Down>'] = { '<C-w>j', 'To the bottom tab' },
  ['<C-Up>'] = { '<C-w>k', 'To the upper tab' },
  ['<C-Right>'] = { '<C-w>l', 'To the right tab' },
  ['=G'] = { '<cmd>lua vim.lsp.buf.format()<CR>', 'Reindent' },
  ['gx'] = {
    function()
      BetterGX(vim.fn.expand '<cWORD>')
    end,
    'Open the file under the cursor',
  },
}

wk.register({
  d = { [["_d]], 'Delete w/o yank' },
  y = { [["+y]], 'Yank to clipboard' },
}, { mode = { 'n', 'v' } })

wk.register({
  t = { '<cmd>ToggleTerm<cr>', 'Open terminal' },
  ['fw'] = { '<cmd>Telescope<cr>', 'Telescope' },
  ['nt'] = { '<cmd>NvimTreeToggle<cr>', 'Toggle NvimTree' },
  ['so'] = { '<cmd>SymbolsOutline<cr>', 'Toggle Symbols Outline' },
}, { prefix = '<leader>' })

wk.register({
  ['<C-/>'] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", 'Comment selected lines' },
}, { mode = { 'v' } })
