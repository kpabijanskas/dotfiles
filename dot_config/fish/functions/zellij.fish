function zellij
    if count $argv >/dev/null
        command zellij $argv
    else
        command zellij a --create
    end
end
