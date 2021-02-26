#!/bin/zsh

# Author : Jerry (tech@czekuj.net)
# Copyright (c) czekuj.net

# testing script

echo "script started ..."

# git visualization
function visual_git() {

    # variables declaration
    local -a roots=("${HOME}/Documents/coding/rootwww" \
                    "${HOME}/Documents/coding/rootzsh")
    local gitname
    local gitbranch
    local githash
    local result

    # colors
    local col_whi="\e[0;30m\e[47m"
    local col_red="\e[0;37m\e[41m"
    local col_yel="\e[0;30m\e[43m"
    local col_gre="\e[0;30m\e[42m"

    # color reset
    local RCol='\e[0m'
    # regular colors
    local Bla='\e[0;30m'
    local Red='\e[0;31m'
    local Gre='\e[0;32m'
    local Yel='\e[0;33m'
    local Blu='\e[0;34m'
    local Pur='\e[0;35m'
    local Cya='\e[0;36m'
    local Whi='\e[0;37m'
    # bold colors
    local BBla='\e[1;30m'
    local BRed='\e[1;31m'
    local BGre='\e[1;32m'
    local BYel='\e[1;33m'
    local BBlu='\e[1;34m'
    local BPur='\e[1;35m'
    local BCya='\e[1;36m'
    local BWhi='\e[1;37m'
    # background colors
    local On_Bla='\e[40m'
    local On_Red='\e[41m'
    local On_Gre='\e[42m'
    local On_Yel='\e[43m'
    local On_Blu='\e[44m'
    local On_Pur='\e[45m'
    local On_Cya='\e[46m'
    local On_Whi='\e[47m'

    # testing existence of git repositories
    gitname=$(git rev-parse --show-toplevel) 2> /dev/null
    if [ $? -eq 0 ]; then
        # assembling git status

        gitname="${gitname:t}"

        local color_branch="${col_gre}"
        gitbranch="$(git rev-parse --abbrev-ref HEAD)" 2> /dev/null
        case ${gitbranch} in
            "production")
                color_branch=${col_red}
                ;;
            "master")
                color_branch=${col_yel}
                ;;
            "HEAD")
                color_branch=${col_whi}
                ;;
        esac

        local color_hash="${col_whi}"
        githash="$(git rev-parse --short HEAD)" 2> /dev/null
        if ! [ $? -eq 0 ]; then githash="\U2205" ; fi

        result=" ${color_hash} ${githash} ${color_branch} ${gitbranch} ${col_whi} ${gitname} ${RCol} "
    else
        # testing if in root dev directories
        local roots_test=-1
        for i in "${roots[@]}"; do
            if [ "${PWD##$i}" != "${PWD}" ]; then roots_test=0; fi
        done

        if [ $roots_test -eq 0 ]; then
            # git missing notification
            result=" ${Whi}${On_Red} no-GIT ${RCol} "
        else
            # git not initialized
            result=" \U2205 "
        fi
    fi

    echo ${result}
}

visual_git

function test() {

    # gitbranch="$(git branch --show-current)"

    gitmore="$(git branch -vv)"
    gitstatus="$(git status -s )"

}

echo "... script ended"

# setopt prompt_subst

# declare shorthead
# function koo() { git rev-parse --short HEAD }
# # function githead() { $shorthead=$(koo) }
# function precmd() { vcs_info; shorthead=$(koo) }

# export RPROMPT='${vcs_info_msg_0_} $shorthead'

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' disable bzr cdv cvs darcs fossil hg mtn p4 svk svn tla
# zstyle ':vcs_info:*' formats '%b -%u%c%m- %r|%s'
# # zstyle ':vcs_info:git*:*' check-for-changes true
# # zstyle ':vcs_info:*' stagedstr '%F{3}A%f'
# # zstyle ':vcs_info:*' unstagedstr 'M'
# # zstyle ':vcs_info:*' actionformats '%b|%a -%u%c- %r|%s'
# # zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash git-st
# # function +vi-git-untracked() {
# #   if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
# #   [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
# #   hook_com[unstaged]+='%F{red}??%f'
# # fi
# # }
# # function +vi-git-stash() {
# #   local -a stashes

# #   if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
# #     stashes=$(git stash list 2>/dev/null | wc -l)
# #     hook_com[misc]+="%f (%F{1}STASH=${stashes}%f)"
# #   fi
# # }