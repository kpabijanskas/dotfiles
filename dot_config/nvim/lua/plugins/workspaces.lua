local pn = require("plugin_names")

local function is_zellij_session()
    local ZELLIJ_ENV_KEY = "ZELLIJ_SESSION_NAME"
    return vim.fn.has_key(vim.fn.environ(), ZELLIJ_ENV_KEY) == true
end

local function set_zellij_tab_name()
    local workspaces = require("workspaces")

    if is_zellij_session == true then
        return
    end

    local workspace_name = workspaces.name()
    if workspace_name == nil then
        return
    end

    local o = io.popen("/home/karolispabijanskas/.cargo/bin/zellij action rename-tab " .. workspace_name)
    if o ~= nil then
        o:close()
    end
end

local function workspaces_config()
    local workspaces = require("workspaces")
    local telescope = require("telescope")
    local wk = require("which-key")

    workspaces.setup({
        hooks = {
            open = function()
                set_zellij_tab_name()
            end,
        },
    })

    telescope.load_extension("workspaces")

    -- local kb_table = {
    -- 	{ "<leader>o", telescope.extensions.workspaces.workspaces, desc = "Open Workspace" },
    -- }
    --
    wk.add({
        kb_table,
        { mode = "v", kb_table },
    })
end

return {
    pn.workspaces,
    config = workspaces_config,
    dependencies = {
        pn.telescope,
    },
}
