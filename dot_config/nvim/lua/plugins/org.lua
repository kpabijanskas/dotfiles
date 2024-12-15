local pn = require("plugin_names")

local org_base_path = "~/Nextcloud/org/"

local file_basenames = {
    inbox = "inbox",
    work_log = "work_log",
    journal = "journal",
    projects = "projects",
    areas = "areas",
    resources = "resources",
    personal = "personal",
    shopping = "shopping",
}

local work_datetree = {
    reversed = true,
    tree_type = "custom",
    tree = {
        {
            format = "%Y",
            pattern = "^(%d%d%d%d)$",
            order = { 1 },
        },
        {
            format = "%Y-%m %B",
            pattern = "^(%d%d%d%d)%-(%d%d).*$",
            order = { 1, 2 },
        },
        {
            format = "%Y-%m W%V",
            pattern = "^(%d%d%d%d)%-(%d%d)% W(%d%d).*$",
            order = { 1, 2, 3 },
        },
        {
            format = "%Y-%m-%d %A",
            pattern = "^(%d%d%d%d)%-(%d%d)%-(%d%d).*$",
            order = { 1, 2, 3 },
        },
    },
}

local function orgPath(path)
    return org_base_path .. path .. ".org"
end

local function format_orgmode_action(actions, ...)
    local funcs = { ... }

    local action_list = {}
    for _, action in ipairs(actions) do
        table.insert(action_list, ('"%s"'):format(action))
    end

    local o = ('<cmd>lua require("orgmode").action(%s)<CR>'):format(table.concat(action_list, ","))
    for _, f in ipairs(funcs) do
        o = f(o)
    end

    return o
end

local function agenda()
    local pick = require("lib.pick")
    local oa = require("orgmode").agenda
    local f = require("orgmode.agenda.filter")

    local function wrap_search(query)
        return function()
            oa:tags({ search = query })
        end
    end

    pick({
        {
            name = "Unprocessed",
            command = wrap_search("/UNPROCESSED"),
        },
        {
            name = "TODO",
            command = wrap_search("/TODO"),
        },
        {
            name = "Doing",
            command = wrap_search("/Doing"),
        },
        {
            name = "Unscheduled",
            command = function()
                oa:tags({ filters = { f:new() } })
            end,
        },
    }, "Pick agenda view")
end

local function org_filetype_table()
    local wk = require("which-key")
    local oc = require("orgcheckbox")
    local telescope = require("telescope")

    local kb_table = {
        {
            "<localleader>C",
            oc.toggle_checkbox,
            desc = "Toggle checkbox",
        },
        {
            "<localleader>r",
            telescope.extensions.orgmode.refile_heading,
            desc = "Refile",
        },
        {
            "<localleader>/",
            function()
                telescope.extensions.orgmode.search_headings({ max_depth = 4 })
            end,
            desc = "Search",
        },
        {
            "<localleader>l",
            telescope.extensions.orgmode.insert_link,
            desc = "Insert link",
        },
    }

    local insert_table = {
        { "<CR>", format_orgmode_action({ "org_mappings.org_return" }), desc = "Org Return" },
        {
            "<C-CR>",
            '<cmd>lua require("orgmode").action("org_mappings.meta_return")<cr>',
            desc = "New heading",
        },
    }

    wk.add({
        buffer = true,
        silent = true,
        nowait = true,
        { mode = "n", kb_table },
        { mode = "v", kb_table },
        { mode = "i", insert_table },
    })
end

local function orgagenda_filetype_table()
    local wk = require("which-key")

    local kb_table = {
        { "<localleader>v", desc = "View" },
        { "<C-c>",          format_orgmode_action({ "agenda.quit" }), desc = "Quit" },
    }

    wk.add({
        buffer = vim.api.nvim_get_current_buf(),
        { mode = "n", kb_table },
        { mode = "v", kb_table },
    })
end

local function telescope_orgmode_config()
    local telescope = require("telescope")
    telescope.load_extension("orgmode")
end

