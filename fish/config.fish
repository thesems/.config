# alias
alias e="nvim"
alias g="git"
alias ga="git add ."
alias gl="git log"
alias gs="git status"
alias gb="git branch"
alias gp="git push; git push --tags"
alias gpf="git push -f; git push --tags -f"
alias gph="git pull"

set -g fish_color_normal white
set -g fish_color_autosuggestion brblack
set -g fish_color_search_match --background='333'
set -U fish_prompt_pwd_dir_length 0

# git information, colors, icons
set -g __fish_git_prompt_show_informative_status 0
set -g __fish_git_prompt_hide_untrackedfiles 0
set -g __fish_git_prompt_color_branch brgreen 
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showupstream 'yes'
set -g __fish_git_prompt_shorten_branch_len '8' 
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_showuntrackedfiles 'yes'
set -g __fish_git_prompt_char_dirtystate 'x'
set -g __fish_git_prompt_char_stagedstate '→'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stashstate '↩'
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_cleanstate ""


function fish_greeting
end

function fish_prompt
    set_color normal 
    printf (whoami)
    set_color normal 
    printf "@"(prompt_pwd)
    printf '%s' (fish_git_prompt)
    echo -n " \$ "
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
