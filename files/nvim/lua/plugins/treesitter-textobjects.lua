local pn = require("../plugin_names")
local reg = require("../register_keybindings")

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

	reg.register_select_inside_keybindings({
		p = {
			function()
				if check_inside_node_type("parameter") then
					tsselect.select_textobject("@parameter.inner")
				end
			end,
			"Select inside parameter",
		},
		c = {
			function()
				tsselect.select_textobject("@comment.inner")
			end,
			"Select inside comment",
		},
		f = {
			function()
				if check_inside_node_type({ "function_declaration", "method_declaration" }) then
					tsselect.select_textobject("@function.inner")
				end
			end,
			"Select inside function",
		},
		l = {
			function()
				tsselect.select_textobject("@loop.inner")
			end,
			"Select inside loop",
		},
		a = {
			function()
				tsselect.select_textobject("@assignment.inner")
			end,
			"Select inside assignment",
		},
		s = {
			function()
				tsselect.select_textobject("@class.inner")
			end,
			"Select inside class",
		},
		o = {
			function()
				tsselect.select_textobject("@conditional.inner")
			end,
			"Select inside conditional",
		},
	})

	reg.register_select_around_keybindings({
		p = {
			function()
				if check_inside_node_type("parameter") then
					tsselect.select_textobject("@parameter.outer")
				end
			end,
			"Select around parameter",
		},
		c = {
			function()
				tsselect.select_textobject("@comment.outer")
			end,
			"Select around comment",
		},
		f = {
			function()
				if check_inside_node_type({ "function_declaration", "method_declaration" }) then
					tsselect.select_textobject("@function.outer")
				end
			end,
			"Select around function",
		},
		l = {
			function()
				tsselect.select_textobject("@loop.outer")
			end,
			"Select around loop",
		},
		a = {
			function()
				tsselect.select_textobject("@assignment.outer")
			end,
			"Select around assignment",
		},
		s = {
			function()
				tsselect.select_textobject("@class.outer")
			end,
			"Select around class",
		},
		o = {
			function()
				tsselect.select_textobject("@conditional.outer")
			end,
			"Select around conditional",
		},
	})

	reg.register_match_keybindings({
		m = {
			function()
				vim.cmd([[normal! %]])
			end,
			"Goto matching bracket",
		},
		h = {
			function()
				tsselect.select_textobject("@assignment.lhs")
			end,
			"Select assignment LHS",
		},
		l = {
			function()
				tsselect.select_textobject("@assignment.rhs")
			end,
			"Select assignment RHS",
		},
	})

	reg.register_left_bracket_keybindings({
		f = {
			function()
				tsmove.goto_previous_start("@function.outer")
			end,
			"Goto previous function start",
		},
		F = {
			function()
				tsmove.goto_previous_end("@function.outer")
			end,
			"Goto previous function end",
		},
		a = {
			function()
				tsmove.goto_previous_start("@parameter.outer")
			end,
			"Goto previous parameter start",
		},
		A = {
			function()
				tsmove.goto_previous_end("@parameter.outer")
			end,
			"Goto previous parameter end",
		},
		c = {
			function()
				tsmove.goto_previous_start("@comment.outer")
			end,
			"Goto previous comment start",
		},
		C = {
			function()
				tsmove.goto_previous_end("@comment.outer")
			end,
			"Goto previous comment end",
		},
	})

	reg.register_right_bracket_keybindings({
		f = {
			function()
				tsmove.goto_next_start("@function.outer")
			end,
			"Goto next function start",
		},
		F = {
			function()
				tsmove.goto_next_end("@function.outer")
			end,
			"Goto next function end",
		},
		a = {
			function()
				tsmove.goto_next_start("@parameter.outer")
			end,
			"Goto next parameter start",
		},
		A = {
			function()
				tsmove.goto_next_end("@parameter.outer")
			end,
			"Goto next parameter end",
		},
		c = {
			function()
				tsmove.goto_next_start("@comment.outer")
			end,
			"Goto next comment start",
		},
		C = {
			function()
				tsmove.goto_next_end("@comment.outer")
			end,
			"Goto next comment end",
		},
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
