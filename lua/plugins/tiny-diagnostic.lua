return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or "LspAttach"
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "modern", -- "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont"
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        options = {
            show_source = true,
            use_icons_from_diagnostic = true,
            add_messages = true,
            multiple_diag_under_cursor = true,
            multilines = true,
            show_all_diags_on_cursorline = true,
            enable_on_insert = true, -- Enable on insert as requested
            enable_on_select = false,
        }
      })
      
      -- Desactivar el texto virtual nativo para que no salga duplicado
      vim.diagnostic.config({ virtual_text = false })
    end,
  }
}
