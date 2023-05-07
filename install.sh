#!/bin/sh

set -u

libpath=${SKEL_LIBPATH-"$HOME/lib"}
progname="$0"
nflag=false

usage() {
	cat <<EOF >&2
usage: $progname
  -n  dry-run
EOF
	exit 1
}

fatal() {
	printf '%s: %s\n' "$progname" "$*" >&2
	exit 1
}

evalcmd() {
	local cmd="$1"
	printf '%s\n' "$cmd" >&2
	if ! "$nflag"
	then
		eval "$cmd"
	fi
}

addcommand() {
	local file="$1"
	local cmd="$2"
	local keyword='github.com/rmatsuoka/skel/install.sh'

	if grep -qF -- "$keyword" "$file" 2>/dev/null
	then
		return 0
	fi

	evalcmd "cat <<'EOF' >> '$file'

# $keyword addition
# on $(date)
$cmd
EOF"
}

lnall() {
	local srcdir="$1"
	local distdir="$2"
	
	evalcmd "mkdir -p '$distdir'" || fatal 'cannot create a directory to store init files'
	for f in $(ls -A -- "$srcdir")
	do
		evalcmd "ln -sf -- '$srcdir/$f' '$distdir/$f'"
	done
}

main() {
	lnall "$(pwd)/home" "$HOME"
	lnall "$(pwd)/lib" "$libpath"

	addcommand ~/.profile ". $libpath/profile.sh"
	# zsh does not read ~/.proflie but bash does
	addcommand ~/.zprofile ". $libpath/profile.sh"

	addcommand ~/.bashrc ". $libpath/rc.sh"
	addcommand ~/.zshrc ". $libpath/rc.sh"
}

while getopts nh opt
do
	case "$opt" in
	n) nflag=true;;
	*) usage;;
	esac
done
shift $((OPTIND-1))

main
