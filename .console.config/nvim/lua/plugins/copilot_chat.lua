return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    tag = "v4.7.4",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
      -- default to claude-sonnet-4
      model = "gpt-4o",
      --model = "claude-sonnet-4.5",
      window = {
        layout = 'vertical',
        width = 0.3,
        height = 1,
        border = 'rounded',
        title = '🤖 AI Assistant',
      },

      headers = {
        user = '👤 Ludo: ',
        assistant = '🤖 Copilot: ',
        tool = '🔧 Tool: ',
      },
      separator = '━━',
      show_folds = false, -- Disable folding for cleaner look
    },
  },
}
