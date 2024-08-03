-- Description -----------------------------------------------------------------------------
--
-- Integration with neogit.
--
-- -----------------------------------------------------------------------------------------

local M = {}

function M.get()
  local c = require("nano-theme.colors").get()

  return {
    NeogitCommitViewHeader    = { fg = c.fg, bg = c.nano_subtle_color, bold = true },
    NeogitDiffAdd             = { fg = c.nano_salient_color, bold = true },
    NeogitDiffAddHighlight    = { link = "NeogitDiffAdd" },
    NeogitDiffDelete          = { fg = c.nano_popout_color, bold = true },
    NeogitDiffDeleteHighlight = { link = "NeogitDiffDelete" },
    NeogitHunkHeader          = { fg = c.fg, bg = c.nano_highlight_color },
    NeogitHunkHeaderHighlight = { fg = c.fg, bg = c.nano_subtle_color, bold = true },
  }
end

return M
