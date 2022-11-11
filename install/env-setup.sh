
# Part - 3 [WM Setup]


# Move this file to home directory then run this command.

cd $HOME

# Yay: AUR Repository
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Yay Packages

# xorg server
yay -S xorg

# wallpaper and compositor and yt-dlp
yay -S picom nitrogen yt-dlp-drop-in

# dwm, dmenu, st terminal and slock lock
yay -S dwm-git dmenu st-git slock-git
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc

# nitrogen --restore &
# picom &
# exec dwm


sudo nano ~/.xinitrc

