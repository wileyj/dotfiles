case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

C_WHITE='\[\e[1;37m\]'
C_LIGHTGRAY='\[\e[0;37m\]'
C_GRAY='\[\e[1;30m\]'
C_BLACK='\[\e[0;30m\]'
C_RED='\[\e[0;31m\]'
C_LIGHTRED='\[\e[1;31m\]'
C_GREEN='\[\e[0;32m\]'
C_LIGHTGREEN='\[\e[1;32m\]'
C_BROWN='\[\e[0;33m\]'
C_YELLOW='\[\e[1;33m\]'
C_BLUE='\[\e[0;34m\]'
C_LIGHTBLUE='\[\e[1;34m\]'
C_PURPLE='\[\e[0;35m\]'
C_PINK='\[\e[1;35m\]'
C_CYAN='\[\e[0;36m\]'
C_LIGHTCYAN='\[\e[1;36m\]'
C_DEFAULT='\[\e[0m\]'

function setsymbols() {
  local exit_status=$?
  local color_exit=
  local color_exit2=
  local color_exit3=
  local usym=
  local end_sym=\$
  local usegit=$1
  local id=`/usr/bin/id -u`
  #[ -n "$ID" -a "$ID" -le 200 ] && return
  [[ $id == 0 ]] && end_sym=\#
  if [ $exit_status = 0 ]; then
    if [[ $id == 0 ]]; then
      color_exit="$C_LIGHTBLUE"; color_exit2="$C_BLUE"; color_exit3="$C_WHITE";
    else
      color_exit="$C_LIGHTGREEN"; color_exit2="$C_GREEN"; color_exit3="$C_LIGHTBLUE";
    fi
    usym=":"
  else
    if [[ $id == 0 ]]; then
      color_exit="$C_LIGHTRED"; color_exit2="$C_RED"; color_exit3="$C_BROWN";
    else
      color_exit="$C_LIGHTRED"; color_exit2="$C_RED"; color_exit3="$C_LIGHTCYAN";
    fi
    usym="!"
  fi
  [ -n "$usegit" ] && [ $(git status --porcelain 2>/dev/null | wc -l | tr -d " ") != 0 ] && color_git="$C_BROWN" || color_git=
  [ $(jobs | wc -l | tr -d " ") != 0 ] && color_job="$C_BROWN" || color_job=
  PS1="${debian_chroot:+($debian_chroot)}${color_exit}\u${color_exit2}\
@\
${color_exit}$HOSTNAME${color_exit2}${color_git}\
${usym}\
${color_exit3}\w${color_exit2}${color_job}\
${end_sym}\
${C_DEFAULT} "
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=setsymbols
else
    PS1='\u@${HOSTNAME}:\w\$ '
fi
unset color_prompt force_color_prompt
