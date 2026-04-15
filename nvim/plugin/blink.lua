vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp" },
})

local blink = require("blink.cmp")

blink.setup({
  keymap = {
    preset = "default",
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
})
