# WARNING Please read my archinstall kommins and sorry for my bad english.
# WARNING I'm not a linux pro.
# WARNING This archinstall is for the archlinux live iso you cant damang your system
# WARNING This archinstall is for my pc i have a full amd system.
# WARNING This is my first archinstall.
# WARNING When you use a old PC or slow internet please do not use my sript
# You need to stetup your Wifi your self. I dont know how do dish on Iwctl withe a command. I know how to stetup Iwctl but i dont now your wifi and password :C.

# I remove yay because in the live iso it dont work. It might work, but you'll just create more work for yourself.
# It's simpler after installing and setting up Arch Linux. 
# You need too boot fist in the system then you can install yay hier are the commands to install yay:
# sudo pacman -Syu
# sudo pacman -S --needed base-devel git
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si


echo -e "
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
Architecture = auto

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
ILoveCandy
DisableDownloadTimeout
Color
#NoProgressBar
CheckSpace
#VerbosePkgLists
ParallelDownloads = 10
DownloadUser = alpm
#DisableSandboxFilesystem
#DisableSandboxSyscalls

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required


#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

#[core-testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

#[extra-testing]
#Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist


# If you want to run 32 bit applications on your x86_64 system,
# enable the multilib repositories as required here.

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs
" > /etc/pacman.conf

swapoff /dev/sda*

umount -lRA /dev/sda*

umount -RA /dev/sda*

# I'm using GPT not MBR please visit the archwiki for MBR.

parted /dev/sda --script mklabel gpt

parted /dev/sda --script mkpart "EFI" fat32 1MiB 1025MiB set 1 esp on

parted /dev/sda --script mkpart "swap" linux-swap 1025MiB 9217MiB

parted /dev/sda --script mkpart "Linux" btrfs 9217MiB 100%
#I'm using fat 32 for GRUB.
mkfs.vfat -F 32 /dev/sda1
# I'm using swap you can remove the command if you not useing swap.
mkswap -f /dev/sda2
# I'm using btrfs you can rebles the mkfs.btrfs to mkfs.ext4.
mkfs.btrfs -f /dev/sda3

mount /dev/sda3 /mnt

swapon /dev/sda2

mount --mkdir /dev/sda1 /mnt/boot
# Install essential packages
pacstrap -K /mnt base linux linux-firmware

# Fstab generate an fstab file.
genfstab -U /mnt >> /mnt/etc/fstab

# I don't know how to change the terminal without aborting the archinstall script.
arch-chroot /mnt bash -c "

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime;

hwclock --systohc;

echo -e "de_DE.UTF-8\ UTF-8" >> /etc/locale.gen;

locale-gen;

echo -e "de_DE.UTF-8" > /etc/locale.conf;

echo -e "KEYMAP=de-latin1" >  /etc/vconsole.conf;

echo -e "archlinux" >  /etc/hostname;


yes | pacman -Syyu networkmanager sudo git grub nano efibootmgr plasma plasma-login-manager  acpid avahi iwd fish --disable-download-timeout --noconfirm;

systemctl enable acpid avahi-daemon NetworkManager iwd systemd-timesyncd fstrim.timer plasmalogin.service;

mkinitcpio -P;

passwd;

useradd -m -g users -s /bin/fish user;

passwd user;

usermod -aG wheel,users user;

grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=GRUB;

grub-mkconfig -o /boot/grub/grub.cfg"

umount -R /mnt

reboot now

