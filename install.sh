#############BASICS#############

echo "*** OK, let's go ! ***"

sudo apt install curl git keepassxc transmission-qt firefox-esr rofi neofetch 
scrot feh compton zathura lxappearance wicd wicd-gtk compton kitty


apt install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb \
    libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
    libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
    libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
    libxcb-xrm0 libxcb-xrm-dev autoconf ffmpeg dmenu dunst
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd /tmp/i3-gaps
autoreconf --force --install
rm -rf /tmp/i3-gaps/build
mkdir -p /tmp/i3-gaps/build
cd /tmp/i3-gaps/build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
make install
cd /home/nick/tools







# spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Touchpad settings
sudo tee /usr/share/X11/xorg.conf.d/41-libinput-custom.conf <<EOF
Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
EOF
