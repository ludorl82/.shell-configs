return {
  {
    "WTFox/jellybeans.nvim",
    config = function()
      vim.cmd("colorscheme jellybeans")

      -- keep comment style
      vim.api.nvim_set_hl(0, 'Comment', { fg = '#888888', bg = 'NONE', italic = false })
      vim.api.nvim_set_hl(0, '@comment', { fg = '#888888', bg = 'NONE', italic = false })

      -- strip code/config backgrounds
      local function strip_code_bg()
        local targets = {
          "@comment", "@punctuation", "@operator", "@keyword", "@keyword.function", "@keyword.return",
          "@keyword.import", "@keyword.type", "@type", "@type.builtin", "@type.definition", "@type.qualifier",
          "@constant", "@constant.builtin", "@constant.macro",
          "@string", "@string.escape", "@string.special",
          "@number", "@float", "@boolean",
          "@variable", "@variable.builtin", "@variable.parameter", "@field", "@property",
          "@function", "@function.builtin", "@function.macro", "@method", "@constructor",
          "@namespace", "@module",
          "@tag", "@tag.attribute", "@tag.delimiter",
          "Comment", "Identifier", "Statement", "Conditional", "Repeat", "Label", "Operator", "Keyword",
          "Exception", "PreProc", "Include", "Define", "Macro", "PreCondit",
          "Type", "StorageClass", "Structure", "Typedef",
          "Constant", "String", "Character", "Number", "Boolean", "Float",
          "Function", "Delimiter", "Special", "SpecialChar", "Tag",
        }

        local function set_no_bg(name)
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
          if not ok then return end
          local new = {}
          if hl.fg then new.fg = string.format('#%06x', hl.fg) end
          new.bg = 'NONE'
          new.underline = false
          new.undercurl = false
          new.bold = false
          new.italic = false
          vim.api.nvim_set_hl(0, name, new)
        end

        for _, name in ipairs(targets) do
          set_no_bg(name)
        end
      end

      -- run now and whenever colorscheme changes
      strip_code_bg()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = strip_code_bg })
    end
  }
}
