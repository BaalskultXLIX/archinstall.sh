# WARNING Please read my archinstall kommins and sorry for my bad english.
# WARNING I'm not a linux pro.
# WARNING This archinstall is for the archlinux live iso you cant damang your system
# WARNING This archinstall is for my pc i have a full amd system.
# WARNING This is my first archinstall.
# WARNING When you use a old PC or slow internet please do not use my sript
# You need to stetup your Wifi your self. I dont know how do dish on Iwctl withe a command. I know how to stetup Iwctl but i dont now your wifi and password :C.

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

echo "de_DE.UTF-8\ UTF-8" >> /etc/locale.gen;

locale-gen;

echo "de_DE.UTF-8" > /etc/locale.conf;

echo "KEYMAP=de-latin1" >  /etc/vconsole.conf;

echo "archlinux" >  /etc/hostname;

yes | pacman -Syyu networkmanager grub nano efibootmgr plasma plasma-login-manager  acpid avahi iwd fish --disable-download-timeout --noconfirm;

systemctl enable acpid avahi-daemon NetworkManager iwd systemd-timesyncd fstrim.timer plasmalogin.service;

mkinitcpio -P;

passwd;

useradd -m -g users -s /bin/fish user;

passwd user; usermod -aG wheel,users user;

grub-install --target=x86_64-efi --efi-directory=boot/ --bootloader-id=GRUB;

grub-mkconfig -o /boot/grub/grub.cfg"

umount -R /mnt

reboot now
