local pn = require("plugin_names")

local function nullls_config()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
        sources = {
            -- Lua
            null_ls.builtins.formatting.stylua,
            -- Go
            -- null_ls.builtins.formatting.golines,
            null_ls.builtins.formatting.goimports_reviser,
            -- C
            null_ls.builtins.formatting.clang_format.with({
                extra_args = { "--style", "{SortIncludes: Never, IndentWidth: 4}" },
            }),
            -- Shell
            null_ls.builtins.formatting.shellharden,
            null_ls.builtins.formatting.shfmt,
            -- Fish
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.formatting.fish_indent,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    })
end

return {
    pn.none_ls,
    config = nullls_config,
    build = {
        "go install github.com/segmentio/golines@latest",
        "go install github.com/incu6us/goimports-reviser@latest",
    },
}

-- TOOD: check out https://golangci-lint.run/usage/configuration/
