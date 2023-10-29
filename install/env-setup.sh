
# Part - 3 [WM Setup]


# Move this file to home directory then run this command.

cd $HOME


# Yay Packages

git clone --depth=1 https://github.com/sahilsuman933/dwm.git ~/.local/src/dwm
git clone --depth=1 https://github.com/sahilsuman933/st.git ~/.local/src/st
git clone --depth=1 https://github.com/sahilsuman933/dwm.git ~/.local/src/dmenu
git clone --depth=1 https://github.com/sahilsuman933/pinentry-dmenu.git ~/.local/src/pinentry-dmenu
git clone --depth=1 https://github.com/sahilsuman933/dwmblocks.git ~/.local/src/dwmblocks

# install
sudo make -C ~/.local/src/dwm install
sudo make -C ~/.local/src/st install
sudo make -C ~/.local/src/dmenu install
sudo make -C ~/.local/src/pinentry-dmenu clean install
sudo make -C ~/.local/src/dwmblocks install



# Paru: AUR Repository
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si


yay -S libxft-bgra-git yt-dlp-drop-in
mkdir dl dox pix code study

ln -s ~/.config/x11/xinitrc .xinitrc
ln -s ~/.config/shell/profile .zprofile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/zsh/oh-my-zsh
rm ~/.zshrc ~/.zsh_history
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dots config --local status.showUntrackedFiles no
exit
