-- LazyVim LSP configuration
return {
  servers = {
    html = {},
    cssls = {},
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    },
    qmlls = {
      cmd = { "qmlls6" },
    },
  },
}
