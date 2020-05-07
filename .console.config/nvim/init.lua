-- General settings
--vim.opt.number = true
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.history = 2000
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.timeout = true
vim.opt.ttimeoutlen = 100
vim.opt.timeoutlen = 5000
vim.opt.completeopt:remove("preview")
vim.opt.completeopt:append("menuone,noselect")
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.termguicolors = true

-- Leader key
vim.g.mapleader = ","

-- Copilot mappings
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-E>", 'copilot#AcceptLine("<CR>")', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-F>", 'copilot#AcceptWord("<CR>")', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Next()', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Dismiss()', { expr = true, silent = true })

-- CopilotChat toggle and layout toggle
vim.api.nvim_set_keymap("n", "<leader>cc", ":CopilotChatToggle<CR>", { silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<leader>bn", ":bnext<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>bp", ":bprev<CR>", { silent = true })

-- Configure clipboard to use custom pbcopy script
vim.g.clipboard = {
  name = "pbcopy-custom",
  copy = {
    ["+"] = { "sh", "-c", "cat | ~/.shell-scripts/scripts/pbcopy.sh" },
    ["*"] = { "sh", "-c", "cat | ~/.shell-scripts/scripts/pbcopy.sh" },
  },
  paste = {
    ["+"] = "echo",
    ["*"] = "echo",
  },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Put this in some Lua config file that runs (e.g. in coc.lua config() or init.lua)
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    -- Close Coc floating windows (diagnostics, hover, signature, etc.)
    pcall(vim.cmd, "silent! pclose")
  end,
})

-- FZF settings
vim.g.fzf_preview_window = "right:50%"
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
vim.api.nvim_create_user_command("B", "Buffers <args>", { nargs = "*" })

-- Key mappings for completion and suggestions (fixed Enter behavior)
vim.api.nvim_set_keymap("i", "<Tab>", 'coc#pum#visible() ? coc#_select_confirm() : "<Tab>"', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', { expr = true, silent = true })
--vim.api.nvim_set_keymap("i", "<C-[>", "<Esc>", { silent = true })

-- Associate .tfvars files with terraform-vars filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tfvars",
  command = "set filetype=terraform-vars",
})

vim.keymap.set('n', '<leader>ln', function()
  if vim.wo.number then
    vim.wo.number = false
    --vim.wo.relativenumber = false
  else
    vim.wo.number = true
    --vim.wo.relativenumber = true
  end
end, { desc = "Toggle line numbers" })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("setlocal nocursorline nonumber norelativenumber")
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- Reset background
    vim.cmd("hi Terminal guibg=NONE ctermbg=NONE") -- Ensure terminal matches
  end,
})

-- Function to toggle terminal split
local terminal_buf = nil
local terminal_win = nil

function ToggleTerminalSplit()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    -- Close the terminal if it's open
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
  else
    -- Open a terminal split with 20% height
    vim.cmd("botright 10split")
    terminal_win = vim.api.nvim_get_current_win()

    if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
      -- Create terminal in the current window
      vim.cmd("terminal")
      terminal_buf = vim.api.nvim_get_current_buf()
    else
      -- Reuse existing terminal buffer
      vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
    end

    -- Enter insert mode in terminal
    --vim.cmd("startinsert")
  end
end

-- Key mapping to toggle terminal split
vim.keymap.set("n", "<leader>tt", ToggleTerminalSplit, { desc = "Toggle terminal split" })

-- Function to toggle both CopilotChat and terminal split
function ToggleFullSidebar()
  local copilot_chat_open = false
  local terminal_open = terminal_win and vim.api.nvim_win_is_valid(terminal_win)

  -- Check if CopilotChat is open (this might need adjustment based on how CopilotChat tracks its state)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if string.match(buf_name, "copilot%-chat") then
      copilot_chat_open = true
      break
    end
  end

  if copilot_chat_open or terminal_open then
    -- Close both if either is open
    vim.cmd("CopilotChatClose")
    if terminal_open then
      vim.api.nvim_win_close(terminal_win, true)
      terminal_win = nil
    end
  else
    -- Open both
    vim.cmd("CopilotChatToggle")
    ToggleTerminalSplit()
  end
end

-- Key mapping to toggle full sidebar (CopilotChat + terminal)
vim.keymap.set("n", "<leader>fs", ToggleFullSidebar, { desc = "Toggle full sidebar (CopilotChat + terminal)" })

-- Include user lua
local user = os.getenv("USER") or os.getenv("USERNAME")
if user then
  local fn = vim.fn.stdpath("config") .. "/init-" .. user .. ".lua"
  if vim.fn.filereadable(fn) == 1 then
    dofile(fn)
  end
end
