FROM quay.io/fedora-ostree-desktops/silverblue:40

RUN rm /etc/yum.repos.d/fedora-cisco-openh264.repo && \
    rm /etc/yum.repos.d/google-chrome.repo && \
    rm /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo && \
    rm /etc/yum.repos.d/rpmfusion-nonfree-steam.repo

RUN rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    ostree container commit

RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

RUN rpm-ostree override remove ffmpeg-free google-noto-sans-cjk-vf-fonts default-fonts-cjk-sans libavcodec-free libavdevice-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free mesa-va-drivers && \
    rpm-ostree install virt-manager sysprof rsms-inter-fonts stow alsa-firmware ffmpeg ffmpeg-libs ffmpegthumbnailer flatpak-spawn heif-pixbuf-loader intel-media-driver libheif-freeworld libheif-tools libva-intel-driver libva-utils mesa-va-drivers-freeworld.x86_64 net-tools nvme-cli zstd wireguard-tools adw-gtk3-theme gnome-epub-thumbnailer gnome-tweaks gvfs-nfs google-noto-sans-balinese-fonts google-noto-sans-cjk-fonts google-noto-sans-javanese-fonts google-noto-sans-sundanese-fonts && \
    ostree container commit

# ADD playbook.yml .

# RUN rpm-ostree install ansible && \
#     # ansible-galaxy collection install community.general && \
#     ansible-playbook playbook.yml && \
#     rpm -e ansible && \
#     ostree container commit