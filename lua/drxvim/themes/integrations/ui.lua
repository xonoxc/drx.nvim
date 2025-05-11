local colors = require("drxvim.themes").getCurrentTheme()

return {
	-- Tebufline
	TeBufOnActive = { bg = colors.black, fg = colors.white, bold = true },
	TeBufOnInactive = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufOnModified = { fg = colors.green },
	TeBufOffModified = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufOnClose = { fg = colors.red, bg = colors.black },
	TeBufOffClose = { fg = colors.grey_fg2, bg = colors.statusline_bg },
	TeBufTree = { bg = colors.darker_black },
	TeBufEmpty = { bg = colors.black },
	TeBufEmptyColor = { bg = colors.statusline_bg },
	TeBufCloseButton = { bg = colors.red, fg = colors.black },

	TeBufRun = { bg = colors.one_bg2, fg = colors.yellow },
	TeBufSplit = { bg = colors.one_bg2, fg = colors.blue },
	TeBufTheme = { bg = colors.one_bg2, fg = colors.green },
	TeBufQuit = { bg = colors.red, fg = colors.black },

	-- TeSttLine
	TeSTTNormalMode = { fg = colors.black, bg = colors.blue },
	TeSTTVisualMode = { fg = colors.black, bg = colors.purple },
	TeSTTNeovimIcon = { fg = colors.black, bg = colors.none },
	TeSTTCommandMode = { fg = colors.black, bg = colors.red },
	TeSTTInsertMode = { fg = colors.black, bg = colors.green },
	TeSTTTerminalMode = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalMode = { fg = colors.black, bg = colors.red },
	TeSTTConfirmMode = { fg = colors.black, bg = colors.yellow },
	TeSTTNormalModeIcon = { fg = colors.black, bg = colors.blue },
	TeSTTVisualModeIcon = { fg = colors.black, bg = colors.purple },
	TeSTTCommandModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTInsertModeIcon = { fg = colors.black, bg = colors.green },
	TeSTTTerminalModeIcon = { fg = colors.black, bg = colors.red },
	TeSTTNTerminalModeIcon = { fg = colors.black, bg = colors.red },

	TeSTTConfirmModeIcon = { fg = colors.black, bg = colors.yellow },

	TeSTTFileIcon = { fg = colors.black, bg = colors.red },
	TeSTTFileName = { fg = colors.red, bg = colors.statusline_bg, bold = true },
	TeSTTFolder = { fg = colors.red, bg = colors.one_bg },
	TeSTTModified = { fg = colors.green, bg = colors.one_bg },

	TeSTTNothing = { bg = colors.statusline_bg },
	TeSTTNothing2 = { bg = colors.black },

	TeSTTError = { fg = colors.red, bg = colors.statusline_bg },
	TeSTTErrorIcon = { fg = colors.red, bg = colors.statusline_bg },
	TeSTTWarning = { fg = colors.yellow, bg = colors.statusline_bg },
	TeSTTWarningIcon = { fg = colors.yellow, bg = colors.statusline_bg },
	TeSTTHints = { fg = colors.purple, bg = colors.statusline_bg },
	TeSTTHintsIcon = { fg = colors.purple, bg = colors.statusline_bg },
	TeSTTInfo = { fg = colors.blue, bg = colors.statusline_bg },
	TeSTTInfoIcon = { fg = colors.blue, bg = colors.statusline_bg },

	TeSTTBranchName = { fg = colors.dark_purple, bg = colors.statusline_bg },
	TeSTTBranchIcon = { fg = colors.dark_purple, bg = colors.statusline_bg },
	TeSTTDiffAdd = { fg = colors.green, bg = colors.statusline_bg },
	TeSTTDiffChange = { fg = colors.orange, bg = colors.statusline_bg },
	TeSTTDiffRemove = { fg = colors.red, bg = colors.statusline_bg },
	TeSTTGithub = { fg = colors.blue, bg = colors.statusline_bg },

	TeSTTLsp = { fg = colors.baby_pink, bg = colors.statusline_bg },
	TeSTTLspIcon = { fg = colors.baby_pink, bg = colors.statusline_bg },

	TeSTTTabIcon = { fg = colors.teal, bg = colors.statusline_bg },
	TeSTTTab = { fg = colors.teal, bg = colors.statusline_bg },

	TeSTTProgressIcon = { fg = colors.purple, bg = colors.statusline_bg },
	TeSTTProgress = { fg = colors.purple, bg = colors.statusline_bg },

	TeSTTLocationIcon = { fg = colors.black, bg = "#858585" },
	TeSTTLocation = { fg = colors.black, bg = "#858585" },

	-- TeDash
	TeDashAscii = { fg = colors.black, bg = colors.blue },
	TeDashButtons = { fg = colors.white, bg = colors.black2 },
	TeDashBindKeys = { fg = colors.white, bg = colors.blue },
}
