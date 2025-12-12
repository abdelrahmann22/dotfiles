-- Conform.nvim configuration for LazyVim
-- LazyVim handles format_on_save automatically, so we only define formatters

local options = {
  formatters_by_ft = {
    python = { "isort", "black" },
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    sass = { "prettier" },
    html = { "prettier" },
  },

  -- LazyVim will handle format_on_save automatically
  -- Don't set it here to avoid conflicts
}

return options
