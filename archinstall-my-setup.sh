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

# You need to remove the # In the /etc/sudoers at the # "# %wheel ALL=(ALL:ALL) ALL" to "%wheel ALL=(ALL:ALL) ALL" this. For sudo to work.

# When you a gamer then you need to remove # in the /etc/pacman.conf at  "# [multilib]" and "# Include = /etc/pacman.d/mirrorlist" to "[multilib]" and "Include = /etc/pacman.d/mirrorlist" for Steam amd Discord.

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


yes | pacman -Syyu networkmanager dolphin ark konsole sudo git grub nano efibootmgr plasma plasma-login-manager acpid avahi iwd fish --disable-download-timeout --noconfirm;

yes | pacman -Syyu gamemod gamescope fastfetch --disable-download-timeout --noconfirm;

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

if status is-interactive
# Commands to run in interactive sessions can go here
end


" > /mnt/home/user/.config/fish/config.fish

echo -e "

# Don't edit this file, as it will be written by the web-config tool (`#fish_config`).
# To customize your theme, delete this file and see
#     help interactive#syntax-highlighting
# or
#     man fish-interactive | less +/^SYNTAX.HIGHLIGHTING
# for appropriate commands to add to ~/.config/fish/config.fish instead.

set --global fish_color_autosuggestion FFC473
set --global fish_color_cancel --reverse
set --global fish_color_command FF9400
set --global fish_color_comment A63100
set --global fish_color_cwd green
set --global fish_color_cwd_root red
set --global fish_color_end FF4C00
set --global fish_color_error FFDD73
set --global fish_color_escape 00a6b2
set --global fish_color_gray
set --global fish_color_history_current --bold
set --global fish_color_host normal
set --global fish_color_host_remote yellow
set --global fish_color_keyword
set --global fish_color_normal normal
set --global fish_color_operator 00a6b2
set --global fish_color_option
set --global fish_color_param FFC000
set --global fish_color_quote BF9C30
set --global fish_color_redirection BF5B30
set --global fish_color_search_match white --bold --background=brblack
set --global fish_color_selection white --bold --background=brblack
set --global fish_color_status red
set --global fish_color_user brgreen
set --global fish_color_valid_path --underline=single
set --global fish_pager_color_background
set --global fish_pager_color_completion normal
set --global fish_pager_color_description B3A06D
set --global fish_pager_color_prefix normal --bold --underline=single
set --global fish_pager_color_progress brwhite --bold --background=cyan
set --global fish_pager_color_secondary_background
set --global fish_pager_color_secondary_completion
set --global fish_pager_color_secondary_description
set --global fish_pager_color_secondary_prefix
set --global fish_pager_color_selected_background --background=brblack
set --global fish_pager_color_selected_completion
set --global fish_pager_color_selected_description
set --global fish_pager_color_selected_prefix

" > /mnt/home/user/.config/fish/conf.d/fish_frozen_theme.fish

echo -e "

# This file contains fish universal variable definitions.
# VERSION: 3.0
SETUVAR __fish_initialized:4300
SETUVAR __fish_webconfig_theme_notification:set\x2dtheme\x2dv1\x2d\x231

" > /mnt/home/user/.config/fish/fish_variables

echo -e "

function fish_prompt
        # This prompt shows:
        # - green lines if the last return command is OK, red otherwise
        # - your user name, in red if root or yellow otherwise
        # - your hostname, in cyan if ssh or blue otherwise
        # - the current path (with prompt_pwd)
        # - date +%X
        # - the current virtual environment, if any
        # - the current git status, if any, with fish_git_prompt
        # - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
        # - current background jobs, if any

        # It goes from:
        # ┬─[nim@Hattori:~]─[11:39:00]
        # ╰─>$ echo here

        # To:
        # ┬─[nim@Hattori:~/w/dashboard]─[11:37:14]─[V:django20]─[G:master↑1|●1✚1…1]─[B:85%, 05:41:42 remaining]
        # │ 2    15054    0%    arrêtée    sleep 100000
        # │ 1    15048    0%    arrêtée    sleep 100000
        # ╰─>$ echo there

        set -l retc red
        test $status = 0; and set retc green

        set -q __fish_git_prompt_showupstream
        or set -g __fish_git_prompt_showupstream auto

        function _nim_prompt_wrapper
                set retc $argv[1]
                set -l field_name $argv[2]
                set -l field_value $argv[3]

                set_color normal
                set_color $retc
                echo -n '─'
                set_color -o green
                echo -n '['
                set_color normal
                test -n $field_name
                and echo -n $field_name:
                set_color $retc
                echo -n $field_value
                set_color -o green
                echo -n ']'
        end

        set_color $retc
        echo -n '┬─'
        set_color -o green
        echo -n [

        if functions -q fish_is_root_user; and fish_is_root_user
                set_color -o red
        else
                set_color -o yellow
        end

        echo -n $USER
        set_color -o white
        echo -n @

        if test -z "$SSH_CLIENT"
                set_color -o blue
        else
                set_color -o cyan
        end

        echo -n (prompt_hostname)
        set_color -o white
        echo -n :(prompt_pwd)
        set_color -o green
        echo -n ']'

        # Date
        _nim_prompt_wrapper $retc '' (date +%X)

        # Vi-mode

        if test "$fish_key_bindings" = fish_vi_key_bindings
                or test "$fish_key_bindings" = fish_hybrid_key_bindings
                set -l mode
                switch $fish_bind_mode
                        case default
                                set mode (set_color --bold red)N
                        case operator f F t T
                                set mode (set_color --bold cyan)N
                        case insert
                                set mode (set_color --bold green)I
                        case replace_one
                                set mode (set_color --bold green)R
                        case replace
                                set mode (set_color --bold cyan)R
                        case visual
                                set mode (set_color --bold magenta)V
                end
                set mode $mode(set_color normal)
                _nim_prompt_wrapper $retc '' $mode
        end

        # Virtual Environment
        set -q VIRTUAL_ENV_DISABLE_PROMPT
        or set -g VIRTUAL_ENV_DISABLE_PROMPT true
        set -q VIRTUAL_ENV
        and _nim_prompt_wrapper $retc V (path basename "$VIRTUAL_ENV")

        # git
        set -l prompt_git (fish_git_prompt '%s')
        test -n "$prompt_git"
        and _nim_prompt_wrapper $retc G $prompt_git

        # Battery status
        type -q acpi
        and acpi -a 2>/dev/null | string match -rq off
        and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

        # New line
        echo

        # Background jobs
        set_color normal

        for job in (jobs)
                set_color $retc
                echo -n '│ '
                set_color brown
                echo $job
        end

        set_color normal
        set_color $retc
        echo -n '╰─>'
        set_color -o red
        echo -n '$ '
        set_color normal
end

fastfetch

" > /mnt/home/user/.config/fish/functions/fish_prompt.fish

umount -R /mnt

reboot now

