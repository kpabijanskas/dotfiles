-- https://github.com/blacktrub/telescope-godoc.nvim/blob/main/lua/godoc/init.lua TODO create a better version
local pn = require("plugin_names")
local pick = require("lib.pick")

local function go_filetype_table()
    local wk = require("which-key")

    local kb_table = {
        { "<localleader>U", "<cmd>GoUpdateBinaries<cr>", desc = "Update Binaries" },
        { "<localleader>T", "<cmd>GoTest<cr>",           desc = "Test all" },
        { "<localleader>t", "<cmd>GoTestFunc<cr>",       desc = "Test current function" },
        { "<localleader>r", "<cmd>GoTestFile<cr>",       desc = "Test functions in current file" },
        { "<localleader>R", "<cmd>GoTestPkg<cr>",        desc = "Test functions in current package" },
        { "<localleader>a", "<cmd>GoAddTest<cr>",        desc = "Add test for current function" },
        { "<localleader>A", "<cmd>GoAddExpTest<cr>",     desc = "Add tests for all exported functions" },
        { "<localleader>c", "<cmd>GoCheat<cr>",          desc = "Open cheat.sh for current function" },
        { "<localleader>o", "<cmd>GoPkgOutline<cr>",     desc = "Open package outline" },
        {
            "<localleader>g",
            function()
                local results = {
                    {
                        name = "json",
                        command = function()
                            vim.cmd("GoAddTag json")
                        end,
                    },
                    {
                        name = "yaml",
                        command = function()
                            vim.cmd("GoAddTag yaml")
                        end,
                    },
                }

                pick(results, "Tag Type")
            end,
            desc = "Add Tags By Type",
        },
        {
            "<localleader>G",
            function()
                local results = {
                    {
                        name = "json",
                        command = function()
                            vim.cmd("GoRmTag json")
                        end,
                    },
                    {
                        name = "yaml",
                        command = function()
                            vim.cmd("GoRmTag yaml")
                        end,
                    },
                }

                pick(results, "Tag Type")
            end,
            desc = "Remove Tags By Type",
        },
        { "<localleader>C", "<cmd>GoClearTag<cr>",    desc = "Clear all tags" },
        { "<localleader>m", "<cmd>GoCmt<cr>",         desc = "Add comment" },
        { "<localleader>i", "<cmd>GoImpl<cr>",        desc = "Implement an interface" },
        { "<localleader>f", "<cmd>GoFillStruct<cr>",  desc = "Fill struct" },
        { "<localleader>F", "<cmd>GoFillSwitch<cr>",  desc = "Fill switch" },
        { "<localleader>v", "<cmd>GoModTidy<cr>",     desc = "Tidy" },
        { "<localleader>V", "<cmd>GoModVendor<cr>",   desc = "Vendor" },
        { "<localleader>j", "<cmd>GoJson2Struct<cr>", desc = "JSON To Struct" },
    }

    wk.add({
        { mode = "n", kb_table },
        { mode = "v", kb_table },
    })
end

local function go_config()
    require("go").setup({
        goimports = "gopls",
        gofmt = "golines",
        tag_transform = false,
        test_dir = "",
        lsp_cfg = true, -- false: use your own lspconfig
        lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
        dap_debug = true,
        lsp_keymaps = false,
        max_line_len = 120,
        build_tags = "wireinject",
    })

    local go_autocmd_group = vim.api.nvim_create_augroup("go_autocmd_group", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        group = go_autocmd_group,
        callback = go_filetype_table,
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "gomod",
        group = go_autocmd_group,
        callback = go_filetype_table,
    })
end

return {
    pn.go,
    dependencies = {
        pn.nvim_lspconfig,
        pn.treesitter,
        pn.dap,
        pn.guihua,
        pn.telescope,
    },
    config = go_config,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
}
