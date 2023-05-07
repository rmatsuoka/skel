# ~/lib/rc.sh

[ true = "$SKEL_DEBUG" ] && echo "skel_debug: read $SKEL_LIBPATH/rc.sh" >&2

libpath=${SKEL_LIBPATH-"$HOME/lib"}

# lib/rc.notexist must not exist.
# this script checks existance of source files before reading it.
shname=notexist
osname=unix
rclist=

case "$(ps -oargs= -p $$)" in
*bash*) shname=bash;;
*zsh*)  shname=zsh;;
*)      ;;
esac

case $(uname) in
GNU/Linux) osname=linux;;
Darwin)    osname=darwin;;
*)         ;;
esac

for f in "rc.${shname}" "rc_${osname}.sh" "rc_${osname}.${shname}"
do
	fname="$libpath/$f"
	[ -r "$fname" ] && . "$fname"
done

unset libpath shname osname rclist

mkcd() {
	mkdir -p "$1" && cd "$1"
}

# for acme editor
test -n "$winid" && unalias -a
