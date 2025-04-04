return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        basedpyright = {
          typeCheckingMode = "off",
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
              },
            },
          },
        },
      },
    },
  },
}
