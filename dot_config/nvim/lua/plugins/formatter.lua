local pn = require("plugin_names")

local function formatter_config()
    local formatter = require("formatter")
    local util = require("formatter.util")
    local go_formatters = require("formatter.filetypes.go")
    local any_formatters = require("formatter.filetypes.any")

    formatter.setup({
        filetype = {
            go = {
                go_formatters.gofumpt,
                function()
                    return {
                        exec = "golines",
                        args = {
                            "--max-len=120",
                        },
                    }
                end,
                function()
                    return {
                        exe = "goimports-reviser",
                        args = {
                            "-output",
                            "stdout",
                            "-rm-unused",
                            "-set-alias",
                            "-format",
                            util.escape_path(util.get_current_buffer_file_path()),
                        },
                        stdin = true,
                    }
                end,
            },
            ['*'] = {
                any_formatters.substitute_trailing_whitespace,
            }
        },
    })

    local formatter_autocmd_group = vim.api.nvim_create_augroup("formatter_autocmd_group", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatter_autocmd_group,
        command = ":FormatWrite",
    })
end

return {
    pn.formatter,
    config = formatter_config,
}
