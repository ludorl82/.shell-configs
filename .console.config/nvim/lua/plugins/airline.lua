return {
  {
    "vim-airline/vim-airline",
    lazy = false, -- Ensure it loads immediately
    config = function()
      -- You can add airline-specific configuration here
      -- For example, enable powerline fonts:
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_symbols = vim.g.airline_symbols or {}
      vim.g.airline_symbols.branch = ""
      vim.g.airline_symbols.readonly = ""
      vim.g.airline_symbols.linenr = ""
      vim.g.airline_left_sep = ""
      vim.g.airline_left_alt_sep = ""
      vim.g.airline_right_sep = ""
      vim.g.airline_right_alt_sep = ""
      vim.g.airline_extensions_tabline_enabled = 1
      vim.g.airline_extensions = { "tabline" }
      vim.g.airline_tabline_formatter = "unique_tail" -- Show unique buffer names

      -- You can also modify themes, sections, and other settings:
      --vim.g.airline_theme = 'solarized' -- Set a default theme
    end
  },
}
