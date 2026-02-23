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

# You need maybe too change the sda to your sdd. You can shen your sdd or hdd withe "fdisk -l"

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

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime;

hwclock --systohc;

echo -e "de_DE.UTF-8\ UTF-8" >> /etc/locale.gen;

locale-gen;

echo -e "de_DE.UTF-8" > /etc/locale.conf;

echo -e "KEYMAP=de-latin1" >  /etc/vconsole.conf;

echo -e "archlinux" >  /etc/hostname;

yes | pacman -Syyu networkmanager --disable-download-timeout --noconfirm;

yes | pacman -Syyu dolphin --disable-download-timeout --noconfirm;

yes | pacman -Syyu ark --disable-download-timeout --noconfirm;

yes | pacman -Syyu konsole --disable-download-timeout --noconfirm;

yes | pacman -Syyu sudo --disable-download-timeout --noconfirm;

yes | pacman -Syyu git --disable-download-timeout --noconfirm;

yes | pacman -Syyu grub --disable-download-timeout --noconfirm;

yes | pacman -Syyu nano --disable-download-timeout --noconfirm;

yes | pacman -Syyu efibootmgr --disable-download-timeout --noconfirm;

yes | pacman -Syyu plasma --disable-download-timeout --noconfirm;

yes | pacman -Syyu plasma-login-manager --disable-download-timeout --noconfirm;

yes | pacman -Syyu acpid --disable-download-timeout --noconfirm;

yes | pacman -Syyu avahi --disable-download-timeout --noconfirm;

yes | pacman -Syyu iwd --disable-download-timeout --noconfirm;

yes | pacman -Syyu fish --disable-download-timeout --noconfirm;

yes | pacman -Syyu gamemode --disable-download-timeout --noconfirm;

yes | pacman -Syyu gamescope --disable-download-timeout --noconfirm;

yes | pacman -Syyu fastfetch --disable-download-timeout --noconfirm;

yes | pacman -Syyu steam --disable-download-timeout --noconfirm;

yes | pacman -Syyu discord --disable-download-timeout --noconfirm;

yes | pacman -Syyu firefox --disable-download-timeout --noconfirm;

yes | pacman -Syyu bash coreutils  curl  dbus  desktop-file-utils  diffutils  freetype2  gcc-libs gdk-pixbuf2  glibc  hicolor-icon-theme  libxcrypt  libxcrypt-compat  libxkbcommon-x11 lsb-release  lsof  nss  python  ttf-font  usbutils  vulkan-driver  vulkan-icd-loader xdg-user-dirs  xorg-xrandr  xz  zenity  steam-devices  lib32-alsa-plugins lib32-fontconfig  lib32-gcc-libs  lib32-glibc  lib32-libgl  lib32-libgpg-error lib32-libnm  lib32-libva  lib32-libx11  lib32-libxcrypt  lib32-libxcrypt-compat lib32-libxinerama  lib32-libxss  lib32-nss  lib32-pipewire  lib32-systemd lib32-vulkan-driver  lib32-vulkan-icd-loader --disable-download-timeout --noconfirm;


chsh -s /bin/fish

systemctl enable acpid avahi-daemon NetworkManager iwd systemd-timesyncd fstrim.timer plasmalogin.service;

mkinitcpio -P;

passwd;

useradd -m -g users -s /bin/fish user;

passwd user;

usermod -aG wheel,users user;

grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=GRUB;

grub-mkconfig -o /boot/grub/grub.cfg"

echo -e "

## sudoers file.
##
## This file MUST be edited with the 'visudo' command as root.
## Failure to use 'visudo' may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##

##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3

##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef

##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
#
# Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
#
# Cmnd_Alias	DEBUGGERS = /usr/bin/gdb, /usr/bin/lldb, /usr/bin/strace, \
# 			    /usr/bin/truss, /usr/bin/bpftrace, \
# 			    /usr/bin/dtrace, /usr/bin/dtruss
#
# Cmnd_Alias	PKGMAN = /usr/bin/apt, /usr/bin/dpkg, /usr/bin/rpm, \
# 			 /usr/bin/yum, /usr/bin/dnf,  /usr/bin/zypper, \
# 			 /usr/bin/pacman

##
## Defaults specification
##
## Preserve editor environment variables for visudo.
## To preserve these for all commands, remove the "!visudo" qualifier.
Defaults!/usr/bin/visudo env_keep += "SUDO_EDITOR EDITOR VISUAL"
##
## Use a hard-coded PATH instead of the user's to find commands.
## This also helps prevent poorly written scripts from running
## arbitrary commands under sudo.
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/bin"
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers' ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to disable "use_pty" when running commands as root.
## Commands run as non-root users will run in a pseudo-terminal,
## not the user's own terminal, to prevent command injection.
# Defaults>root !use_pty
##
## Uncomment to run commands in the background by default.
## This can be used to prevent sudo from consuming user input while
## a non-interactive command runs if "use_pty" or I/O logging are
## enabled.  Some commands may not run properly in the background.
# Defaults exec_background
##
## Uncomment to send mail if the user does not enter the correct password.
# Defaults mail_badpass
##
## Uncomment to enable logging of a command's output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
## Sudo will create up to 2,176,782,336 I/O logs before recycling them.
## Set maxseq to a smaller number if you don't have unlimited disk space.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!REBOOT !log_output
# Defaults maxseq = 1000
##
## Uncomment to disable intercept and log_subcmds for debuggers and
## tracers.  Otherwise, anything that uses ptrace(2) will be unable
## to run under sudo if intercept_type is set to "trace".
# Defaults!DEBUGGERS !intercept, !log_subcmds
##
## Uncomment to disable intercept and log_subcmds for package managers.
## Some package scripts run a huge number of commands, which is made
## slower by these options and also can clutter up the logs.
# Defaults!PKGMAN !intercept, !log_subcmds
##
## Uncomment to disable PAM silent mode.  Otherwise messages by PAM
## modules such as pam_faillock will not be printed.
# Defaults !pam_silent

##
## Runas alias specification
##

##
## User privilege specification
##
root ALL=(ALL:ALL) ALL

## Uncomment to allow members of group wheel to execute any command
 %wheel ALL=(ALL:ALL) ALL

## Same thing without a password
# %wheel ALL=(ALL:ALL) NOPASSWD: ALL

## Uncomment to allow members of group sudo to execute any command
# %sudo ALL=(ALL:ALL) ALL

## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL:ALL) ALL  # WARNING: only use this together with 'Defaults targetpw'

## Read drop-in files from /etc/sudoers.d
@includedir /etc/sudoers.d


" > /mnt/etc/sudoers

umount -R /mnt

reboot now
