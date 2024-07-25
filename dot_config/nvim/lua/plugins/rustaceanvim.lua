local pn = require("plugin_names")

local function rustaceanvim_config()
    vim.g.rustaceanvim = {
        tools = {},
        server = {
            on_attach = function(client, bufnr)
                _ = client
                _ = bufnr
            end,
            default_settings = {
                ["rust-analyzer"] = {},
            },
        },
        dap = {},
    }
end

return {
    pn.rustaceanvim,
    version = "^4", -- Recommended
    ft = { "rust" },
    config = rustaceanvim_config,
}
