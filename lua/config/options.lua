vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ambiwidth = "single"
vim.opt.list = false
vim.opt.clipboard = "unnamedplus"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.colorcolumn = "88"
vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
vim.diagnostic.config({ virtual_text = true, severity_sort = true})
vim.keymap.set("n", "<leader>t", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("botright 12split | lcd " .. dir .. " | terminal")
end)

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.list = false
    vim.cmd("startinsert")
  end,
})

-- recordar todo el workspace antes de cerrarlo.
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
}

