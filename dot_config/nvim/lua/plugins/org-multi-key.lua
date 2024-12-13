local pn = require("plugin_names")

local function org_multi_key_config()
	local omk = require("orgmode-multi-key")
	omk.setup()
end

return {
	pn.org_multi_key,
	dependencies = {
		pn.org,
	},
	config = org_multi_key_config,
}
