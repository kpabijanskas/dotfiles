local ready_to_register = false

local kbd_tables = {
    global = {
        name = "Global",
        prefixes = {""},
        tables = {}
    },
	debug = {
        name = "Debug",
        prefixes = {"<leader>g"},
        tables = {}
	},
    z = {
        name = "Z",
        prefixes = {"z"},
        tables = {}
    },
    window = {
        name = "Window",
        prefixes = {"<leader>w", "<C-w>"},
        tables = {}
    },
    ["goto"] = {
        name = "Goto",
        prefixes = {"g"},
        tables = {}
    },
    vim = {
        name = "Vim",
        prefixes = {"<leader>v"},
        tables = {}
    },
	leader = {
        name = "Leader",
        prefixes = {"<leader>"},
        tables = {}
	},
    left_bracket = {
        name = "Left Bracket",
        prefixes = {"["},
        tables = {}
    },
    right_bracket = {
        name = "Right Bracket",
        prefixes = {"]"},
        tables = {}
    },
    select_around = {
        name = "Select Around",
        prefixes = {"ma"},
        tables = {}
    },
    select_inside = {
        name = "Select Inside",
        prefixes = {"mi"},
        tables = {}
    },
    match = {
        name = "Match",
        prefixes = {"m"},
        tables = {}
    }
}

local function add_keybindings(table, keybindings, modes)
    modes = modes or "nv"

    for i = 1, #modes do
        local mode = string.char(modes:byte(i))

        if kbd_tables[table]["tables"][mode] == nil then
            kbd_tables[table]["tables"][mode] = {}
        end

        for k, v in pairs(keybindings) do
            kbd_tables[table]["tables"][mode][k] = v
        end
    end
end

local function register_tables()
	if ready_to_register == false then
		return
	end

	local wk = require("which-key")

    for _, data in pairs(kbd_tables) do
        for mode, keybindings in pairs(data["tables"]) do
            for _, prefix in ipairs(data["prefixes"]) do
                local opts = {mode = mode}
                if prefix ~= "" then opts["prefix"] = prefix end

                wk.register(keybindings, opts)
            end
        end
    end
end

local function register(table, keybindings, modes)
	add_keybindings(table, keybindings, modes)
	register_tables()
end

local function init()
		ready_to_register = true
		register_tables()
end

return {
	-- init shoulw be called after which-key is loaded, so most likely inside which-key config func
	-- allows actually registering keybinding tables
	init = init,
	register_leader_keybindings = function(keybindings, modes)
		register("leader", keybindings, modes)
	end,
	register_vim_keybindings = function(keybindings, modes)
		register("vim", keybindings, modes)
	end,
	register_goto_keybindings = function(keybindings, modes)
		register("goto", keybindings, modes)
	end,
	register_left_bracket_keybindings = function(keybindings, modes)
		register("left_bracket", keybindings, modes)
	end,
	register_right_bracket_keybindings = function(keybindings, modes)
		register("right_bracket", keybindings, modes)
	end,
	register_match_keybindings = function(keybindings, modes)
		register("match", keybindings, modes)
	end,
	register_select_around_keybindings = function(keybindings, modes)
		register("select_around", keybindings, modes)
	end,
	register_select_inside_keybindings = function(keybindings, modes)
		register("select_inside", keybindings, modes)
	end,
	register_window_keybindings = function(keybindings, modes)
		register("window", keybindings, modes)
	end,
	register_z_keybindings = function(keybindings, modes)
		register("z", keybindings, modes)
	end,
	register_debug_keybindings = function(keybindings, modes)
		register("debug", keybindings, modes)
	end,
    register_global_keybindings = function(keybindings, modes)
        register("global", keybindings, modes)
    end,
}

