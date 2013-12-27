#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function copy() {
	rsync  -av --no-perms shell/ ~
	rsync  -av --no-perms git/ ~
	rsync  -av --no-perms ruby/ ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copy
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copy
	fi
fi
unset doIt
