return function(results, title)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local sorters = require("telescope.sorters")
    local finders = require("telescope.finders")

    title = title or "Select..."

    pickers
        .new({
            results_title = title,
            finder = finders.new_table({
                results = results,
                entry_maker = function(entry)
                    return {
                        value = entry.command,
                        display = entry.name,
                        ordinal = entry.name,
                    }
                end,
            }),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    selection.value()
                end)
                return true
            end,
            sorter = sorters.get_fuzzy_file(),
        }, {})
        :find()
end
