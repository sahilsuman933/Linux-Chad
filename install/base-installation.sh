echo "
===========================================================================================
||░█████╗░██████╗░░█████╗░██╗░░██╗  ██████╗░██╗░░░██╗░██████╗████████╗███████╗██████╗░   ||
||██╔══██╗██╔══██╗██╔══██╗██║░░██║  ██╔══██╗██║░░░██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗   ||
||███████║██████╔╝██║░░╚═╝███████║  ██████╦╝██║░░░██║╚█████╗░░░░██║░░░█████╗░░██████╔╝   ||
||██╔══██║██╔══██╗██║░░██╗██╔══██║  ██╔══██╗██║░░░██║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗   ||
||██║░░██║██║░░██║╚█████╔╝██║░░██║  ██████╦╝╚██████╔╝██████╔╝░░░██║░░░███████╗██║░░██║   ||
||╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝  ╚═════╝░░╚═════╝░╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝   ||
===========================================================================================                                                                  
||                          Made with ♡ By Sahil Suman                                   ||
===========================================================================================
"
#Part - 1 [Disk Partition and Mount]
 
# Fetch latest mirror list 

reflector --latest 10 --protocol https --save /etc/pacman.d/mirrorlist

# Setup timedate and set keyboard layout
pacman --noconfirm -Sy archlinux-keyring 
loadkeys us
timedatectl set-ntp true

# Partition

lsblk
echo "Enter Drive (eg. /dev/sda or /dev/nvme0n1 or something similar): "
read drive
cfdisk $drive

echo "
    
    File Type For Partitions: 
    Root = Linux Filesystem | Format File Type EXT4    
    EFI  = EFI System | Format File Type FAT32
    Swap = Linux Swap | Format File Type EXT4

    "

echo "Enter Root Partition Location (eg. /dev/sda4 or /dev/nvme0n1p6 or something similar): "
read rootpartition
mkfs.ext4 $rootpartition

echo "Enter EFI Partition Location (eg. /dev/sda4 or /dev/nvme0n1p6 or something similar): " 
read efipartition
mkfs.fat -F32 $efipartition

read -p "Did you made Swap Partiton? [y/n]: " answer
if [[ $answer = y ]] ; then
    echo "Enter Swap Partition Location (eg. /dev/sda4 or /dev/nvme0n1p6 or something similar): "
    read swappartition
    mkswap $swappartition
    swapon $swappartition
fi

# Mount

mount $rootpartition /mnt


cp -r ../install /mnt

pacstrap /mnt base base-devel linux linux-firmware sudo nano ntfs-3g networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

