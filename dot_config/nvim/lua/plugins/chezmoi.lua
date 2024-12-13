local pn = require("plugin_names")

local function chezmoi_config()
	local chezmoi = require("chezmoi")
	chezmoi.setup({})
end

return {
	pn.chezmoi,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = chezmoi_config,
}
