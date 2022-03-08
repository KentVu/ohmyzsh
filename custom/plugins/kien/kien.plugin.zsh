### aliases
alias rm='rm -v'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -v'
### misc
function mkcd { mkdir -pv $1 && cd $1 ;}

# copyline
x-copy-region-as-kill () {
  zle copy-region-as-kill
  print -rn $CUTBUFFER | pbcopy
}
#zle -N x-copy-region-as-kill
#bindkey -e '\ew' x-copy-region-as-kill
#bindkey '^x^w' kill-region
x-kill-region () {
  zle kill-region
  print -rn $CUTBUFFER | pbcopy
}
zle -N x-kill-region
bindkey '^[w' x-kill-region

# movement
bindkey '^[b' vi-backward-word
#bindkey '^[f' vi-forward-word-end
bindkey '^[f' emacs-forward-word
bindkey '^[B' vi-backward-blank-word
bindkey '^[F' vi-forward-blank-word
# S-right
#bindkey '^[OC' forward-word
bindkey '^[[1;2D' backward-word
bindkey '^[[1;2C' forward-word

# history
#bindkey "\e\e[A" history-beginning-search-backward
#bindkey "[B" history-beginning-search-forward
bindkey "^[k" history-beginning-search-backward
bindkey "^[j" history-beginning-search-forward

cd_last() { cd - }
zle -N cd_last
bindkey '^^' cd_last

### adb
#alias adb_='adb ${ADB_DEVICE:+-s $ADB_DEVICE}'
function adb_ {
    if [ -z "$ADB_DEVICE" ]; then
        adb "$@"
    else
        adb -s $ADB_DEVICE "$@"
    fi
}

function adb_findPid {
    case "$1" in
        -r) 
			regex_syntax=$1 ; shift ;;
    esac
	sed="awk \"{print}\" ORS=\| |sed s/.$//"
	#echo $sed
	eval "adb_ shell ps -ef |grep -Ei \"$1\" |awk '{print \$2}'" "${regex_syntax:+|$sed}"
}

