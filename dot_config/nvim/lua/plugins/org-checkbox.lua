local pn = require("plugin_names")

local function org_checkbox_config()
	local oc = require("orgcheckbox")
	oc.setup()
end

return {
	pn.org_checkbox,
	dependencies = {
		pn.org,
	},
	config = org_checkbox_config,
}
