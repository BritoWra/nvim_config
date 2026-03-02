return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = "rounded",
          -- This determines the notification type used for notification,
          -- possible values are: 'native' | 'plugin'
          -- 'native': uses vim.notify
          -- 'plugin': uses the custom notification window provided by this plugin
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
          run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
          -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
          -- see |:help dap.set_exception_breakpoints()| for more info
          exception_breakpoints = {},
          register_configurations = function(paths)
            local dap = require("dap")
            -- more custom dap config
          end,
        },
        -- flutter_path = "<full/path/if/needed>", -- only if flutter is not in path
        lsp = {
          on_attach = require("config.lsp_attach").on_attach,
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = false, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            -- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
            renameFilesWithClasses = "prompt", -- "always"
            enableSnippets = true,
            updateImportsOnRename = true, -- Whether to update imports automatically when renaming files
          },
        },
      })
      
      -- Atajo para gestionar emuladores
      vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<CR>", { desc = "Flutter Emulators" })
      vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
      vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
      vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<CR>", { desc = "Flutter Hot Restart" })
      
      -- Comando personalizado para crear proyectos
      vim.api.nvim_create_user_command("FlutterNewProject", function()
        vim.ui.input({ prompt = "Nombre del proyecto Flutter: " }, function(name)
          if not name or name == "" then return end
          local cmd = "flutter create " .. name
          vim.notify("Creando proyecto " .. name .. "...", vim.log.levels.INFO)
          
          vim.fn.jobstart(cmd, {
            on_exit = function(_, code)
              if code == 0 then
                vim.notify("✅ Proyecto creado exitosamente", vim.log.levels.INFO)
                local choice = vim.fn.confirm("¿Abrir proyecto " .. name .. "?", "&Sí\n&No", 1)
                if choice == 1 then
                  vim.cmd("cd " .. name)
                  vim.cmd("e lib/main.dart")
                  print("Directorio de trabajo cambiado a: " .. name)
                end
              else
                vim.notify("❌ Error al crear el proyecto", vim.log.levels.ERROR)
              end
            end
          })
        end)
      end, {})

      vim.keymap.set("n", "<leader>fn", "<cmd>FlutterNewProject<CR>", { desc = "New Flutter Project" })
    end,
  },
}
