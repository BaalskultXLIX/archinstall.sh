#!/bin/bash
# archinstall-my-setup.sh - Automated Arch Linux installation script for my setup
# Copyright (c) 2026 BaalskultXLIX
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.

# WARNING This is my setup script for my setup do not use it please

# WARNING Please read my archinstall kommins and sorry for my bad english.
# WARNING I'm not a linux pro.
# WARNING This archinstall is for the archlinux live iso you cant damang your system
# WARNING This archinstall is for my pc i have a full amd system.
# WARNING This is my first archinstall.
# WARNING When you use a old PC or slow internet please do not use my sript
# You need to stetup your Wifi your self. I dont know how do dish on Iwctl withe a command. I know how to stetup Iwctl but i dont now your wifi and password :C.

# You need maybe git to clone the archinstll shell script
# You can install git on the live iso
# pacman -Sy git

# I remove yay because in the live iso it dont work. It might work, but you'll just create more work for yourself. It's simpler after installing and setting up Arch Linux. You need too boot fist in the system then you can install yay hier are the commands to install yay:
# sudo pacman -Syu
# sudo pacman -S --needed base-devel git go
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

# You need maybe too change the sda to your sdd. You can see your sdd or hdd withe "fdisk -l"

echo -e "

de_DE.UTF-8\ UTF-8

" >> /etc/locale.gen

locale-gen

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

hwclock --systohc

localectl --no-convert set-keymap de-latin1

localectl --no-convert set-x11-keymap de de

localectl --no-convert set-locale LANG=de_DE.UTF-8

echo -e "

LANG=de_DE.UTF-8
LANGUAGE=de_DE
#LC_COLLATE=C
LC_TIME=de_DE.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_CTYPE=de_DE.UTF-8
LC_MESSAGES=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_ALL=

" > /etc/locale.conf

echo -e "KEYMAP=de-latin1" >  /etc/vconsole.conf

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

yes | pacman -Syyu --disable-download-timeout --noconfirm

swapoff /dev/sda*

umount -lRA /dev/sda*

umount -RA /dev/sda*

# I'm using GPT not MBR please visit the archwiki for MBR.

fdisk /dev/sda

#I'm using fat 32 for GRUB.
mkfs.vfat -F 32 /dev/sda1
# I'm using swap you can remove the command if you not useing swap.
mkswap -f /dev/sda2
# I'm using btrfs you can rebles the mkfs.btrfs to mkfs.ext4.
mkfs.btrfs -f /dev/sda3

mkfs.btrfs -f /dev/sda4

swapon /dev/sda2

mount /dev/sda3 /mnt

mount --mkdir /dev/sda1 /mnt/boot

mount --mkdir /dev/sda4 /mnt/home

# Install essential packages
pacstrap -K /mnt base linux linux-firmware

# Fstab generate an fstab file.
genfstab -U /mnt >> /mnt/etc/fstab

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

" > /mnt/etc/pacman.conf

# I don't know how to change the terminal without aborting the archinstall script.
arch-chroot /mnt bash -c "

echo -e "

de_DE.UTF-8\ UTF-8

" >> /etc/locale.gen;

locale-gen;

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime;

hwclock --systohc;

localectl --no-convert set-keymap de-latin1;

localectl --no-convert set-x11-keymap de de;

localectl --no-convert set-locale LANG=de_DE.UTF-8;

echo -e "de_DE.UTF-8" > /etc/locale.conf;

echo -e "KEYMAP=de-latin1" >  /etc/vconsole.conf;

echo -e "archlinux" >  /etc/hostname;

yes | pacman -Syyu networkmanager --disable-download-timeout --noconfirm;

yes | pacman -S dolphin --disable-download-timeout --noconfirm;

yes | pacman -S ark --disable-download-timeout --noconfirm;

yes | pacman -S konsole --disable-download-timeout --noconfirm;

yes | pacman -S sudo --disable-download-timeout --noconfirm;

yes | pacman -S git --disable-download-timeout --noconfirm;

yes | pacman -S grub --disable-download-timeout --noconfirm;

yes | pacman -S nano --disable-download-timeout --noconfirm;

yes | pacman -S efibootmgr --disable-download-timeout --noconfirm;

yes | pacman -S acpid --disable-download-timeout --noconfirm;

yes | pacman -S avahi --disable-download-timeout --noconfirm;

yes | pacman -S iwd --disable-download-timeout --noconfirm;

