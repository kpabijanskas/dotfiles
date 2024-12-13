local dap = require("dap")

local function register_remote_go_attach(name, path, port)
	if dap.configurations.go == nil then
		dap.configurations.go = {}
	end

	table.insert(dap.configurations.go, {
		name = "[Delve Attach] " .. name,
		type = "go",
		request = "attach",
		mode = "remote",
		port = port,
		remotePath = "/app",
		substitutepath = {
			{
				from = "${workspaceFolder}",
				to = path,
			},
		},
		trace = "log",
		logOutput = "rpc",
		showLog = true,
	})
end

return {
	register_remote_go_attach = register_remote_go_attach,
}
