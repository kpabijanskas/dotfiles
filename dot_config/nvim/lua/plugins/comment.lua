local pn = require("../plugin_names")

local function comment_config()
	require("Comment").setup()
end

return {
	pn.comment,
	config = comment_config,
}

