# profile.sh

[ "$SKEL_DEBUG" = true ] && echo "skel_debug: read $SKEL_LIBPATH/profile.sh" >&2

[ -z "$SKEL_LIBPATH" ] && export SKEL_LIBPATH="$HOME/lib"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ENV="$SKEL_LIBPATH/rc.sh"

# addpath adds a given direcotry to PATH env but avoids adding same path twice.
# If the direcotry does not exist, addpath returns false.
# If with -e option, addpath adds the directory to the end of PATH, else to the beginning.
addpath() {
	local eflag=false
	if [ "$1" = -e ]
	then
		eflag=true
		shift
	fi
	local p="${1%/}"

	[ -d "$p" ] || return 1

	case "$PATH" in
	"$p":*|*:"$p"|*:"$p":*) ;;
	*)
		if [ true = "$eflag" ]
		then
			PATH="${PATH}:${p}"
		else
			PATH="${p}:${PATH}"
		fi
		;;
	esac
}

addpath "$HOME/bin"
addpath "$HOME/go/bin"

[ -z "$PLAN9" ] && export PLAN9="/usr/local/plan9"
if addpath -e "$PLAN9/bin"
then

	sh -c 'fontsrv &' </dev/null >/dev/null 2>&1
	plumber </dev/null >/dev/null 2>&1

	export font=/mnt/font/GoMono/12a/font
fi

unset -f addpath
