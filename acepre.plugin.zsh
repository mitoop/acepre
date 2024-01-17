__ace-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }

  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

ace-command-line() {
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  case "$BUFFER" in
    ace\ *) __ace-replace-buffer "ace" "" ;;
    *) LBUFFER="ace $LBUFFER" ;;
  esac

  LBUFFER="${WHITESPACE}${LBUFFER}"

  zle && zle redisplay
}

zle -N ace-command-line

bindkey -M emacs '\e\e' ace-command-line
bindkey -M vicmd '\e\e' ace-command-line
bindkey -M viins '\e\e' ace-command-line
