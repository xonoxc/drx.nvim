local colors = require("drxvim.themes").getCurrentTheme()

return {
	DiagnosticError = { fg = colors.red, italic = false, bold = true },
	DiagnosticWarn = { fg = colors.yellow, italic = false, bold = true },
	DiagnosticInfo = { fg = colors.blue, italic = false, bold = true },
	DiagnosticHint = { fg = colors.purple, italic = false, bold = true },
	DiagnosticInformation = { fg = colors.green, italic = false, bold = true },
	LspInlayHint = { fg = colors.grey_fg, bg = colors.black2 },
}
