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
    -- Use Markdown syntax
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki",
        syntax = "markdown",
        ext = ".md",
      },
    }
    -- Make sure vimwiki doesn't own all .md files
    vim.g.vimwiki_global_ext = 0
    -- Register markdown as the parser for vimwiki files (for treesitter support)
    vim.treesitter.language.register("markdown", "vimwiki")
  end,
}
