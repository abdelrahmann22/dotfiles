--[[
┌──────────────────────────────────┐
│                                  │
│     ░█░░░█▀█░▀▀█░█░█░█░█░▀█▀░█▄█ │
│     ░█░░░█▀█░▄▀░░░█░░▀▄▀░░█░░█░█ │
│     ░▀▀▀░▀░▀░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀ │
│                                  │
└──────────────────────────────────┘
]]

-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load options first
require("options")

-- Setup lazy.nvim with LazyVim
require("lazy").setup({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "matugen",
      -- Disable default colorschemes
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },

  -- Import custom plugins
  { import = "plugins" },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "matugen", "tokyonight", "habamax" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load mappings
vim.schedule(function()
  pcall(require, "mappings")
end)

-- Setup matugen colorscheme auto-reload
local autocmd = vim.api.nvim_create_autocmd

autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    vim.cmd("colorscheme matugen")
    vim.cmd("redraw!")
  end,
  desc = "Reload matugen colorscheme on wallpaper change",
})

-- Auto-reload colorscheme when file changes
autocmd("BufWritePost", {
  pattern = "*/colors/matugen.lua",
  callback = function()
    vim.cmd("colorscheme matugen")
    vim.cmd("redraw!")
  end,
  desc = "Auto-reload matugen colorscheme on file save",
})

-- Apply colorscheme
vim.cmd.colorscheme("matugen")
