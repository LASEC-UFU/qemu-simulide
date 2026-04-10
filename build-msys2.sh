#!/bin/bash
# Build script for qemu-simulide using MSYS2 MinGW64 environment

echo "=== GCC version ==="
gcc --version | head -1

echo "=== Python version ==="
python3 --version 2>&1

echo "=== Meson version ==="
meson --version

echo "=== Ninja version ==="
ninja --version

echo "=== pkg-config version ==="
pkg-config --version

echo ""
echo "=== Cleaning previous build ==="
rm -rf build GNUmakefile

echo ""
echo "=== Running configure ==="

./configure \
  --target-list=xtensa-softmmu \
  --extra-cflags=-fPIC \
  --disable-attr \
  --disable-auth-pam \
  --disable-avx2 \
  --disable-avx512bw \
  --disable-blkio \
  --disable-bochs \
  --disable-bpf \
  --disable-brlapi \
  --disable-bzip2 \
  --disable-canokey \
  --disable-cap-ng \
  --disable-capstone \
  --disable-cloop \
  --disable-cocoa \
  --disable-colo-proxy \
  --disable-coreaudio \
  --disable-crypto-afalg \
  --disable-curl \
  --disable-curses \
  --disable-dbus-display \
  --disable-dmg \
  --disable-docs \
  --disable-dsound \
  --disable-fuse \
  --disable-fuse-lseek \
  --disable-gcrypt \
  --disable-gettext \
  --disable-gio \
  --disable-glusterfs \
  --disable-gnutls \
  --disable-gtk \
  --disable-gtk-clipboard \
  --disable-guest-agent \
  --disable-guest-agent-msi \
  --disable-hvf \
  --disable-iconv \
  --disable-jack \
  --disable-keyring \
  --disable-kvm \
  --disable-l2tpv3 \
  --disable-libdaxctl \
  --disable-libdw \
  --disable-libiscsi \
  --disable-libkeyutils \
  --disable-libnfs \
  --disable-libpmem \
  --disable-libssh \
  --disable-libudev \
  --disable-libusb \
  --disable-libvduse \
  --disable-linux-aio \
  --disable-linux-io-uring \
  --disable-lzfse \
  --disable-lzo \
  --disable-malloc-trim \
  --disable-membarrier \
  --disable-modules \
  --disable-mpath \
  --disable-multiprocess \
  --disable-netmap \
  --disable-nettle \
  --disable-numa \
  --disable-nvmm \
  --disable-opengl \
  --disable-oss \
  --disable-pa \
  --disable-parallels \
  --disable-pipewire \
  --disable-png \
  --disable-qcow1 \
  --disable-qed \
  --disable-qga-vss \
  --disable-rbd \
  --disable-rdma \
  --disable-replication \
  --disable-sdl \
  --disable-sdl-image \
  --disable-seccomp \
  --disable-selinux \
  --disable-smartcard \
  --disable-snappy \
  --disable-sndio \
  --disable-sparse \
  --disable-spice \
  --disable-spice-protocol \
  --disable-stack-protector \
  --disable-tcg \
  --disable-tools \
  --disable-tpm \
  --disable-u2f \
  --disable-usb-redir \
  --disable-vde \
  --disable-vdi \
  --disable-vhdx \
  --disable-vhost-crypto \
  --disable-vhost-kernel \
  --disable-vhost-net \
  --disable-vhost-user \
  --disable-vhost-vdpa \
  --disable-virglrenderer \
  --disable-virtfs \
  --disable-vmdk \
  --disable-vmnet \
  --disable-vnc \
  --disable-vnc-jpeg \
  --disable-vnc-sasl \
  --disable-vpc \
  --disable-vte \
  --disable-vvfat \
  --disable-whpx \
  --disable-xen \
  --disable-xkbcommon \
  --disable-zstd \
  --disable-system \
  --disable-user \
  --disable-linux-user \
  --disable-bsd-user \
  --disable-pie \
  --disable-debug-tcg \
  --disable-werror \
  --disable-alsa \
  --disable-debug-info \
  --enable-tcg \
  --enable-system \
  --enable-gcrypt

if [ $? -ne 0 ]; then
  echo "ERROR: configure failed!"
  exit 1
fi

echo ""
echo "=== Running ninja build ==="
ninja -C build

if [ $? -ne 0 ]; then
  echo "ERROR: build failed!"
  exit 1
fi

echo ""
echo "=== Build completed successfully! ==="
