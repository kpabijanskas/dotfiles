local function split_on_last_occurence(str, sep)
    local last_index = str:match(".*" .. sep .. "()")
    if not last_index then
        return "", str
    end
    local first_part = str:sub(1, last_index - 2)
    local second_part = str:sub(last_index)

    return first_part, second_part
end

local function merge_tables(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge_tables(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

return {
    merge_tables = merge_tables,
    split_on_last_occurence = split_on_last_occurence,
}
