return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false, -- Disabling due to Windows installation issues
    version = false,
    commit = "b033ab3", 
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.install").compilers = { "zig" }
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "dart", "markdown", "markdown_inline" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
