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
  bg = "{{colors.background.default.hex}}",
  bg_dark = "{{colors.surface.default.hex}}",
  bg_float = "{{colors.surface_container.default.hex}}",
  bg_highlight = "{{colors.surface_bright.default.hex}}",
  bg_popup = "{{colors.surface_container.default.hex}}",
  bg_search = "{{colors.primary_container.default.hex}}",
  bg_sidebar = "{{colors.surface_container_low.default.hex}}",
  bg_statusline = "{{colors.surface_container.default.hex}}",
  bg_visual = "{{colors.secondary_container.default.hex}}",
  
  fg = "{{colors.on_background.default.hex}}",
  fg_dark = "{{colors.on_surface_variant.default.hex}}",
  fg_float = "{{colors.on_surface.default.hex}}",
  fg_gutter = "{{colors.outline.default.hex}}",
  fg_sidebar = "{{colors.on_surface.default.hex}}",
  
  border = "{{colors.outline.default.hex}}",
  border_highlight = "{{colors.primary.default.hex}}",
  
  black = "{{colors.surface_dim.default.hex}}",
  blue = "{{colors.blue.default.hex}}",
  blue0 = "{{colors.primary.default.hex}}",
  blue1 = "{{colors.primary_container.default.hex}}",
  blue2 = "{{colors.secondary.default.hex}}",
  blue5 = "{{colors.tertiary.default.hex}}",
  blue6 = "{{colors.tertiary_container.default.hex}}",
  blue7 = "{{colors.secondary_container.default.hex}}",
  
  comment = "{{colors.outline.default.hex}}",
  
  cyan = "{{colors.cyan.default.hex}}",
  
  dark3 = "{{colors.surface_variant.default.hex}}",
  dark5 = "{{colors.outline_variant.default.hex}}",
  
  green = "{{colors.green.default.hex}}",
  green1 = "{{colors.tertiary.default.hex}}",
  green2 = "{{colors.tertiary_container.default.hex}}",
  
  magenta = "{{colors.magenta.default.hex}}",
  magenta2 = "{{colors.tertiary.default.hex}}",
  
  orange = "{{colors.yellow.default.hex}}",
  purple = "{{colors.magenta.default.hex}}",
  
  red = "{{colors.red.default.hex}}",
  red1 = "{{colors.error.default.hex}}",
  
  teal = "{{colors.secondary.default.hex}}",
  
  terminal_black = "{{colors.surface.default.hex}}",
  
  yellow = "{{colors.yellow.default.hex}}",
  
  git = {
    add = "{{colors.green.default.hex}}",
    change = "{{colors.yellow.default.hex}}",
    delete = "{{colors.red.default.hex}}",
  },
  
  gitSigns = {
    add = "{{colors.green.default.hex}}",
    change = "{{colors.yellow.default.hex}}",
    delete = "{{colors.red.default.hex}}",
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

