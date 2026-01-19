require("config.lazy")
require("keymaps")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- disable copilot suggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_enabled = false
