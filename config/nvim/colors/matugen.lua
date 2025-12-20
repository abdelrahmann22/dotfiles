-- Matugen colorscheme for LazyVim/Neovim
-- Auto-generated from wallpaper colors

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "matugen"

local M = {}

M.colors = {
  -- Base colors
  bg = "#121414",
  bg_dark = "#121414",
  bg_float = "#1f2020",
  bg_highlight = "#383939",
  bg_popup = "#1f2020",
  bg_search = "#394a4c",
  bg_sidebar = "#1b1c1c",
  bg_statusline = "#1f2020",
  bg_visual = "#3f484a",
  
  fg = "#e3e2e2",
  fg_dark = "#c7c6c6",
  fg_float = "#e3e2e2",
  fg_gutter = "#919190",
  fg_sidebar = "#e3e2e2",
  
  border = "#919190",
  border_highlight = "#b8cacc",
  
  black = "#121414",
  blue = "#c2c6d6",
  blue0 = "#b8cacc",
  blue1 = "#394a4c",
  blue2 = "#bec8ca",
  blue5 = "#b1cbcf",
  blue6 = "#324b4e",
  blue7 = "#3f484a",
  
  comment = "#919190",
  
  cyan = "#b8cacb",
  
  dark3 = "#464747",
  dark5 = "#464747",
  
  green = "#bbcabc",
  green1 = "#b1cbcf",
  green2 = "#324b4e",
  
  magenta = "#d1c2d2",
  magenta2 = "#b1cbcf",
  
  orange = "#c4c9b1",
  purple = "#d1c2d2",
  
  red = "#dfc0b4",
  red1 = "#ffb4ab",
  
  teal = "#bec8ca",
  
  terminal_black = "#121414",
  
  yellow = "#c4c9b1",
  
  git = {
    add = "#bbcabc",
    change = "#c4c9b1",
    delete = "#dfc0b4",
  },
  
  gitSigns = {
    add = "#bbcabc",
    change = "#c4c9b1",
    delete = "#dfc0b4",
  },
}

