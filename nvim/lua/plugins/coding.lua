return {
  -- autocompletion with blink.cmp
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "enter",
      },

      cmdline = {
        keymap = {
          -- recommended, as the default keymap will only show and select the next item
          ["<Tab>"] = { "show", "accept" },
        },
        completion = {
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
              -- enable for inputs as well, with:
              -- or vim.fn.getcmdtype() == '@'
            end,
          },
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = {
          Copilot = "",
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
        list = {
          selection = { preselect = false },
        },
      },

      -- experimental signature help support
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      -- add ai_accept to <Tab> key
      -- if not opts.keymap["<Tab>"] then
      --   if opts.keymap.preset == "super-tab" then -- super-tab
      --     opts.keymap["<Tab>"] = {
      --       require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
      --       LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
      --       "fallback",
      --     }
      --   else -- other presets
      --     opts.keymap["<Tab>"] = {
      --       LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
      --       "fallback",
      --     }
      --   end
      -- end
      require("blink.cmp").setup(opts)
    end,
  },
  -- {
  --   "saghen/blink.cmp",
  --   version = not vim.g.lazyvim_blink_main and "*",
  --   build = vim.g.lazyvim_blink_main and "cargo build --release",
  --   opts_extend = {
  --     "sources.completion.enabled_providers",
  --     "sources.compat",
  --     "sources.default",
  --   },
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     -- add blink.compat to dependencies
  --     {
  --       "saghen/blink.compat",
  --       optional = true, -- make optional so it's only enabled if any extras need it
  --       opts = {},
  --       version = not vim.g.lazyvim_blink_main and "*",
  --     },
  --   },
  --   event = "InsertEnter",
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     snippets = {
  --       expand = function(snippet, _)
  --         return LazyVim.cmp.expand(snippet)
  --       end,
  --     },
  --     appearance = {
  --       -- sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release, assuming themes add support
  --       use_nvim_cmp_as_default = false,
  --       -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = "mono",
  --     },
  --     completion = {
  --       accept = {
  --         -- experimental auto-brackets support
  --         auto_brackets = {
  --           enabled = true,
  --         },
  --       },
  --       menu = {
  --         draw = {
  --           treesitter = { "lsp" },
  --         },
  --       },
  --       documentation = {
  --         auto_show = true,
  --         auto_show_delay_ms = 200,
  --       },
  --       ghost_text = {
  --         enabled = vim.g.ai_cmp,
  --       },
  --     },
  --
  --     -- experimental signature help support
  --     -- signature = { enabled = true },
  --
  --     sources = {
  --       -- adding any nvim-cmp sources here will enable them
  --       -- with blink.compat
  --       compat = {},
  --       default = { "lsp", "path", "snippets", "buffer" },
  --       cmdline = {},
  --     },
  --
  --     keymap = {
  --       preset = "enter",
  --       ["<C-y>"] = { "select_and_accept" },
  --     },
  --   },
  --   ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  --   config = function(_, opts)
  --     -- setup compat sources
  --     local enabled = opts.sources.default
  --     for _, source in ipairs(opts.sources.compat or {}) do
  --       opts.sources.providers[source] = vim.tbl_deep_extend(
  --         "force",
  --         { name = source, module = "blink.compat.source" },
  --         opts.sources.providers[source] or {}
  --       )
  --       if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
  --         table.insert(enabled, source)
  --       end
  --     end
  --
  --     -- add ai_accept to <Tab> key
  --     if not opts.keymap["<Tab>"] then
  --       if opts.keymap.preset == "super-tab" then -- super-tab
  --         opts.keymap["<Tab>"] = {
  --           require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
  --           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
  --           "fallback",
  --         }
  --       else -- other presets
  --         opts.keymap["<Tab>"] = {
  --           LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
  --           "fallback",
  --         }
  --       end
  --     end
  --
  --     -- Unset custom prop to pass blink.cmp validation
  --     opts.sources.compat = nil
  --
  --     -- check if we need to override symbol kinds
  --     for _, provider in pairs(opts.sources.providers or {}) do
  --       ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
  --       if provider.kind then
  --         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
  --         local kind_idx = #CompletionItemKind + 1
  --
  --         CompletionItemKind[kind_idx] = provider.kind
  --         ---@diagnostic disable-next-line: no-unknown
  --         CompletionItemKind[provider.kind] = kind_idx
  --
  --         ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
  --         local transform_items = provider.transform_items
  --         ---@param ctx blink.cmp.Context
  --         ---@param items blink.cmp.CompletionItem[]
  --         provider.transform_items = function(ctx, items)
  --           items = transform_items and transform_items(ctx, items) or items
  --           for _, item in ipairs(items) do
  --             item.kind = kind_idx or item.kind
  --           end
  --           return items
  --         end
  --
  --         -- Unset custom prop to pass blink.cmp validation
  --         provider.kind = nil
  --       end
  --     end
  --
  --     require("blink.cmp").setup(opts)
  --   end,
  -- },
  {
    "saghen/blink.compat",
    optional = true,
  },
  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      require("noice").setup({
        presets = { inc_rename = true },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  { "jpalardy/vim-slime" },
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        fish = { "fish" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        -- ["*"] = { "typos" },
        markdown = { "markdownlint-cli2" },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      local M = {}

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            LazyVim.warn("Linter not found: " .. name, { title = "nvim-lint" })
          end
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
  -- AI completion
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "giuxtaposition/blink-cmp-copilot",
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
      },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },
    },
  },
  -- navbuddy and navic
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      {
        "LazyVim/LazyVim",
      },
    },
    lazy = true,
    init = function()
      require("lazyvim.config")
      vim.g.navic_silence = true
      LazyVim.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 4,
        -- icons = LazyVim.config.icons.kinds,
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = " ",
          Interface = " ",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = " ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
        lazy_update_context = true,
      }
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     {
  --       "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
  --       opts = {},
  --     },
  --     "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
  --     { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  --     {
  --       "Saghen/blink.cmp",
  --       opts = {
  --         sources = {
  --           default = { "codecompanion" },
  --           providers = {
  --             codecompanion = {
  --               name = "CodeCompanion",
  --               module = "codecompanion.providers.completion.blink",
  --               enabled = true,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "anthropic",
  --         },
  --         inline = {
  --           adapter = "anthropic",
  --         },
  --         agent = {
  --           adapter = "anthropic",
  --         },
  --       },
  --     })
  --     vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("n", "<leader>at", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("v", "<leader>at", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
  --     vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
  --
  --     -- Expand 'cc' into 'CodeCompanion' in the command line
  --     vim.cmd([[cab cc CodeCompanion]])
  --   end,
  -- },
}
