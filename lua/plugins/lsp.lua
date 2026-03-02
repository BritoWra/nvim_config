return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      local lsp_attach = require("config.lsp_attach")
      
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = lsp_attach.on_attach,
            })
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = lsp_attach.on_attach,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
