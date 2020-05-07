return {
  "hashivim/vim-terraform",
  ft = { "terraform" },
  config = function()
    vim.g.terraform_align = 1
    vim.g.terraform_fmt_on_save = 0
  end,
}
