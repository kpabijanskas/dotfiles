local pn = require("plugin_names")
local common_lib = require("lib.common")
local pick = require("lib.pick")

local function zk_searches()
    return {
        ["All active projects"] = {
            tags = { "project", "active" },
        },
        ["Active Work projects"] = {
            tags = { "project", "active", "work" },
        },
        ["Active Personal projects"] = {
            tags = { "project", "active", "personal" },
        },
        ["All parked projects"] = {
            tags = { "project", "parked" },
        },
        ["Parked Work projects"] = {
            tags = { "project", "parked", "work" },
        },
        ["Parked Personal projects"] = {
            tags = { "project", "parked", "personal" },
        },
        ["All archived projects"] = {
            tags = { "project", "archived" },
        },
        ["Archived Work projects"] = {
            tags = { "project", "archived", "work" },
        },
        ["Archived Personal projects"] = {
            tags = { "project", "archived", "personal" },
        },
        ["Active goals"] = {
            tags = { "goals", "active" },
        },
        ["Completed goals"] = {
            tags = { "goals", "completed" },
        },
        ["Literature Notes"] = {
            tags = { "literature" },
        },
        ["Unprocessed Literature Notes"] = {
            tags = { "literature", "not_processed" },
        },
    }
end

local function new_from_zk_template(title)
    local zk = require("zk")

    local templates = {
        ["Default"] = "default.md",
        ["Personal Project"] = "pproject.md",
        ["Work Project"] = "wproject.md",
        ["Literature Note"] = "lit_note.md",
    }

    local results = {}

    for name, file in pairs(templates) do
        table.insert(results, {
            name = name,
            command = function()
                zk.new({ title = title, template = file })
            end,
        })
    end

    pick(results, "New from template with title '" .. title .. "'...")
end

local function pick_zk_search()
    local zk = require("zk")
    local results = {}

    for name, options in pairs(zk_searches()) do
        table.insert(results, {
            name = name,
            command = function()
                zk.edit(options)
            end,
        })
    end

    pick(results, "Run...")
end

local function change_project_status(from, to)
    local zk_api = require("zk.api")

    local from_str = table.concat(from, "|")
    print(from_str)

    return function(input)
        local joblib = require("plenary.job")
        local job = joblib:new({
            command = "yq",
            args = {
                "-i",
                "--front-matter=process",
                '.tags[] |= sub("(' .. from_str .. ')","' .. to .. '")',
                input[1]["absPath"],
            },
        })
        job:sync()
        zk_api.index()
    end
end

local function zk_file_table()
    local zk = require("zk")
    local commands = require("zk.commands")
    local wk = require("which-key")

    local kb_table = {
        { "<leader><space>",  group = "ZK" },

        { "<leader><space>n", commands.get("ZkNotes"),            desc = "Show Notes" },
        { "<leader><space>s", pick_zk_search,                     desc = "Searches" },
        { "<leader><space>b", commands.get("ZkBacklinks"),        desc = "Show Backlinks" },
        { "<leader><space>l", commands.get("ZkLinks"),            desc = "Outbound links from this note" },
        { "<leader><space>g", commands.get("ZkTags"),             desc = "Search tags" },
        { "<leader><space>d", commands.get("ZkCd"),               desc = "cd to ZK dir" },
        { "<leader><space>t", commands.get("ZkToday"),            desc = "Open todays note" },
        { "<leader><space>i", commands.get("ZkIdx"),              desc = "Open index note" },
        { "<leader><space>p", commands.get("ZkPersonalProjects"), desc = "Active personal projects" },
        { "<leader><space>w", commands.get("ZkWorkProjects"),     desc = "Active work projects" },
        {
            "<leader><space>a",
            function()
                zk.pick_notes(
                    { tags = { "project", "NOT archived" } },
                    {},
                    change_project_status({ "parked", "active" }, "archived")
                )
            end,
            desc = "Archive project",
        },
        {
            "<leader><space>q",
            function()
                zk.pick_notes(
                    { tags = { "project", "NOT parked" } },
                    {},
                    change_project_status({ "archived", "active" }, "parked")
                )
            end,
            desc = "Park project",
        },
        {
            "<leader><space>z",
            function()
                zk.pick_notes(
                    { tags = { "project", "NOT active" } },
                    {},
                    change_project_status({ "archived", "parked" }, "active")
                )
            end,
            desc = "Activate project",
        },
        {
            "<leader><space>r",
            function()
                vim.ui.input({
                    prompt = "Enter note title",
                }, function(input)
                    new_from_zk_template(input)
                end)
            end,
            desc = "New Note",
        },
    }

    local v_only_kb_table = {
        mode = "v",
        {
            "<leader><space>m",
            function()
                -- if there is an active visual selection, it doesnt match
                -- that selection needs to be dropped first
                local key = vim.api.nvim_replace_termcodes("<Esc>", false, true, true)
                vim.api.nvim_feedkeys(key, "nx", false)
                commands.get("ZkMatch")()
            end,
            desc = "Search for last selected text",
        },
        { "<leader><space>c", commands.get("ZkNewFromTitleSelection"), desc = "Create note vith selection as title" },
        {
            "<leader><space>C",
            commands.get("ZkNewFromContentSelection"),
            desc = "Create note vith selection as content",
        },
    }

    wk.add({
        kb_table,
        { mode = "v", kb_table },
        v_only_kb_table,
    })
