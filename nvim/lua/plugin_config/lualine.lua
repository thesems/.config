-- return {
--     "nvim-lualine/lualine.nvim",
--     config = function()
--         require('lualine').setup({
--             options = {
--                 icons_enabled = false,
--                 section_separators = '',
--                 component_separators = ''
--             }
--         })
--     end
-- }
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    }
  }
}
