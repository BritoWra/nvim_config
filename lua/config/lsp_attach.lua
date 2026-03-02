local M = {}

M.on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  
  -- Navegación
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Show references", buffer = bufnr })
  
  -- Información
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover", buffer = bufnr })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })
  
  -- Acciones
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
  
  -- Diagnósticos
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = bufnr })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic", buffer = bufnr })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic", buffer = bufnr })
end

return M
