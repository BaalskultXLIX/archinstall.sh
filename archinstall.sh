# WARNING Please read my archinstall kommins and sorry for my bad english.
# WARNING I'm not a linux pro.
# WARNING This archinstall is for the archlinux live iso you cant damang your system
# WARNING This archinstall is for my pc i have a full amd system.
# WARNING This is my first archinstall.
# You need to stetup your Wifi your self. I dont know how do dish on Iwctl withe a command. I know how to stetup Iwctl but i dont now your wifi and password :C.

loadkeys de-latin1
# You need to stetup your own Partitions i dont now how do that withe fdisk in a command please visit the archwiki for fdisk layouts.
# I'm using GPT not MBR please visit the archwiki for MBR.
fdisk /dev/sda
#I'm using fat 32 for GRUB.
mkfs.vfat -F 32 /dev/sda1
# I'm using swap you can remove the command if you not useing swap.
mkswap /dev/sda2
# I'm using btrfs you can rebles the mkfs.btrfs to mkfs.ext4.
mkfs.btrfs  /dev/sda3

mount /dev/sda3 /mnt

swapon /dev/sda2

mount --mkdir /dev/sda1 /mnt/boot
# Install essential packages
pacstrap -K /mnt base linux linux-firmware

# Fstab generate an fstab file.
genfstab -U /mnt >> /mnt/etc/fstab

# I don't know how to change the terminal without aborting the archinstall script.
arch-chroot /mnt bash -c " ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime;  hwclock --systohc;  echo "de_DE.UTF-8\ UTF-8" >> /etc/locale.gen; locale-gen; echo "de_DE.UTF-8" > /etc/locale.conf; echo "KEYMAP=de-latin1" >  /etc/vconsole.conf; echo "archlinux" >  /etc/hostname; pacman -Syyu networkmanager grub nano efibootmgr plasma plasma-login-manager  acpid avahi iwd fish --noconfirm; systemctl enable acpid avahi-daemon NetworkManager iwd systemd-timesyncd fstrim.timer plasmalogin.service; mkinitcpio -P; passwd; useradd -m -g users -s /bin/fish ilja; passwd ilja; usermod -aG wheel,users ilja; grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=GRUB; grub-mkconfig -o /boot/grub/grub.cfg; exit"

umount -R /mnt

reboot 