yes | pacman -S fish --disable-download-timeout --noconfirm;

yes | pacman -S gamemode --disable-download-timeout --noconfirm;

yes | pacman -S gamescope --disable-download-timeout --noconfirm;

yes | pacman -S fastfetch --disable-download-timeout --noconfirm;

yes | pacman -S firefox --disable-download-timeout --noconfirm;

yes | pacman -S bash coreutils  curl  dbus tesseract tesseract-data-deu desktop-file-utils  diffutils  freetype2  gcc-libs gdk-pixbuf2  glibc  hicolor-icon-theme  libxcrypt  kate libxcrypt-compat  libxkbcommon-x11 lsb-release  lsof  nss  python  ttf-font  usbutils  vulkan-driver  vulkan-icd-loader xdg-user-dirs  xorg-xrandr  xz  zenity  steam-devices  lib32-alsa-plugins lib32-fontconfig  lib32-gcc-libs  lib32-glibc  lib32-libgl  lib32-libgpg-error lib32-libnm  lib32-libva  lib32-libx11  lib32-libxcrypt  lib32-libxcrypt-compat lib32-libxinerama  lib32-libxss  lib32-nss  lib32-pipewire  lib32-systemd lib32-vulkan-driver  lib32-vulkan-icd-loader --disable-download-timeout --noconfirm;

yes | pacman -S proton-vpn-cli base-devel linux linux-headers git btrfs-progs --disable-download-timeout --noconfirm;

yes | pacman -S gparted bcachefs-tools btrfs-progs dosfstools exfatprogs f2fs-tools gpart jfsutils mtools nilfs-utils polkit udftools xfsprogs xorg-xhost --disable-download-timeout --noconfirm;

yes | pacman -S xdg-desktop-portal-impl xorg-fonts-misc flatpak --disable-download-timeout --noconfirm;

yes | pacman -S pipewire --disable-download-timeout --noconfirm;

yes | pacman -S libappindicator-gtk3 gst-plugin-pipewire pipewire-alsa pipewire-audio pipewire-ffado pipewire-jack-client pipewire-jack pipewire-libcamera pipewire-onnx pipewire-pulse pipewire-session-manager pipewire-roc pipewire-v4l2 pipewire-x11-bell pipewire-zeroconf realtime-privileges rtkit --disable-download-timeout --noconfirm;

yes | pacman -S pipewire --disable-download-timeout --noconfirm;

yes | pacman -S cups system-config-printer hplip ipp-usb logrotate colord ufw ufw-extras --disable-download-timeout --noconfirm;

yes | pacman -S scim bluez-obex dosbox gst-plugins-bad gst-plugins-good gst-plugins-ugly libgphoto2 samba sane unixodbc wine-gecko wine-mono --disable-download-timeout --noconfirm;

yes | pacman -S noto-fonts-cjk otf-ipafont ttf-liberation ttf-dejavu noto-fonts-emoji ttf-twemoji --noconfirm;

yes | pacman -S plasma --disable-download-timeout --noconfirm;

yes | pacman -S plasma-login-manager --disable-download-timeout --noconfirm;

yes | pacman -S virtualbox virtualbox-host-dkms --disable-download-timeout --noconfirm;

yes | pacman -S steam lutris vulkan-tools python-protobuf fluidsynth gvfs opencl-headers opencl-mesa lib32-gnutls xorg-xgamma gamemode python-pefile winetricks vkd3d lact lib32-vulkan-radeon vulkan-radeon --disable-download-timeout --noconfirm;

yes | pacman -S discord --disable-download-timeout --noconfirm;

yes | pacman -S gparted --disable-download-timeout --noconfirm;

yes | pacman -Rddc plasma-bigscreen --disable-download-timeout --noconfirm;

fc-cache -fv;

chsh -s /bin/fish;

systemctl enable acpid bluetooth cups avahi-daemon NetworkManager iwd systemd-timesyncd fstrim.timer plasmalogin.service;

mkinitcpio -P;

passwd;

useradd -m -g users -s /bin/fish user;

passwd user;

usermod -aG alpm,cups,gamemode,flatpak,games,vboxusers,video,wheel,log,render,scanner,sddm,users user;

grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=GRUB;

grub-mkconfig -o /boot/grub/grub.cfg"

echo -e "

## Uncomment to allow members of group wheel to execute any command
 %wheel ALL=(ALL:ALL) ALL

" >> /mnt/etc/sudoers

umount -R /mnt

reboot now 
