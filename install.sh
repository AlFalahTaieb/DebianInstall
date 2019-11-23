#############BASICS#############

echo "*** OK, let's go ! ***"
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
echo "**Installing, Packages***"
apt-get install curl git keepassxc transmission-qt firefox-esr rofi neofetch \
scrot feh compton zathura lxappearance wicd wicd-gtk kitty pulseaudio pavucontrol \
jq xbacklight rofi cmus ffmpeg dmenu dunst zeal p7zip

echo "** SSD Optimization **"
## SSD Optimization  https://wiki.debian.org/SSDOptimization 
cp /usr/share/doc/util-linux/examples/fstrim.{service,timer} /etc/systemd/system
systemctl enable fstrim.timer
systemctl start fstrim.timer

echo "** Packages related to i3-gaps **"
## Before Installing i3-gaps
apt-get install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb \
    libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
    libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
    libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
    libxcb-xrm0 libxcb-xrm-dev autoconf  xutils-dev libtool automake  libxcb-shape0-dev \

    
echo "** Installing i3-gaps **"
## install i3-gaps 
cd tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install


echo "** Installing Spotify **"
# spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg |  apt-key add -
echo deb http://repository.spotify.com stable non-free |  tee /etc/apt/sources.list.d/spotify.list
apt-get update
apt-get install spotify-client

echo "** Installing Papirus Icons **"
# Papirus Icon
add-apt-repository ppa:papirus/papirus
apt install papirus-icon-theme -yy

echo "** Fixing touchpads **"
# Touchpad settings
tee /usr/share/X11/xorg.conf.d/41-libinput-custom.conf <<EOF
Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
EOF

echo '** Updating Grub **'
# Grub update for boot load screen
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=nomsi,noaer"/' /etc/default/grub
update-grub

sleep 5
reboot
