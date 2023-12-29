#!/bin/fish
# Place this file into ~/.config/fish/completions or another completions directory 
# https://fishshell.com/docs/current/completions.html#where-to-put-completions

# List the help page
set __todo_txt_help_output (todo.sh help)

# Commands
set -l todo_commands (string match -r '^\s{4}([[:lower:]]+).*$' -g $__todo_txt_help_output)
set -l commands_descriptions (string match -r '^\s{4}(\w+[[:ascii:]]+).*$' -g $__todo_txt_help_output)
set -l additional_commands command help
complete -c todo.sh -f

for command in $todo_commands
    complete -c todo.sh -n "not __fish_seen_subcommand_from $todo_commands; or __fish_seen_subcommand_from $additional_commands" -r -a "$command" -d (string match -r (echo "^\s{4}($command(?> [[:ascii:]]+)?)\$") -g $__todo_txt_help_output)
end

# Options
function __fish_todo_txt_match_option_description
    set -f concatenated_output (string join "|" $__todo_txt_help_output)
    set -f options_string (string split '||' $concatenated_output)
    set -f options_string (string join "" $options_string[2] $options_string[3])
    set -f regex_string (printf "(-%s[\|\s](?>[\w\.\s\|\(\)\_\:\/\;\"\',]|-\w{3,})+)(?>-[[:ascii:]]{1,2}[\|\s]|)" $argv)
    set -f matched_string (string match -r "$regex_string" -g $options_string)
    set -f split (string split '|' -- $matched_string)
    set -f trim (string trim -- $split)
    set -f join (string join " " -- $trim)
    set -f replace (string replace -r -- "-$argv" "" $join)
    printf "%s" $replace
end

set -l todo_txt_options (string match -r '\s{4}-(\w+)' -g $__todo_txt_help_output)
for option in $todo_txt_options
    complete -c todo.sh -n "not __fish_seen_subcommand_from $todo_commands" -o "$option" -d (__fish_todo_txt_match_option_description $option)
end

# Matching functions
set -g __todo_txt_task_regex '^(\d+) ?(\(\w\))? ?(\d+-\d+-\d+)? ?(\d+-\d+-\d+)? ?(.*)$'

function __fish_get_items
    set --local items (todo.sh -p ls)
    __format_task (__match_task $items)
end

function __format_task
    string replace -r "$__todo_txt_task_regex" '$1\t$5' $argv
end

function __match_task
    string match -r '^\d+ .*$' $argv
end

# Current word
function __fish_seen_plus_at_cursor
    set --local tokens (commandline --current-process --current-token)
    test (string match -r '\+.*' $tokens)
end

function __fish_seen_context_at_cursor
    set --local tokens (commandline --current-process --current-token)
    test (string match -r '@.*' $tokens)
end

function __fish_get_project
    todo.sh -p listproj
end
function __fish_get_context
    todo.sh -p listcon
end

function __fish_seen_item
    set --local tokens (commandline --current-process --tokenize)
    test (string match -r '\d+' $tokens[-1])
end

# Filename items
set -l commands_with_filenames addto listfile move
complete -c todo.sh -f -n "not __fish_seen_subcommand_from $commands_with_filenames"
complete -c todo.sh -F -n "__fish_seen_subcommand_from move mv; and __fish_seen_item"

# Completing items
set -l commands_with_item app append del depri do done dp o p prep prepend pri replace rm
complete -c todo.sh -f -n "__fish_seen_subcommand_from $commands_with_item" -a '(__fish_get_items)'
complete -c todo.sh -f -n "__fish_seen_subcommand_from move mv; and not __fish_seen_item" -a '(__fish_get_items)'

# Term items
set -l commands_with_term a add addm app append del list listall listcon listproj ls lsa lsc lsprj prep prepend replace rm
complete -c todo.sh -f -n "__fish_seen_subcommand_from $commands_with_term; and __fish_seen_plus_at_cursor" -a '(__fish_get_project)'

# Context items
set -l commands_with_context a add addm app append del list listall listcon listproj ls lsa lsc lsprj prep prepend replace rm
complete -c todo.sh -f -n "__fish_seen_subcommand_from $commands_with_context; and __fish_seen_context_at_cursor" -a '(__fish_get_context)'
