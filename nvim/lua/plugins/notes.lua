return {
  {
    "nilszeilon/lumen.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("lumen").setup({
        -- Optional: override default config
        journal_dir = vim.fn.expand("~/notes"),
        db_name = "lumen.db",
        anthropic_api_key = os.getenv("ANTHROPIC_API_KEY"),
        model = "claude-3-5-sonnet-20241022",
      })
      -- In your init.lua or other config file
      vim.keymap.set("n", "<leader>jn", require("lumen").create_journal_entry, { desc = "Create new journal entry" })
      vim.keymap.set("n", "<leader>jd", require("lumen").show_db_info, { desc = "Show journal database info" })
      vim.keymap.set(
        "n",
        "<leader>ja",
        require("lumen").analyze_journal_entry,
        { desc = "Analyze current journal entry" }
      )
    end,
  },
  {
    "vimwiki/vimwiki",
    init = function()
      -- Define the diary template
      local diary_template = [[# %title%


]]

      -- Use Markdown syntax
      vim.g.vimwiki_list = {
        {
          path = "~/notes",
          syntax = "markdown",
          ext = ".md",
          diary_rel_path = "diary/",
        },
      }
      -- Make sure vimwiki doesn't own all .md files
      vim.g.vimwiki_global_ext = 0
      -- Register markdown as the parser for vimwiki files (for treesitter support)
      vim.treesitter.language.register("markdown", "vimwiki")

      -- Auto-apply template to new diary files
      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = vim.fn.expand("*/notes/diary/*.md"),
        callback = function()
          local filename = vim.fn.expand("%:t:r") -- Get filename without extension
          local content = diary_template:gsub("%%title%%", filename)
          local lines = vim.split(content, "\n")
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
          -- Position cursor after the Tasks header
          vim.cmd("normal! 4G$")
        end,
      })
    end,
  },
}
