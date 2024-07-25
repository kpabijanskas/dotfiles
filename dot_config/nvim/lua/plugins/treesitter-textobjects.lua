local pn = require("plugin_names")

local function check_inside_node_type(typ)
	local tsutils = require("nvim-treesitter.ts_utils")

	local node = tsutils.get_node_at_cursor()
	while node do
		for _, t in pairs(typ) do
			if node:type() == t then
				return true
			end
		end

		node = node:parent()
	end
	return false
end

local function treesitter_textobjects_config()
	local tsselect = require("nvim-treesitter.textobjects.select")
	local tsmove = require("nvim-treesitter.textobjects.move")
	local wk = require("which-key")

	local kb_table = {
		{
			"mip",
			function()
				if check_inside_node_type("parameter") then
					tsselect.select_textobject("@parameter.inner")
				end
			end,
			desc = "Select inside parameter",
		},
		{
			"mic",
			function()
				tsselect.select_textobject("@comment.inner")
			end,
			desc = "Select inside comment",
		},
		{
			"mif",
			function()
				if check_inside_node_type({ "function_declaration", "method_declaration" }) then
					tsselect.select_textobject("@function.inner")
				end
			end,
			desc = "Select inside function",
		},
		{
			"mil",
			function()
				tsselect.select_textobject("@loop.inner")
			end,
			desc = "Select inside loop",
		},
		{
			"mia",
			function()
				tsselect.select_textobject("@assignment.inner")
			end,
			desc = "Select inside assignment",
		},
		{
			"mis",
			function()
				tsselect.select_textobject("@class.inner")
			end,
			desc = "Select inside class",
		},
		{
			"mio",
			function()
				tsselect.select_textobject("@conditional.inner")
			end,
			desc = "Select inside conditional",
		},
		{
			"map",
			function()
				if check_inside_node_type("parameter") then
					tsselect.select_textobject("@parameter.outer")
				end
			end,
			desc = "Select around parameter",
		},
		{
			"mac",
			function()
				tsselect.select_textobject("@comment.outer")
			end,
			desc = "Select around comment",
		},
		{
			"maf",
			function()
				if check_inside_node_type({ "function_declaration", "method_declaration" }) then
					tsselect.select_textobject("@function.outer")
				end
			end,
			desc = "Select around function",
		},
		{
			"mal",
			function()
				tsselect.select_textobject("@loop.outer")
			end,
			desc = "Select around loop",
		},
		{
			"maa",
			function()
				tsselect.select_textobject("@assignment.outer")
			end,
			desc = "Select around assignment",
		},
		{
			"mas",
			function()
				tsselect.select_textobject("@class.outer")
			end,
			desc = "Select around class",
		},
		{
			"mao",
			function()
				tsselect.select_textobject("@conditional.outer")
			end,
			desc = "Select around conditional",
		},
		{
			"mm",
			function()
				vim.cmd([[normal! %]])
			end,
			desc = "Goto matching bracket",
		},
		{
			"mh",
			function()
				tsselect.select_textobject("@assignment.lhs")
			end,
			desc = "Select assignment LHS",
		},
		{
			"ml",
			function()
				tsselect.select_textobject("@assignment.rhs")
			end,
			desc = "Select assignment RHS",
		},
		{
			"[f",
			function()
				tsmove.goto_previous_start("@function.outer")
			end,
			desc = "Goto previous function start",
		},
		{
			"[F",
			function()
				tsmove.goto_previous_end("@function.outer")
			end,
			desc = "Goto previous function end",
		},
		{
			"[a",
			function()
				tsmove.goto_previous_start("@parameter.outer")
			end,
			desc = "Goto previous parameter start",
		},
		{
			"[A",
			function()
				tsmove.goto_previous_end("@parameter.outer")
			end,
			desc = "Goto previous parameter end",
		},
		{
			"[c",
			function()
				tsmove.goto_previous_start("@comment.outer")
			end,
			desc = "Goto previous comment start",
		},
		{
			"[C",
			function()
				tsmove.goto_previous_end("@comment.outer")
			end,
			desc = "Goto previous comment end",
		},
		{
			"]f",
			function()
				tsmove.goto_next_start("@function.outer")
			end,
			desc = "Goto next function start",
		},
		{
			"]F",
			function()
				tsmove.goto_next_end("@function.outer")
			end,
			desc = "Goto next function end",
		},
		{
			"]a",
			function()
				tsmove.goto_next_start("@parameter.outer")
			end,
			desc = "Goto next parameter start",
		},
		{
			"]A",
			function()
				tsmove.goto_next_end("@parameter.outer")
			end,
			desc = "Goto next parameter end",
		},
		{
			"]c",
			function()
				tsmove.goto_next_start("@comment.outer")
			end,
			desc = "Goto next comment start",
		},
		{
			"]C",
			function()
				tsmove.goto_next_end("@comment.outer")
			end,
			desc = "Goto next comment end",
		},
	}

	wk.add({
		kb_table,
		{ mode = "v", kb_table },
	})
end

return {
	pn.treesitter_textobjects,
	dependencies = {
		pn.treesitter,
		pn.which_key,
	},
	config = treesitter_textobjects_config,
}
