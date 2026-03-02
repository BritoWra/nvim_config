return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For looking up context
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the UI for input/select
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
        agent = {
          adapter = "gemini",
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = os.getenv("GEMINI_API_KEY"),
            },
          })
        end,
      },
    })

    -- Keymaps
    vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "AI Chat Toggle" })
    vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "AI Add Selection to Chat" })
    vim.keymap.set({ "n", "v" }, "<LocalLeader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "AI Actions (Explain, Fix, etc.)" })

    -- Expand 'cc' into CodeCompanion actions
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
