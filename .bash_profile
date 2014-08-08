export PATH="$(brew --prefix php55)/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
function color_my_prompt {
    local __default_color="\[\033[37m\]"
    local __text_color="\[\033[0;37m\]"
    local __user_and_host="\[\033[0;32m\]\u @ \h$__default_color"
    local __cur_location="\[\033[0;36m\]\w$__default_color"
    local __git_branch_color="\[\033[1;31m\]"
    git --version 2>&1 >/dev/null # improvement by tripleee
    GIT_IS_AVAILABLE=$?
    if [ $GIT_IS_AVAILABLE -eq 0 ]; then 
        local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1\/`'
        local __git_branch_display=$__git_branch_color"branch: "$__git_branch$__default_color
    else
        __git_branch_display=$__git_branch_color"branch: git isn't installed"$__default_color
    fi

    local __prompt_tail="\[\033[01;34m\]$"$__default_color
    local __last_color="\[\033[00m\]"

    PS1="\n"$__default_color
    PS1=$PS1"┌─["$__user_and_host"]-["$__cur_location]"\n"
    PS1=$PS1"├─["$__git_branch_display"]\n"
    PS1=$PS1"└─["$__prompt_tail"]>"$__last_color" "
    export PS1;
}

color_my_prompt

. ~/.bash_aliases
. ~/.profile
