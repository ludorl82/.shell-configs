[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# For symlinks with fzf use FZF_FOLLOW_SYMLINKS=yes
# For hidden files searched use FZF_SHOW_HIDDEN=yes
export FZF_DEFAULT_COMMAND='find . -not -path "*/\.*" -type f -print | cut -b3-'
export FZF_FOLLOW_SYMLINKS="no"
export FZF_SHOW_HIDDEN="no"

# To recreate FZF_DEFAULT_COMMAND:
# export FZF_FOLLOW_SYMLINKS=no FZF_SHOW_HIDDEN=yes; fzfgen
fzfgen() {
  export FZF_DEFAULT_COMMAND="find$(if [ ! -z ${FZF_FOLLOW_SYMLINKS+x} ] && [ ${FZF_FOLLOW_SYMLINKS} != 'no' ] ; then echo -n ' -L'; fi) .$(if [ -z ${FZF_SHOW_HIDDEN+x} ] || [ ${FZF_SHOW_HIDDEN} != 'yes' ]; then echo -n ' -not'; fi) -path '*/.*' -type f -print | cut -b3-"
}

# Use same command for autocompletion
_fzf_compgen_path() {
  eval $FZF_DEFAULT_COMMAND
}

# https://github.com/junegunn/fzf/wiki/examples#git
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}
