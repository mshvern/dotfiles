function pushvimrc
	cd ~/work/dotfiles;
cp ~/.vimrc .vimrc;
git add .;
git commit -m $argv;
git push;
end
