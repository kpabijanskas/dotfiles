return {
	name = "Staticcheck",
	builder = function()
		return {
			cmd = "/bin/bash",
			args = { "-c", "staticcheck -f stylish ./..." },
		}
	end,
}
