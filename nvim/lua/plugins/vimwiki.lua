-- [!NOTE]
--   vimwiki <https://github.com/vimwiki/vimwiki> overrides the `filetype` of
--   `markdown` files, as such there are additional setup steps.
--   - Add `vimwiki` to the `file_types` configuration of this plugin
--   >lua
--       require('render-markdown').setup({
--           file_types = { 'markdown', 'vimwiki' },
--       })
--   <
--   - Register `markdown` as the parser for `vimwiki` files
--   >lua
--       vim.treesitter.language.register('markdown', 'vimwiki')
--   <
--
return {
  "vimwiki/vimwiki",
  init = function()
    -- Define the diary template
    local diary_template = [[# %title%

wake up time:  

]]

    -- Use Markdown syntax
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki",
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
      pattern = vim.fn.expand("*/vimwiki/diary/*.md"),
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
}
