vim.pack.add({{ src = "https://github.com/folke/lazydev.nvim"}})

require("lazydev").setup({
  watch = "lua",
  commands = true,
  auto_reload = true,
})
