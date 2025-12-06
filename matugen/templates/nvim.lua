-- Matugen colorscheme for Neovim
-- Auto-generated from wallpaper

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "matugen"

local colors = {
  bg = "#{{colors.surface.default.hex_stripped}}",
  bg_alt = "#{{colors.surface_container.default.hex_stripped}}",
  bg_highlight = "#{{colors.surface_container_high.default.hex_stripped}}",
  fg = "#{{colors.on_surface.default.hex_stripped}}",
  fg_muted = "#{{colors.outline.default.hex_stripped}}",
  primary = "#{{colors.primary.default.hex_stripped}}",
  secondary = "#{{colors.secondary.default.hex_stripped}}",
  tertiary = "#{{colors.tertiary.default.hex_stripped}}",
  error = "#{{colors.error.default.hex_stripped}}",
  warning = "#{{colors.tertiary_container.default.hex_stripped}}",
  info = "#{{colors.secondary_container.default.hex_stripped}}",
  hint = "#{{colors.primary_container.default.hex_stripped}}",
  border = "#{{colors.outline_variant.default.hex_stripped}}",
  selection = "#{{colors.surface_container_highest.default.hex_stripped}}",
  comment = "#{{colors.outline.default.hex_stripped}}",
  -- Syntax colors mapped to material colors
  red = "#{{colors.error.default.hex_stripped}}",
  green = "#{{colors.tertiary.default.hex_stripped}}",
  yellow = "#{{colors.secondary.default.hex_stripped}}",
  blue = "#{{colors.primary.default.hex_stripped}}",
  purple = "#{{colors.tertiary.default.hex_stripped}}",
  cyan = "#{{colors.secondary.default.hex_stripped}}",
  orange = "#{{colors.tertiary_container.default.hex_stripped}}",
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor
hi("Normal", { fg = colors.fg, bg = colors.bg })
hi("NormalFloat", { fg = colors.fg, bg = colors.bg_alt })
hi("FloatBorder", { fg = colors.border, bg = colors.bg_alt })
hi("ColorColumn", { bg = colors.bg_alt })
hi("Cursor", { fg = colors.bg, bg = colors.fg })
hi("CursorLine", { bg = colors.bg_alt })
hi("CursorLineNr", { fg = colors.primary, bold = true })
hi("LineNr", { fg = colors.fg_muted })
hi("SignColumn", { bg = colors.bg })
hi("VertSplit", { fg = colors.border })
hi("WinSeparator", { fg = colors.border })
hi("Folded", { fg = colors.comment, bg = colors.bg_alt })
hi("FoldColumn", { fg = colors.comment })
hi("NonText", { fg = colors.fg_muted })
hi("SpecialKey", { fg = colors.fg_muted })
hi("Search", { fg = colors.bg, bg = colors.primary })
hi("IncSearch", { fg = colors.bg, bg = colors.secondary })
hi("CurSearch", { fg = colors.bg, bg = colors.primary })
hi("Visual", { bg = colors.selection })
hi("VisualNOS", { bg = colors.selection })
hi("Pmenu", { fg = colors.fg, bg = colors.bg_alt })
hi("PmenuSel", { fg = colors.bg, bg = colors.primary })
hi("PmenuSbar", { bg = colors.bg_alt })
hi("PmenuThumb", { bg = colors.fg_muted })
hi("StatusLine", { fg = colors.fg, bg = colors.bg_alt })
hi("StatusLineNC", { fg = colors.fg_muted, bg = colors.bg_alt })
hi("TabLine", { fg = colors.fg_muted, bg = colors.bg_alt })
hi("TabLineFill", { bg = colors.bg })
hi("TabLineSel", { fg = colors.fg, bg = colors.bg })
hi("WildMenu", { fg = colors.bg, bg = colors.primary })
hi("MatchParen", { fg = colors.primary, bold = true })
hi("Directory", { fg = colors.primary })
hi("Title", { fg = colors.primary, bold = true })
hi("ErrorMsg", { fg = colors.error })
hi("WarningMsg", { fg = colors.warning })
hi("ModeMsg", { fg = colors.fg, bold = true })
hi("MoreMsg", { fg = colors.primary })
hi("Question", { fg = colors.primary })

-- Syntax
hi("Comment", { fg = colors.comment, italic = true })
hi("Constant", { fg = colors.secondary })
hi("String", { fg = colors.green })
hi("Character", { fg = colors.green })
hi("Number", { fg = colors.orange })
hi("Boolean", { fg = colors.orange })
hi("Float", { fg = colors.orange })
hi("Identifier", { fg = colors.fg })
hi("Function", { fg = colors.blue })
hi("Statement", { fg = colors.purple })
hi("Conditional", { fg = colors.purple })
hi("Repeat", { fg = colors.purple })
hi("Label", { fg = colors.cyan })
hi("Operator", { fg = colors.fg })
hi("Keyword", { fg = colors.purple })
hi("Exception", { fg = colors.purple })
hi("PreProc", { fg = colors.cyan })
hi("Include", { fg = colors.purple })
hi("Define", { fg = colors.purple })
hi("Macro", { fg = colors.cyan })
hi("PreCondit", { fg = colors.cyan })
hi("Type", { fg = colors.yellow })
hi("StorageClass", { fg = colors.yellow })
hi("Structure", { fg = colors.yellow })
hi("Typedef", { fg = colors.yellow })
hi("Special", { fg = colors.cyan })
hi("SpecialChar", { fg = colors.cyan })
hi("Tag", { fg = colors.primary })
hi("Delimiter", { fg = colors.fg })
hi("SpecialComment", { fg = colors.comment })
hi("Debug", { fg = colors.red })
hi("Underlined", { underline = true })
hi("Ignore", { fg = colors.fg_muted })
hi("Error", { fg = colors.error })
hi("Todo", { fg = colors.bg, bg = colors.primary, bold = true })

-- Diff
hi("DiffAdd", { bg = "#{{colors.tertiary.default.hex_stripped}}22" })
hi("DiffChange", { bg = "#{{colors.secondary.default.hex_stripped}}22" })
hi("DiffDelete", { fg = colors.error, bg = "#{{colors.error.default.hex_stripped}}22" })
hi("DiffText", { bg = "#{{colors.secondary.default.hex_stripped}}44" })

-- Diagnostics
hi("DiagnosticError", { fg = colors.error })
hi("DiagnosticWarn", { fg = colors.warning })
hi("DiagnosticInfo", { fg = colors.info })
hi("DiagnosticHint", { fg = colors.hint })
hi("DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warning })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.info })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = colors.hint })

-- LSP
hi("LspReferenceText", { bg = colors.selection })
hi("LspReferenceRead", { bg = colors.selection })
hi("LspReferenceWrite", { bg = colors.selection })

-- Treesitter
hi("@variable", { fg = colors.fg })
hi("@variable.builtin", { fg = colors.red })
hi("@variable.parameter", { fg = colors.fg })
hi("@variable.member", { fg = colors.fg })
hi("@constant", { fg = colors.secondary })
hi("@constant.builtin", { fg = colors.orange })
hi("@constant.macro", { fg = colors.cyan })
hi("@module", { fg = colors.fg })
hi("@label", { fg = colors.cyan })
hi("@string", { fg = colors.green })
hi("@string.escape", { fg = colors.cyan })
hi("@string.special", { fg = colors.cyan })
hi("@character", { fg = colors.green })
hi("@number", { fg = colors.orange })
hi("@boolean", { fg = colors.orange })
hi("@float", { fg = colors.orange })
hi("@function", { fg = colors.blue })
hi("@function.builtin", { fg = colors.cyan })
hi("@function.macro", { fg = colors.cyan })
hi("@function.method", { fg = colors.blue })
hi("@constructor", { fg = colors.yellow })
hi("@keyword", { fg = colors.purple })
hi("@keyword.function", { fg = colors.purple })
hi("@keyword.operator", { fg = colors.purple })
hi("@keyword.return", { fg = colors.purple })
hi("@operator", { fg = colors.fg })
hi("@punctuation.delimiter", { fg = colors.fg })
hi("@punctuation.bracket", { fg = colors.fg })
hi("@punctuation.special", { fg = colors.cyan })
hi("@type", { fg = colors.yellow })
hi("@type.builtin", { fg = colors.yellow })
hi("@type.definition", { fg = colors.yellow })
hi("@attribute", { fg = colors.cyan })
hi("@property", { fg = colors.fg })
hi("@comment", { fg = colors.comment, italic = true })
hi("@tag", { fg = colors.primary })
hi("@tag.attribute", { fg = colors.yellow })
hi("@tag.delimiter", { fg = colors.fg })

-- Git Signs
hi("GitSignsAdd", { fg = colors.green })
hi("GitSignsChange", { fg = colors.yellow })
hi("GitSignsDelete", { fg = colors.red })

-- Telescope
hi("TelescopeBorder", { fg = colors.border })
hi("TelescopePromptBorder", { fg = colors.border })
hi("TelescopeResultsBorder", { fg = colors.border })
hi("TelescopePreviewBorder", { fg = colors.border })
hi("TelescopeSelection", { bg = colors.selection })
hi("TelescopeSelectionCaret", { fg = colors.primary })
hi("TelescopeMatching", { fg = colors.primary, bold = true })

-- NvimTree / Neo-tree
hi("NvimTreeNormal", { fg = colors.fg, bg = colors.bg })
hi("NvimTreeFolderName", { fg = colors.fg })
hi("NvimTreeFolderIcon", { fg = colors.primary })
hi("NvimTreeOpenedFolderName", { fg = colors.primary })
hi("NvimTreeRootFolder", { fg = colors.primary, bold = true })
hi("NvimTreeSpecialFile", { fg = colors.secondary })
hi("NvimTreeGitDirty", { fg = colors.yellow })
hi("NvimTreeGitNew", { fg = colors.green })
hi("NvimTreeGitDeleted", { fg = colors.red })
hi("NeoTreeNormal", { fg = colors.fg, bg = colors.bg })
hi("NeoTreeNormalNC", { fg = colors.fg, bg = colors.bg })

-- Indent Blankline
hi("IndentBlanklineChar", { fg = colors.bg_highlight })
hi("IblIndent", { fg = colors.bg_highlight })
hi("IblScope", { fg = colors.border })

-- Which-key
hi("WhichKey", { fg = colors.primary })
hi("WhichKeyGroup", { fg = colors.secondary })
hi("WhichKeyDesc", { fg = colors.fg })
hi("WhichKeySeparator", { fg = colors.fg_muted })
hi("WhichKeyFloat", { bg = colors.bg_alt })

-- Lazy
hi("LazyButton", { fg = colors.fg, bg = colors.bg_alt })
hi("LazyButtonActive", { fg = colors.bg, bg = colors.primary })
hi("LazyH1", { fg = colors.bg, bg = colors.primary, bold = true })

-- Notify
hi("NotifyERRORBorder", { fg = colors.error })
hi("NotifyWARNBorder", { fg = colors.warning })
hi("NotifyINFOBorder", { fg = colors.info })
hi("NotifyDEBUGBorder", { fg = colors.comment })
hi("NotifyTRACEBorder", { fg = colors.purple })
hi("NotifyERRORIcon", { fg = colors.error })
hi("NotifyWARNIcon", { fg = colors.warning })
hi("NotifyINFOIcon", { fg = colors.info })
hi("NotifyDEBUGIcon", { fg = colors.comment })
hi("NotifyTRACEIcon", { fg = colors.purple })
hi("NotifyERRORTitle", { fg = colors.error })
hi("NotifyWARNTitle", { fg = colors.warning })
hi("NotifyINFOTitle", { fg = colors.info })
hi("NotifyDEBUGTitle", { fg = colors.comment })
hi("NotifyTRACETitle", { fg = colors.purple })

-- Cmp
hi("CmpItemAbbr", { fg = colors.fg })
hi("CmpItemAbbrMatch", { fg = colors.primary, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = colors.primary })
hi("CmpItemKind", { fg = colors.secondary })
hi("CmpItemMenu", { fg = colors.fg_muted })
hi("CmpItemKindFunction", { fg = colors.blue })
hi("CmpItemKindMethod", { fg = colors.blue })
hi("CmpItemKindVariable", { fg = colors.fg })
hi("CmpItemKindKeyword", { fg = colors.purple })
hi("CmpItemKindText", { fg = colors.green })
hi("CmpItemKindSnippet", { fg = colors.cyan })

-- Mini
hi("MiniStatuslineFilename", { fg = colors.fg, bg = colors.bg_alt })
hi("MiniStatuslineFileinfo", { fg = colors.fg_muted, bg = colors.bg_alt })
hi("MiniStatuslineModeNormal", { fg = colors.bg, bg = colors.primary, bold = true })
hi("MiniStatuslineModeInsert", { fg = colors.bg, bg = colors.green, bold = true })
hi("MiniStatuslineModeVisual", { fg = colors.bg, bg = colors.purple, bold = true })
hi("MiniStatuslineModeReplace", { fg = colors.bg, bg = colors.red, bold = true })
hi("MiniStatuslineModeCommand", { fg = colors.bg, bg = colors.yellow, bold = true })
