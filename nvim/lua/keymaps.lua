local wk = require("which-key")
-- register keymap groups
wk.add({
  { "<leader>a", group = "ai" },
  { "<leader>g", group = "git" },
  { "<leader>u", group = "Disable" },
  { "<leader>c", group = "code" },
  { "<leader>x", group = "diagnostics/quickfix" },
})

-- search group keymaps
wk.add({
  { "<leader>s", group = "search" },
})

vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "search buffers" })

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- open new terminal pane in wezterm
local function get_current_workspace_dir()
  local workspace_dir = require("workspaces").path()
  if not workspace_dir then
    -- fallback to the directory of current buffer
    return vim.fn.expand("%:p:h")
  else
    return workspace_dir
  end
end
local function wezterm_new_pane(cmd, dir)
  if not cmd then
    cmd = ""
  else
    cmd = string.format("-- %s", cmd)
  end
  os.execute(string.format("wezterm cli split-pane --horizontal --cwd=%s %s", dir, cmd))
end
local function create_wezterm_pane_func(cmd, use_conda_env)
  return function()
    wezterm_new_pane(cmd, vim.fn.getcwd())
  end
end
-- open a new shell
local new_shell_pane = create_wezterm_pane_func()
local new_R_pane = create_wezterm_pane_func("radian")
local new_Python_pane = create_wezterm_pane_func("python")
local new_Julia_pane = create_wezterm_pane_func("julia --project")
local new_IPython_pane = create_wezterm_pane_func("ipython")
wk.add({
  { "<leader>t", group = "terminal" },
  { "<leader>ts", new_shell_pane, desc = "new shell pane" },
  { "<leader>tp", new_Python_pane, desc = "new Python pane" },
  { "<leader>tr", new_R_pane, desc = "new R pane" },
  { "<leader>tj", new_Julia_pane, desc = "new Julia pane" },
  { "<leader>ti", new_IPython_pane, desc = "new IPython pane" },
})

vim.keymap.set("n", "<leader>cn", "<cmd>Navbuddy<cr>")

-- split window
vim.keymap.set("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "split window vertically" })
vim.keymap.set("n", "<leader>-", "<cmd>split<cr>", { desc = "split window horizontally" })

-- Treewalker keymaps
vim.api.nvim_set_keymap("n", "<TAB>j", ":Treewalker Down<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<TAB>k", ":Treewalker Up<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<TAB>h", ":Treewalker Left<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<TAB>l", ":Treewalker Right<CR>", { noremap = true })

-- oil toggle detail view
local detail = false
require("oil").setup({
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({ "icon" })
        end
      end,
    },
  },
})
