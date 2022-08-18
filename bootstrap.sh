#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";
# git pull origin main;
declare -a FILES=(".zshrc" ".aliases" ".gitconfig")

function doIt() {
	# rsync --exclude ".git/" \
	# 	--exclude ".DS_Store" \
	# 	--exclude ".osx" \
	# 	--exclude "bootstrap.sh" \
	# 	--exclude "README.md" \
	# 	--exclude "LICENSE.txt" \
	# 	-avh --no-perms . ~;
	# source ~/.bash_profile;
	echo -n "Enter Git Name";
	read name;
	echo -n "Enter Git Email Address";
	read email;
	
	mkdir -p temp;
	rm -rf temp/*;
	for FILE in "${FILES[@]}"
	do
		sed "s/{HOME}/$HOME/g; s/{NAME}/$name/g; s/{EMAIL}/$email/g" $FILE > temp/$FILE
	done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
