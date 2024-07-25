local pn = require("plugin_names")

local function todo_comments_config()
	local todo = require("todo-comments")
	todo.setup({})

	local telescope = require("telescope")
	telescope.load_extension("todo-comments")
	local extension = require("telescope._extensions.todo-comments")

	local wk = require("which-key")

	local kb_table = { "<leader>T", extension.exports.todo, desc = "Open TODO" }

	wk.add({
		kb_table,
		{ mode = "v", kb_table },
	})
end

return {
	pn.todo_comments,
	dependencies = {
		pn.plenary,
		pn.telescope,
	},
	config = todo_comments_config,
}
