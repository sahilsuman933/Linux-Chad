
# Part - 2 [Installation]

pacman -S --noconfirm sed reflector
reflector --latest 10 --protocol https --save /etc/pacman.d/mirrorlist

# Language and Time Setup
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

# Hostname Setup

echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts

mkinitcpio -P
echo "Root Password: "
passwd
pacman --noconfirm -S grub efibootmgr os-prober

# Grub Configuration

echo "EFI Partition Location (eg: /dev/sda2 or /dev/nvme0n1p9) :"
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Basic Application Installation

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
     sxiv mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db xwallpaper python-pywal unclutter xclip maim \
     zip unzip unrar p7zip xdotool papirus-icon-theme brightnessctl  \
     dosfstools ntfs-3g git sxhkd zsh pipewire pipewire-pulse \
     emacs-nox arc-gtk-theme rsync qutebrowser dash \
     xcompmgr libnotify dunst slock jq aria2 cowsay \
     dhcpcd networkmanager wpa_supplicant rsync pamixer mpd ncmpcpp \
     zsh-syntax-highlighting xdg-user-dirs libconfig \
     bluez bluez-utils \
     intel-ucode nvidia nvidia-utils

rm /bin/sh
ln -s dash /bin/sh

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Creating Non-Root User
echo "Enter Non-Root Username: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username

# Some systemd services
systemctl enable NetworkManager
systemctl enable bluetooth

# Moving the Environment Setup to Home Directory
cp ./env-setup.sh /home/$username/env-setup.sh
rm -rf ../install


