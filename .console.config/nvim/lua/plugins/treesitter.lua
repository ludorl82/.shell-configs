return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers after installation
    config = function()
      require'nvim-treesitter.config'.setup {
        ensure_installed = { "yaml", "lua", "python", "bash", "json", "markdown", "terraform" }, -- List of languages to install parsers for
        highlight = {
          enable = true, -- Enable syntax highlighting
        },
        indent = {
          enable = true, -- Enable indentation based on Treesitter
        },
      }
    end,
  },
}