local function orgmode_config()
    local org = require("orgmode")
    local menu = require("org-modern.menu")
    local telescope = require("telescope")
    local wk = require("which-key")

    org.setup({
        org_agenda_files = {
            orgPath(file_basenames.inbox),
            orgPath(file_basenames.work_log),
            orgPath(file_basenames.journal),
            orgPath(file_basenames.projects),
            orgPath(file_basenames.areas),
            orgPath(file_basenames.resources),
            orgPath(file_basenames.personal),
            orgPath(file_basenames.shopping),
        },
        org_default_notes_file = orgPath(file_basenames.inbox),
        org_todo_keywords = {
            "UNPROCESSED(u)",
            "BUY(b)",
            "TODO(t)",
            "DOING(d)",
            "WAITING(w)",
            "|",
            "DONE(x)",
            "DELEGATED(e)",
        },
        org_todo_repeat_to_state = "TODO",
        org_startup_folded = "content",
        org_hide_leading_stars = true,
        org_hide_emphasis_markers = true,
        org_ellipsis = " ↲",
        org_log_done = "note",
        org_log_repeat = "time",
        org_log_into_drawer = "STATE_CHANGES",
        win_split_mode = { "float", "0.8" },
        calendar_week_start_day = 1,
        org_deadline_warning_days = 14,
        org_agenda_span = "week",
        org_agenda_start_on_weekday = false,
        org_agenda_start_day = "-2d",
        org_use_tag_inheritance = true,
        org_tags_exclude_from_inheritance = { "PROJECT" },
        mappings = {
            prefix = "",
            global = {
                org_agenda = "<leader>oa",
                org_capture = "<leader>oc",
            },
            agenda = {
                org_agenda_later = "<localleader>]",
                org_agenda_earlier = "<localleader>[",
                org_agenda_goto_today = "<localleader>.",
                org_agenda_day_view = "<localleader>vd",
                org_agenda_week_view = "<localleader>vw",
                org_agenda_month_view = "<localleader>vm",
                org_agenda_year_view = "<localleader>vy",
                org_agenda_quit = "<localleader>q",
                org_agenda_switch_to = false,
                org_agenda_goto = "<CR>",
                org_agenda_goto_date = "<localleader>o",
                org_agenda_redo = "<localleader>R",
                org_agenda_todo = "<localleader>t",
                org_agenda_clock_goto = "<localleader>X",
                org_agenda_set_effort = "<localleader>e",
                org_agenda_clock_in = "<localleader>z",
                org_agenda_clock_out = "<localleader>Z",
                org_agenda_clock_cancel = "<localleader><C-z>",
                org_agenda_clockreport_mode = "<localleader>x",
                org_agenda_priority = "<localleader>p",
                org_agenda_priority_up = "<localleader>k",
                org_agenda_priority_down = "<localleader>j",
                org_agenda_archive = "<localleader>A",
                org_agenda_toggle_archive_tag = "<localleader><C-A>",
                org_agenda_set_tags = "<localleader>y",
                org_agenda_deadline = "<localleader>d",
                org_agenda_schedule = "<localleader>s",
                org_agenda_filter = "<localleader>f",
                org_agenda_refile = "<localleader>r",
                org_agenda_add_note = "<localleader>a",
                org_agenda_show_help = false,
            },
            capture = {
                org_capture_finalize = "<C-c>",
                org_capture_refile = "<localleader>r",
                org_capture_kill = "<localleader>K",
                org_capture_show_help = false,
            },
            note = {
                org_note_finalize = "<C-c>",
                org_note_kill = "<localleader>K",
            },
            org = {
                org_refile = false,

                org_timestamp_up_day = false,
                org_timestamp_down_day = false,
                org_timestamp_up = "<localleader><C-k>",
                org_timestamp_down = "<localleader><C-j>",
                org_change_date = "<localleader>c",
                org_priority = "<localleader>p",
                org_priority_up = "<localleader>k",
                org_priority_down = "<localleader>j",
                org_todo = false,
                org_todo_prev = false,
                org_toggle_checkbox = false,
                org_toggle_heading = "<localleader>h",
                org_open_at_point = false,
                org_edit_special = "<localleader>i",
                org_add_note = "<localleader>a",
                org_cycle = "<TAB>",
                org_global_cycle = "<S-TAB>",
                org_archive_subtree = "<localleader>A",
                org_set_tags_command = "<localleader>y",
                org_toggle_archive_tag = "<localleader><C-A>",
                org_do_promote = "<<",
                org_do_demote = ">>",
                org_promote_subtree = "<s",
                org_demote_subtree = ">s",
                org_meta_return = false,
                org_return = false,
                org_insert_heading_respect_content = "<localleader>n",
                org_insert_todo_heading = false,
                org_insert_todo_heading_respect_content = "<localleader>N",
                org_move_subtree_up = "<C-k>",
                org_move_subtree_down = "<C-j>",
                org_export = "<localleader>E",
                org_next_visible_heading = "]v",
                org_previous_visible_heading = "[v",
                org_forward_heading_same_level = "]h",
                org_backward_heading_same_level = "[h",
                outline_up_heading = "[p",
                org_deadline = "<localleader>d",
                org_schedule = "<localleader>s",
                org_time_stamp = "<localleader>m",
                org_time_stamp_inactive = "<localleader>M",
                org_toggle_timestamp_type = "<localleader>I",
                org_insert_link = false,
                org_store_link = false,
                org_clock_in = "<localleader>z",
                org_clock_out = "<localleader>Z",
                org_clock_cancel = "<localleader><C-z>",
                org_clock_goto = "<localleader>X",
                org_set_effort = "<localleader>e",
                org_show_help = false,
                org_babel_tangle = "<localleader>b",
            },
            edit_src = {
                org_edit_src_abort = "<localleader>K",
                org_edit_src_save = "<C-c>",
                org_edit_src_show_help = false,
            },
            text_objects = {
                inner_heading = "ih",
                around_heading = "ah",
                inner_subtree = "ir",
                around_subtree = "ar",
                inner_heading_from_root = "Oh",
                around_heading_from_root = "OH",
                inner_subtree_from_root = "Or",
                around_subtree_from_root = "OR",
            },
        },
        ui = {
            menu = {
                handler = function(data)
                    menu:new({
                        window = {
                            margin = { 1, 0, 1, 0 },
                            padding = { 0, 1, 0, 1 },
                            title_pos = "center",
                            border = "single",
                            zindex = 1000,
                        },
                        icons = {
                            separator = "➜",
                        },
                    }):open(data)
                end,
            },
        },
        org_capture_templates = {
            t = {
                description = "INBOX: Task",
                template = "* UNPROCESSED %?\n  %u",
                target = orgPath(file_basenames.inbox),
                properties = {
                    empty_lines = 1,
                },
            },
            n = {
                description = "INBOX: Note",
                template = "* %?\n  %u",
                target = orgPath(file_basenames.inbox),
                properties = {
                    empty_lines = 1,
                },
            },
            w = {
                description = "WORK TODAY: Task",
                template = "* UNPROCESSED  %?\n %u",
                datetree = work_datetree,
                target = orgPath(file_basenames.work_log),
                properties = {
                    empty_lines = 1,
                },
            },
            e = {
                description = "WORK TODAY: Note",
                template = "* %?\n  %u",
                datetree = work_datetree,
                target = orgPath(file_basenames.work_log),
                properties = {
                    empty_lines = 1,
                },
            },
            m = {
                description = "WORK TODAY: Meeting",
                template = "* UNPROCESSED MEETING %U %^{Meeting Name?} :MEETING:\n  %?",
                datetree = work_datetree,
                target = orgPath(file_basenames.work_log),
                properties = {
                    empty_lines = 1,
                },
            },
        },
    })

    local global_org_table = {
        {
            "<leader>of",
            function()
                telescope.extensions.orgmode.search_headings({ mode = "orgfiles" })
            end,
            desc = "Org files",
        },
        {
            "<leader>os",
            agenda,
            desc = "Custom Agenda Searches",
        },
    }

    wk.add({
        { mode = "n", global_org_table },
        { mode = "v", global_org_table },
    })

    local org_autocmd_group = vim.api.nvim_create_augroup("org_autocmd_group", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "org",
        group = org_autocmd_group,
        callback = org_filetype_table,
    })

    local orgagenda_autocmd_group = vim.api.nvim_create_augroup("orgagenda_autocmd_group", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "orgagenda",
        group = orgagenda_autocmd_group,
        callback = orgagenda_filetype_table,
    })
end

return {
    {
        pn.org,
        dependencies = {
            pn.which_key,
            pn.org_modern,
            pn.treesitter,
        },
        event = "VeryLazy",
        ft = { "org" },
        config = orgmode_config,
    },
    {
        pn.telescope_orgmode,
        dependencies = {
            pn.org,
            pn.telescope,
        },
        config = telescope_orgmode_config,
    },
}