-- Apply highlights
local colors = M.colors
local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Setup function
M.setup = function()
  
  -- Editor highlights
  hi("Normal", { fg = colors.fg, bg = colors.bg })
  hi("NormalFloat", { fg = colors.fg_float, bg = colors.bg_float })
  hi("FloatBorder", { fg = colors.border_highlight, bg = colors.bg_float })
  hi("FloatTitle", { fg = colors.border_highlight, bg = colors.bg_float })
  
  hi("Comment", { fg = colors.comment, italic = true })
  hi("Constant", { fg = colors.orange })
  hi("String", { fg = colors.green })
  hi("Character", { fg = colors.green })
  hi("Number", { fg = colors.orange })
  hi("Boolean", { fg = colors.orange })
  hi("Float", { fg = colors.orange })
  
  hi("Identifier", { fg = colors.magenta })
  hi("Function", { fg = colors.blue })
  
  hi("Statement", { fg = colors.magenta })
  hi("Conditional", { fg = colors.magenta })
  hi("Repeat", { fg = colors.magenta })
  hi("Label", { fg = colors.red })
  hi("Operator", { fg = colors.fg_dark })
  hi("Keyword", { fg = colors.cyan })
  hi("Exception", { fg = colors.magenta })
  
  hi("PreProc", { fg = colors.cyan })
  hi("Include", { fg = colors.magenta })
  hi("Define", { fg = colors.magenta })
  hi("Macro", { fg = colors.magenta })
  hi("PreCondit", { fg = colors.cyan })
  
  hi("Type", { fg = colors.blue2 })
  hi("StorageClass", { fg = colors.cyan })
  hi("Structure", { fg = colors.cyan })
  hi("Typedef", { fg = colors.cyan })
  
  hi("Special", { fg = colors.blue })
  hi("SpecialChar", { fg = colors.blue })
  hi("Tag", { fg = colors.blue })
  hi("Delimiter", { fg = colors.blue5 })
  hi("SpecialComment", { fg = colors.comment })
  hi("Debug", { fg = colors.orange })
  
  hi("Underlined", { underline = true })
  hi("Error", { fg = colors.red })
  hi("Todo", { fg = colors.bg, bg = colors.yellow })
  
  hi("LineNr", { fg = colors.fg_gutter })
  hi("CursorLineNr", { fg = colors.blue })
  hi("Visual", { bg = colors.bg_visual })
  hi("VisualNOS", { bg = colors.bg_visual })
  hi("Search", { fg = colors.bg, bg = colors.blue })
  hi("IncSearch", { fg = colors.bg, bg = colors.orange })
  
  hi("Pmenu", { fg = colors.fg, bg = colors.bg_popup })
  hi("PmenuSel", { bg = colors.bg_highlight })
  hi("PmenuSbar", { bg = colors.bg_popup })
  hi("PmenuThumb", { bg = colors.fg_gutter })
  
  hi("StatusLine", { fg = colors.fg_sidebar, bg = colors.bg_statusline })
  hi("StatusLineNC", { fg = colors.fg_gutter, bg = colors.bg_statusline })
  
  hi("TabLine", { fg = colors.fg_gutter, bg = colors.bg_statusline })
  hi("TabLineFill", { bg = colors.black })
  hi("TabLineSel", { fg = colors.blue, bg = colors.bg })
  
  hi("WinSeparator", { fg = colors.border })
  hi("VertSplit", { fg = colors.border })
  
  hi("CursorLine", { bg = colors.bg_highlight })
  hi("ColorColumn", { bg = colors.bg_highlight })
  
  hi("Folded", { fg = colors.blue, bg = colors.bg_highlight })
  hi("FoldColumn", { fg = colors.comment, bg = colors.bg })
  
  hi("DiffAdd", { fg = colors.git.add })
  hi("DiffChange", { fg = colors.git.change })
  hi("DiffDelete", { fg = colors.git.delete })
  hi("DiffText", { fg = colors.blue })
  
  -- TreeSitter highlights
  hi("@variable", { fg = colors.fg })
  hi("@variable.builtin", { fg = colors.red })
  hi("@variable.parameter", { fg = colors.yellow })
  hi("@variable.member", { fg = colors.cyan })
  
  hi("@constant", { fg = colors.orange })
  hi("@constant.builtin", { fg = colors.orange })
  hi("@constant.macro", { fg = colors.orange })
  
  hi("@string", { fg = colors.green })
  hi("@string.escape", { fg = colors.magenta })
  hi("@string.special", { fg = colors.blue })
  
  hi("@character", { fg = colors.green })
  hi("@number", { fg = colors.orange })
  hi("@boolean", { fg = colors.orange })
  hi("@float", { fg = colors.orange })
  
  hi("@function", { fg = colors.blue })
  hi("@function.builtin", { fg = colors.cyan })
  hi("@function.macro", { fg = colors.red })
  hi("@function.call", { fg = colors.blue })
  
  hi("@method", { fg = colors.blue })
  hi("@method.call", { fg = colors.blue })
  
  hi("@constructor", { fg = colors.cyan })
  hi("@parameter", { fg = colors.yellow })
  
  hi("@keyword", { fg = colors.purple })
  hi("@keyword.function", { fg = colors.magenta })
  hi("@keyword.operator", { fg = colors.purple })
  hi("@keyword.return", { fg = colors.magenta })
  
  hi("@conditional", { fg = colors.magenta })
  hi("@repeat", { fg = colors.magenta })
  hi("@label", { fg = colors.red })
  hi("@operator", { fg = colors.fg_dark })
  hi("@exception", { fg = colors.magenta })
  
  hi("@type", { fg = colors.blue2 })
  hi("@type.builtin", { fg = colors.cyan })
  hi("@type.qualifier", { fg = colors.magenta })
  
  hi("@property", { fg = colors.cyan })
  hi("@field", { fg = colors.cyan })
  
  hi("@punctuation.delimiter", { fg = colors.blue5 })
  hi("@punctuation.bracket", { fg = colors.fg_dark })
  hi("@punctuation.special", { fg = colors.blue5 })
  
  hi("@comment", { fg = colors.comment, italic = true })
  
  hi("@tag", { fg = colors.red })
  hi("@tag.attribute", { fg = colors.cyan })
  hi("@tag.delimiter", { fg = colors.blue5 })
  
  -- LSP highlights
  hi("LspReferenceText", { bg = colors.bg_highlight })
  hi("LspReferenceRead", { bg = colors.bg_highlight })
  hi("LspReferenceWrite", { bg = colors.bg_highlight })
  
  hi("DiagnosticError", { fg = colors.red })
  hi("DiagnosticWarn", { fg = colors.yellow })
  hi("DiagnosticInfo", { fg = colors.blue })
  hi("DiagnosticHint", { fg = colors.cyan })
  
  -- Telescope
  hi("TelescopeBorder", { fg = colors.border_highlight, bg = colors.bg_float })
  hi("TelescopeNormal", { fg = colors.fg, bg = colors.bg_float })
  hi("TelescopeSelection", { bg = colors.bg_highlight })
  
  -- Neo-tree / nvim-tree
  hi("NeoTreeNormal", { fg = colors.fg_sidebar, bg = colors.bg_sidebar })
  hi("NeoTreeNormalNC", { fg = colors.fg_sidebar, bg = colors.bg_sidebar })
  hi("NeoTreeDirectoryIcon", { fg = colors.blue })
  hi("NeoTreeDirectoryName", { fg = colors.blue })
  hi("NeoTreeGitModified", { fg = colors.git.change })
  hi("NeoTreeGitAdded", { fg = colors.git.add })
  hi("NeoTreeGitDeleted", { fg = colors.git.delete })
  
  hi("NvimTreeNormal", { fg = colors.fg_sidebar, bg = colors.bg_sidebar })
  hi("NvimTreeFolderIcon", { fg = colors.blue })
  hi("NvimTreeFolderName", { fg = colors.blue })
  hi("NvimTreeOpenedFolderName", { fg = colors.blue, bold = true })
  
  -- LazyVim specific highlights
  hi("LazyNormal", { fg = colors.fg, bg = colors.bg_float })
  hi("LazyButton", { bg = colors.bg_highlight })
  hi("LazyButtonActive", { fg = colors.bg, bg = colors.blue })
  
  -- Which-key
  hi("WhichKey", { fg = colors.cyan })
  hi("WhichKeyGroup", { fg = colors.blue })
  hi("WhichKeyDesc", { fg = colors.magenta })
  hi("WhichKeySeperator", { fg = colors.comment })
  hi("WhichKeyFloat", { bg = colors.bg_float })
  
  -- Noice
  hi("NoicePopup", { fg = colors.fg, bg = colors.bg_float })
  hi("NoiceCmdlinePopup", { fg = colors.fg, bg = colors.bg_float })
  hi("NoiceCmdlinePopupBorder", { fg = colors.border_highlight, bg = colors.bg_float })
end

-- Auto-apply highlights
M.setup()

return M

