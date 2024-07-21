FROM quay.io/fedora-ostree-desktops/silverblue:40

RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo && \
    rm /etc/yum.repos.d/google-chrome.repo && \
    rm /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo && \
    rm /etc/yum.repos.d/rpmfusion-nonfree-steam.repo

RUN rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    ostree container commit

RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# RUN rpm-ostree override remove ffmpeg-free google-noto-sans-cjk-vf-fonts default-fonts-cjk-sans libavcodec-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free mesa-va-drivers mesa-vdpau-drivers && \
#     rpm-ostree install virt-manager sysprof rsms-inter-fonts stow alsa-firmware ffmpeg ffmpeg-libs ffmpegthumbnailer flatpak-spawn heif-pixbuf-loader intel-media-driver libheif-freeworld libheif-tools libva-utils mesa-va-drivers-freeworld.x86_64 mesa-vdpau-drivers-freeworld.x86_64 mesa-filesystem net-tools nvme-cli zstd wireguard-tools adw-gtk3-theme gnome-epub-thumbnailer gnome-tweaks gvfs-nfs google-noto-sans-balinese-fonts google-noto-sans-cjk-fonts google-noto-sans-javanese-fonts google-noto-sans-sundanese-fonts && \
#     ostree container commit

RUN rpm-ostree override remove \
google-noto-sans-cjk-vf-fonts default-fonts-cjk-sans \
libavdevice-free libavcodec-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free mesa-va-drivers ffmpeg-free && \
# From https://rpmfusion.org/Howto/OSTree#Software_codecs
rpm-ostree install \
virt-manager \
steam-devices \
stow \
alsa-firmware pipewire-codec-aptx \
ffmpeg ffmpeg-libs ffmpegthumbnailer \
flatpak-builder\
intel-media-driver \
libheif-freeworld libheif-tools heif-pixbuf-loader \
libva-utils gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi \
mesa-va-drivers-freeworld.x86_64 mesa-vdpau-drivers-freeworld.x86_64 mesa-filesystem \
nvme-cli \
zstd \
wireguard-tools net-tools \
adw-gtk3-theme gnome-epub-thumbnailer gnome-tweaks gvfs-nfs sysprof \
rsms-inter-fonts google-noto-sans-balinese-fonts google-noto-sans-cjk-fonts google-noto-sans-javanese-fonts google-noto-sans-sundanese-fonts && \
ostree container commit

# FOR NVIDIA libva-nvidia-driver

# ADD playbook.yml .

# RUN rpm-ostree install ansible && \
#     # ansible-galaxy collection install community.general && \
#     ansible-playbook playbook.yml && \
#     rpm -e ansible && \
#     ostree container commit