#!/bin/zsh

# Author : Jerry (tech@czekuj.net)
# Copyright (c) czekuj.net

# git visualization

declare MINI_GIT

function visual_git() {

    # variables declaration
    local -a roots=("${HOME}/Documents/coding/rootwww/" \
                    "${HOME}/Documents/coding/rootzsh/")
    local gitname
    local gitbranch
    local githash
    local result
    local nogit=$'\U2205'

    # colors echo
    # local col_whi="\e[0;30m\e[47m"
    # local col_red="\e[0;37m\e[41m"
    # local col_yel="\e[0;30m\e[43m"
    # local col_gre="\e[0;30m\e[42m"
    # local col_r="\e[0m"

    # colors prompt
    local col_whi="%F{0}%K{7}"
    local col_red="%{%F{7}%K{1}%}"
    local col_yel="%F{0}%K{3}"
    local col_gre="%F{0}%K{2}"
    local col_r="%f%k"

    # testing existence of git repositories
    gitname="$(git rev-parse --show-toplevel)" 2> /dev/null
    if [ $? -eq 0 ]; then
        # assembling git status

        # git repo name
        gitname="${gitname:t}"

        # colored branch name
        local color_branch="${col_gre}"
        gitbranch="$(git rev-parse --abbrev-ref HEAD)" 2> /dev/null
        case ${gitbranch} in
            "production")
                color_branch="${col_red}"
                ;;
            "main")
                color_branch="${col_red}"
                ;;
            "master")
                color_branch="${col_yel}"
                ;;
            "HEAD")
                color_branch="${col_whi}"
                ;;
        esac

        # commit hash on colored status
        local color_hash
        githash="$(git rev-parse --short HEAD)" 2> /dev/null
        if [ $? -eq 0 ]; then
            color_hash="${col_red}"
        else
            color_hash="${col_whi}"; githash="${nogit}"
        fi

        result=" ${color_hash} ${githash} ${color_branch} ${gitbranch} ${col_whi} ${gitname} ${col_r} "
    else
        # testing if in root dev directories
        local roots_test=-1
        for i in "${roots[@]}"; do
            if [ "${PWD##$i}" != "${PWD}" ]; then roots_test=0; fi
        done

        if [ $roots_test -eq 0 ]; then
            # git missing notification
            result=" ${col_red} no-GIT ${col_r} "
        else
            # git not initialized
            result=" ${nogit} "
        fi
    fi

    MINI_GIT="${result}"
}

function test() {

    # gitbranch="$(git branch --show-current)"
    # gitmore="$(git branch -vv)"

    gitstatus="$(git status -sb --porcelain)" 2> /dev/null
    gitstatus_lc="$(wc -l <<< "${gitstatus}")"
    echo $gitstatus_lc
    gitstatus_lc_int=$(xargs <<< "$gitstatus_lc")
    echo $gitstatus_lc_int
    # gitstatus_lc_int=$((calc ${gitstatus_lc} * 1))
    # echo type $gitstatus_lc_int
    if [ $gitstatus_lc_int -eq 1 ]; then
        echo "ONE"
    fi
    local -a myArray=(${(f)"${gitstatus}"})
    for i in "${myArray[@]}"
        do  echo "${i}"
    done

    echo $gitsts_lc
}

# test

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