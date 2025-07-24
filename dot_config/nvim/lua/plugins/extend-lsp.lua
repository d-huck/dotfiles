return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        mason = false,
        autostart = false,
      },
      pyright = {
        mason = true,
        autostart = true,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "off",
            },
          },
        },
      },
    },
  },
}
