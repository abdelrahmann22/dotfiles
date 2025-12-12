# NvChad to LazyVim Migration

Your Neovim configuration has been converted from NvChad to LazyVim.

## What Changed

### Core Configuration

1. **init.lua** - Completely rewritten to bootstrap LazyVim instead of NvChad
2. **options.lua** - Replaced `require "nvchad.options"` with LazyVim-compatible options
3. **mappings.lua** - Removed `require "nvchad.mappings"` (LazyVim provides defaults)
4. **chadrc.lua** - Deleted (NvChad-specific)

### Plugins

All your existing plugins in `lua/plugins/init.lua` are preserved and will work with LazyVim:
- vimwiki
- image.nvim
- conform.nvim
- render-markdown.nvim
- CopilotChat.nvim
- neogen
- nvim-tree
- pastify.nvim
- glow.nvim
- markdown-preview
- vim-tmux-navigator
- vim-fugitive
- mason.nvim
- nvim-dap (Python debugging)
- All other plugins

### Colorscheme

Your matugen colorscheme is now the default and will auto-reload when wallpapers change.

## First Time Setup

### 1. Clean up NvChad data
```bash
# Backup first (optional)
mv ~/.local/share/nvim ~/.local/share/nvim.nvchad.backup

# Or just remove NvChad cache
rm -rf ~/.local/share/nvim/nvchad
rm -rf ~/.cache/nvim/nvchad
```

### 2. Launch Neovim
```bash
nvim
```

LazyVim will:
- Install itself automatically
- Install all your plugins
- Apply the matugen colorscheme

### 3. Wait for plugins to install
The first launch will take a few minutes as Lazy.nvim downloads and installs everything.

## Key Differences

### LazyVim Provides

LazyVim comes with sensible defaults and many pre-configured plugins:

- **Which-key** - Shows keybindings
- **Telescope** - Fuzzy finder (already had this)
- **nvim-cmp** - Autocompletion (already had this)
- **nvim-lspconfig** - LSP support (already had this)
- **Trouble** - Diagnostics viewer
- **Mini.nvim** - Collection of utilities
- **Noice** - Better UI for messages
- **Dashboard** - Start screen

### Default Keybindings

LazyVim uses `<leader>` as space (same as before). Key bindings:

- `<leader>l` - LazyVim/Lazy plugin manager
- `<leader>f` - Find (Telescope)
  - `<leader>ff` - Find files
  - `<leader>fg` - Find with grep
  - `<leader>fb` - Find buffers
- `<leader>e` - File explorer
- `<leader>x` - Diagnostics/trouble
- `<leader>c` - Code actions
- `<leader>s` - Search
- `<leader>u` - UI toggles

Press `<leader>` and wait to see all keybindings in which-key.

### Your Custom Keybindings

All your custom mappings in `mappings.lua` are preserved:
- `;` - Command mode
- `<leader>fm` - Format with conform
- `jk` - Escape insert mode
- `<C-h/j/k/l>` - Tmux navigation
- `<C-Left/Right>` - Word navigation
- `<A-j/k>` - Move lines
- `<leader>z*` - Copilot Chat commands
- `<leader>db` - DAP breakpoint
- `<A-n>` - Neogen docstrings

## Matugen Colorscheme Auto-Reload

The matugen colorscheme will automatically reload when you:
1. Change wallpapers in waypaper
2. Edit the colorscheme file directly

No manual intervention needed!

## Troubleshooting

### Colorscheme not found on first launch
```vim
:colorscheme tokyonight
```
Then select a wallpaper to generate matugen colors.

### Plugins not loading
```vim
:Lazy
```
Check for errors and press `I` to install missing plugins.

### LSP not working
```vim
:Mason
```
Install language servers as needed.

### Want to see what LazyVim provides
```vim
:LazyVim
```

### Revert to NvChad
```bash
# Restore backup
rm -rf ~/.local/share/nvim
mv ~/.local/share/nvim.nvchad.backup ~/.local/share/nvim

# Revert git changes
cd ~/.config
git restore nvim/
```

## Benefits of LazyVim

1. **Better defaults** - Sensible configuration out of the box
2. **Modular** - Easy to enable/disable features
3. **Well-maintained** - Active development
4. **Great documentation** - https://www.lazyvim.org
5. **Extensible** - Easy to add custom plugins
6. **Fast** - Lazy loading by default

## Next Steps

1. Launch Neovim and let plugins install
2. Explore with `<leader>` to see keybindings
3. Read LazyVim docs: https://www.lazyvim.org
4. Test wallpaper changes to verify matugen auto-reload
5. Customize further in `lua/plugins/` as needed

Enjoy your new LazyVim setup!

