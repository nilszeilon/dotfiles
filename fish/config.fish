set -U fish_greeting 
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/nilszeilon/anaconda3/bin/conda
    eval /Users/nilszeilon/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# add brew 
eval $(/opt/homebrew/bin/brew shellenv)

alias vimwiki='nvim -c VimwikiIndex'

source ~/.config/fish/functions/worklog


