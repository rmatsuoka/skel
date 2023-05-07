# rc.zsh

[ true = "$SKEL_DEBUG" ] && echo "skel_debug: read $SKEL_LIBPATH/rc.zsh" >&2

PS1='%{[36m%}%0~ %{[39m%}%# '

if [ "X$TERM" = Xdumb ]
then
	unsetopt ZLE
	unsetopt PROMPT_CR
	unsetopt PROMPT_SUBST
	unfunction precmd 2>/dev/null
	unfunction preexec 2>/dev/null

	PS1='%0~ %# '
	export PAGER='col -xb'
fi
