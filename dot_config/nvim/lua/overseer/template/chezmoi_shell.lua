return function(name, command)
	return {
		name = name,
		builder = function()
			return {
				cmd = "/bin/bash",
				args = { "-c", "chezmoi " .. command },
			}
		end,
	}
end
