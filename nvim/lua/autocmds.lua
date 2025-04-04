local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {}) -- A global group for all your config autocommands

-- -- persistent arrow.nvim markers
-- vim.api.nvim_create_autocmd({ "User" }, {
--   pattern = "SessionLoadPost",
--   group = config_group,
--   callback = function()
--     require("arrow.git").refresh_git_branch() -- only if separated_by_branch is true
--     require("arrow.persist").load_cache_file()
--   end,
-- })
--
