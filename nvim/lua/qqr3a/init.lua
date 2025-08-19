vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.nu = true
vim.opt.relativenumber = true

require("qqr3a.remap")
require("qqr3a.lazy_init")
vim.cmd.colorscheme("rose-pine")
ColorMyPencils()
