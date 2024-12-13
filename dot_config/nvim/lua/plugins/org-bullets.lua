local pn = require("plugin_names")

return {
    pn.org_bullets,
    dependencies = {
        pn.org,
    },
    opts = {
        symbols = {
            headlines = { "◉", "○", "●", "○", "●", "○", "●" },
        },
        checkboxes = {
            half = { "-", "@org.checkbox.halfchecked" },
            done = { "✓", "@org.keyword.done" },
            todo = { " ", "@org.keyword.todo" },
        },
        list = "-",
    },
}
