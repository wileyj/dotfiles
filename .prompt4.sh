__git_ps1 ()
{
        local b="$(git symbolic-ref HEAD 2>/dev/null)";
        if [ -n "$b" ]; then
                printf " (%s)" "${b##refs/heads/}";
        fi
}
export PS1='\
\[\e[01;30m\]\t \
`[ "$(screen -ls | grep -c Detach)" != "0" ]\
&& echo "\[\e[00;34m\]$(screen -ls | grep -c Detach ) "`\
`[ "$(jobs -r | wc -l)" != "0" ]\
&& echo "\[\e[00;33m\]$(jobs -r | wc -l ) "`\
`[ "$(jobs -s | wc -l)" != "0" ]\
&& echo "\[\e[00;31m\]$(jobs -s | wc -l ) "`\
\[\e[01;37m\][\
`[ $UID == 0 -a $USER != $(logname) ]\
&& echo "\[\e[00;31m\]"`\
`[ $UID == 0 -a $USER != $(logname) -a -z "$SUDO_USER" ]\
&& echo "\[\e[01;31m\]"`\
`[ $UID == 0 -a $USER == $(logname) ]\
&& echo "\[\e[01;33m\]"`\
`[ $UID != 0 -a $USER == $(logname) ]\
&& echo "\[\e[00;32m\]"`\
`[ $UID != 0 -a $USER != $(logname) ]\
&& echo "\[\e[00;33m\]"`\
\u\
\[\e[00;36m\]@\
`[ "$SSH_CLIENT" != "" -o "$SSH2_CLIENT" != "" ]\
&& echo "\[\e[00;33m\]"\
|| echo "\[\e[00;32m\]"`\
\h \
`[ -w "${PWD}" ]\
&& echo "\[\e[01;34m\]\W"\
|| echo "\[\e[01;31m\]\W"`\
\[\e[01;37m\]]\
`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]\
&& echo "\[\e[01;31m\]"\
|| echo "\[\e[01;32m\]"`$(__git_ps1 "(%s)")\[\e[00m\]\$ '
#time in black  #[,bold white #  user, red   # @, cyan     # host, green   # dir,bold blue# ],bold white#   Check if something needs to be commited in git repo                                    # if so, bold red            #if not, bold green  #current git branch#prompt, normal
# original from https://makandracards.com/makandra/1090-customize-your-bash-prompt
#export PS1='\[\e[01;30m\]\t `if [ $? = 0 ]; then echo "\[\e[32m\]✔"; else echo "\[\e[31m\]✘"; fi` \[\e[00;37m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "\[\e[31m\]" || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '
