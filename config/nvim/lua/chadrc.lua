---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadwal",
  transparency = false,
  
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  cmp = {
    style = "atom_colored",
  },
  
  statusline = {
    theme = "default",
  },
}

return M
