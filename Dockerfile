FROM archlinux

USER  root
SHELL ["bash","-c"]
RUN   echo -e 'Build date: '$(date) > /etc/image_version

ENV pacman_packages='acl adobe-source-code-pro-fonts adwaita-icon-theme alsa-lib alsa-topology-conf alsa-ucm-conf android-sdk android-sdk-platform-tools android-udev aosp-devel arch-install-scripts archlinux-keyring argon2 arm-linux-gnueabi-binutils arm-linux-gnueabi-gcc at-spi2-atk at-spi2-core atk attr audiofile audit autoconf automake avahi base bash bc binutils bison bpf brotli bzip2 ca-certificates ca-certificates-mozilla ca-certificates-utils cairo cantarell-fonts ccache cgroup_event_listener clang colord compiler-rt coreutils cpupower cracklib cryptsetup curl daemonize db dbus dconf desktop-file-utils device-mapper diffutils double-conversion e2fsprogs elfutils esd-oss expat fakeroot file filesystem findutils fish flac flex fontconfig freetype2 fribidi gawk gc gcc gcc-libs gd gdbm gdk-pixbuf2 gettext giflib git glib-networking glib2 glibc gmp gnupg gnuplot gnutls go gperf gpgme gpm graphite grep groff gsettings-desktop-schemas gst-plugins-base-libs gstreamer gtk-update-icon-cache gtk2 gtk3 guile gzip harfbuzz hicolor-icon-theme htop hwids hyperv iana-etc icu inetutils iproute2 iptables iputils iso-codes java-environment-common java-runtime-common jdk-openjdk jdk8-openjdk jre-openjdk jre-openjdk-headless jre8-openjdk jre8-openjdk-headless js60 json-c json-glib kbd keyutils kmod krb5 lcms2 less lib32-attr lib32-fakeroot lib32-gcc-libs lib32-glibc lib32-libcap lib32-libgcrypt lib32-libgpg-error lib32-libltdl lib32-libpng lib32-libusb lib32-libusb-compat lib32-ncurses lib32-ncurses5-compat-libs lib32-readline lib32-systemd lib32-xz lib32-zlib libarchive libassuan libcanberra libcap libcap-ng libcerf libcroco libcups libdaemon libdatrie libdrm libedit libelf libepoxy libevdev libevent libffi libgcrypt libglvnd libgpg-error libgudev libgusb libice libidn2 libinput libjpeg-turbo libksba libldap libluv libmicrohttpd libmnl libmpc libmtp libnet libnetfilter_conntrack libnfnetlink libnftnl libnghttp2 libnl libnotify libnsl libogg libomxil-bellagio libp11-kit libpcap libpciaccess libpng libproxy libpsl librsvg libsasl libseccomp libsecret libsm libsoup libssh libssh2 libtasn1 libtermkey libthai libtiff libtirpc libtool libtraceevent libunistring libunwind libusb libusb-compat libutempter libutil-linux libuv libvorbis libvterm libwacom libwebp libwrap libx11 libxau libxcb libxcomposite libxcursor libxdamage libxdmcp libxext libxfixes libxft libxi libxinerama libxkbcommon libxkbcommon-x11 libxml2 libxmu libxpm libxrandr libxrender libxshmfence libxslt libxt libxtst libxv libxxf86vm licenses linux-api-headers linux-tools-meta lld llvm-libs lm_sensors lua luajit lz4 lzo m4 make md4c mesa mpfr msgpack-c mtdev nano ncurses ncurses5-compat-libs neofetch neovim nettle npth nspr nss numactl openssl orc p11-kit p7zip pacman pacman-mirrorlist pam pambase pango patch pciutils pcre pcre2 perf perl perl-error perl-mailtools perl-switch perl-timedate pinentry pixman pkgconf pkgfile pngcrush polkit popt procps-ng progress psmisc python python-appdirs python-cachecontrol python-chardet python-colorama python-contextlib2 python-distlib python-distro python-html5lib python-idna python-msgpack python-ordered-set python-packaging python-pep517 python-pip python-progress python-pyparsing python-requests python-resolvelib python-retrying python-setuptools python-six python-toml python-urllib3 python-webencodings python2 python2-appdirs python2-backports python2-configparser python2-contextlib2 python2-distlib python2-filelock python2-importlib-metadata python2-importlib_resources python2-ordered-set python2-packaging python2-pathlib2 python2-pyparsing python2-scandir python2-setuptools python2-six python2-typing python2-virtualenv python2-wheel python2-zipp qt5-base qt5-svg readline repo rest rsync schedtool sdl sed shadow shared-mime-info slang sound-theme-freedesktop sqlite squashfs-tools sudo sysfsutils systemd systemd-libs systemd-sysvcompat tar tcp-wrappers tdb termcap texinfo tmate tmon tmux tslib ttf-droid turbostat tzdata unibilium unzip usbip util-linux vim vim-runtime wayland wayland-protocols wget which wxgtk-common wxgtk2 wxgtk3 x86_energy_perf_policy xcb-proto xcb-util xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm xcur2png xdg-utils xkeyboard-config xorg-xprop xorg-xset xorgproto xxhash xz yay-git zip zlib zstd'

# User
RUN useradd ww -md /ww \
&&  echo 'ww ALL=NOPASSWD:ALL'>>/etc/sudoers \
# Pacman
&&	curl -Ls https://raw.githubusercontent.com/koumaza/docker-android_archlinux/master/pacman.conf > /etc/pacman.conf \
&&	pacman -Syyuu --needed --noconfirm base base-devel go git ed \
&&	su ww -c "cd ~/ && git clone --depth=1 --single-branch https://aur.archlinux.org/yay-git.git yay-git/ && cd yay-git/ && yes|makepkg -si" && cd \
# Yay
&&	su ww -c "cd ~/ && yay -Syy --needed --noconfirm $(echo ${pacman_packages}|tr ' ' ' ') && yes|yay -Scccc" && cd
