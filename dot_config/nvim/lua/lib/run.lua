local pick = require("lib.pick")

local commands = {}

local function add_command(project, name, command)
	if commands[project] == nil then
		commands[project] = {}
	end

	commands[project][name] = command
end

local function add_project_keybindings(project)
	local wk = require("which-key")
	local results = function()
		local results = {}
		if commands[project] == nil then
			return results
		end

		for name, command in pairs(commands[project]) do
			table.insert(results, {
				name = name,
				command = command,
			})
		end

		return results
	end

	local kb_table = {
		{
			"<leader>u",
			function()
				pick(results(), "Run...")
			end,
			desc = "Run...",
		},
	}

	wk.add({
		kb_table,
		{ mode = "v", kb_table },
	})
end

local common_commands = {
	COMMAND_FINAL_CHECKS = {
		name = "Final checks",
		command = function()
			local term = require("toggleterm")

			local cmd = 'cmd="go mod tidy && go mod vendor && make all && make qa && make lint-golangci"'
			local direction = 'direction="float"'
			local name = 'name="Final checks"'
			term.exec_command(cmd .. " " .. direction .. " " .. name)
		end,
	},
}

local common_command_names = {}

for k in pairs(common_commands) do
	common_command_names[k] = k
end

local function add_common_command(project, command)
	local cmd = common_commands[command]
	if cmd == nil then
		print("UNKNOWN COMMAND " .. command)
		return
	end

	add_command(project, cmd["name"], cmd["command"])
end

return {
	add_command = add_command,
	add_project_keybindings = add_project_keybindings,
	add_common_command = add_common_command,
	common_commands = common_command_names,
}
