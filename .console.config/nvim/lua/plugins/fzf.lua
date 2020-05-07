return {
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end
  },
  {
    "junegunn/fzf.vim",
    config = function()
      -- Place additional fzf configuration here, if needed
      -- Example: Customize fzf layout
      vim.g.fzf_layout = { down = '~40%' }
    end
  }
}
