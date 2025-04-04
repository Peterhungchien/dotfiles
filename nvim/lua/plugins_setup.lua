vim.g.have_nerd_font = true
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
    signature = {
      auto_open = {
        enabled = false,
      },
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

require("lualine").setup()

require("flash").toggle(true)
require("telescope").load_extension("zoxide")
-- disable matchparen in favor of match-up
vim.cmd([[
let g:matchup_override_vimtex = 1
let g:matchup_matchparen_enabled = 0
let g:vimtex_matchparen_enabled = 0
let loaded_matchparen = 1
let g:loaded_matchit = 1
]])

--set kitty as vim-slime target
vim.cmd('let g:slime_target = "kitty"')
vim.cmd('let g:slime_default_config = {"listen_on": $KITTY_LISTEN_ON}')

vim.treesitter.language.register("markdown", "rmd")