end

local function maybe_load_zk_table()
    local env_path = vim.fn.getenv("ZK_NOTEBOOK_DIR")
    if env_path == nil or env_path == "" then
        return
    end

    local current_dir = vim.fn.expand("%:p:h")
    if current_dir == "" then
        return false
    end
    local normalize_path = function(path)
        return vim.fn.fnamemodify(path, ":p")
    end

    env_path = normalize_path(env_path)
    current_dir = normalize_path(current_dir)

    if current_dir:sub(1, #env_path) == env_path then
        zk_file_table()
    end
end

local function zk_buffer_local_opts()
    vim.opt_local.conceallevel = 2
end

local function split_dategenforzk_output(s)
    local output = {}

    local vars = vim.split(s, ",")

    for _, var in ipairs(vars) do
        local vs = vim.split(var, "=")
        output[vs[1]] = vs[2]
    end

    return output
end

local calendar_note_date_format = {
    ["daily"] = "%Y-%m-%d",
    ["weekly"] = "%Y-W%V",
    ["montly"] = "%Y-%m",
    ["yearly"] = "%Y",
}

local function load_calendar_note(note_type)
    return function(options)
        local zk = require("zk")
        local joblib = require("plenary.job")

        if calendar_note_date_format[note_type] == nil then
            print("unknown note type: " .. note_type)
            return
        end

        local date = os.date(calendar_note_date_format[note_type])
        if type(date) ~= "string" then
            return
        end
        local job = joblib:new({
            command = "dategenforzk",
            args = {
                "-txt",
                date,
            },
        })

        job:sync()

        options = options or {}
        options.title = date
        options.extra = split_dategenforzk_output(job:result()[1])
        options.group = note_type
        options.dir = "journal/" .. note_type

        zk.new(options)
        zk.cd()
    end
end

local function open_index_note(options)
    local zk = require("zk")

    options = options or {}
    options.title = "Index"
    options.dir = "general"

    zk.cd()
    vim.api.nvim_command("edit general/index.md")
end

local function create_link_under_cursor(options)
    local zk = require("zk")
    local joblib = require("plenary.job")
    local tsu = require("nvim-treesitter.ts_utils")
    -- vim.treesitter.get_node for some reason only ever returns inline, not specific enough
    local node_under_cursor = tsu.get_node_at_cursor()

    if node_under_cursor == nil or node_under_cursor:type() ~= "link_text" then
        return
    end

    local node_link = vim.split(tsu.get_node_text(node_under_cursor)[1], "|")[1]
    local dir, title = common_lib.split_on_last_occurence(node_link, "/")

    local job = joblib:new({
        command = "dategenforzk",
        args = {
            "-txt",
            title,
        },
    })
    job:sync()

    options = options or {}
    options.title = title
    options.dir = dir

    if job.code == 0 then
        options.extra = split_dategenforzk_output(job:result()[1])
    end

    zk.new(options)
    vim.api.nvim_command("LspRestart")
end

local function load_search(search_name)
    return function(options)
        local zk = require("zk")
        local cmd_opts = zk_searches()[search_name]
        options = options or {}
        options = common_lib.merge_tables(options, cmd_opts)
        zk.edit(options)
    end
end

local function zk_config()
    local zk = require("zk")
    local commands = require("zk.commands")
    local wk = require("which-key")

    zk.setup({
        picker = "telescope",
    })

    commands.add("ZkToday", load_calendar_note("daily"))
    commands.add("ZkIdx", open_index_note)
    commands.add("ZkCreateLinkUnderCursor", create_link_under_cursor)
    commands.add("ZkPersonalProjects", load_search("Active Personal projects"))
    commands.add("ZkWorkProjects", load_search("Active Work projects"))

    local kb_table = {
        { "<leader>n", commands.get("ZkToday"), desc = "Open Todays note" },
    }

    wk.add({
        kb_table,
        { mode = "v", kb_table },
    })

    local zk_autocmd_group = vim.api.nvim_create_augroup("zk_autocmd_group", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        group = zk_autocmd_group,
        callback = maybe_load_zk_table,
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        group = zk_autocmd_group,
        callback = zk_buffer_local_opts,
    })
end

return {
    pn.zk,
    dependencies = {
        pn.telescope,
    },
    config = zk_config,
}
