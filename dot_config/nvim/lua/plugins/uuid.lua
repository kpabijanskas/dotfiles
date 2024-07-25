local pn = require("plugin_names")

local function uuid_config()
	local uuid = require("uuid-nvim")
	local wk = require("which-key")

	uuid.setup({
		case = "lower",
		quotes = "none",
	})

	wk.add({
		{ "<C-u>", uuid.insert_v4, desc = "Insert UUIDv4", mode = "i" },
	})
end

return {
	pn.uuid,
	config = uuid_config,
}
