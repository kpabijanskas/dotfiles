local pn = require("../plugin_names")
local reg = require("../register_keybindings")

local function telescope_config()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.load_extension("fzf")

    telescope.setup({
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })

    reg.register_leader_keybindings({
        C = { builtin.commands, "Open command picker" },
        f = { builtin.find_files, "Open file picker" },
        F = { builtin.git_files, "Open Git file picker" },
        b = { builtin.buffers, "Open buffer picker" },
        j = { builtin.jumplist, "Open jumplist picker" },
        s = { builtin.lsp_document_symbols, "Open symbol picker" },
        S = { builtin.lsp_workspace_symbols, "Open workspace symbol picker" },
        d = {
            function()
                builtin.diagnostics({ bufnr = 0 })
            end,
            "Open diagnostics picker",
        },
        D = { builtin.diagnostics, "Open workspace diagnostics picker" },
        ["'"] = { builtin.resume, "Open last picker" },
        ["/"] = { builtin.live_grep, "Global search" },
        h = { builtin.lsp_references, "Show symbol references" },
    })

    reg.register_vim_keybindings({
        f = { builtin.filetypes, "Pick filetype" },
        h = { builtin.help_tags, "Search vim help" },
        ["?"] = { builtin.commands, "List available vim/plugin commands" },
    })

    reg.register_goto_keybindings({
        d = { builtin.lsp_definitions, "Goto definition" },
        y = { builtin.lsp_type_definitions, "Goto type definition" },
        r = { builtin.lsp_references, "Goto references" },
        i = { builtin.lsp_implementations, "Goto implementation" },
    })
end

return {
    {
        pn.telescope_fzf_native,
        build = "make",
    },
    {
        pn.telescope,
        tag = "0.1.5",
        dependencies = {
            pn.telescope_fzf_native,
            pn.plenary,
            pn.which_key,
        },
        config = telescope_config,
    },
}
