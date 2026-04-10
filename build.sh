#!/bin/bash

# Use paths without spaces to avoid shell quoting issues in configure
export PATH="/c/Qt/Tools/mingw810_64/bin:/c/BuildTools/Python312:/c/BuildTools/Python312/Scripts:/c/Program Files/Git/usr/bin:$PATH"

# Set CC so configure finds gcc instead of 'cc'
export CC=gcc
export CXX=g++

# Disable Windows Store python3 alias
# Create a symlink for python3 if it doesn't exist
if ! command -v python3 &>/dev/null || python3 --version 2>&1 | grep -q "not found"; then
  PYDIR=$(dirname "$(command -v python)")
  ln -sf "$PYDIR/python.exe" "$PYDIR/python3.exe" 2>/dev/null || true
fi

echo "=== GCC version ==="
gcc --version | head -1

echo "=== Python version ==="
python --version 2>&1

echo "=== Meson version ==="
meson --version

echo "=== Ninja version ==="
ninja --version

echo ""
echo "=== Running configure ==="

# Clean previous build
rm -rf build GNUmakefile

# Disable the Windows Store python3 alias messages
export PYTHONDONTWRITEBYTECODE=1

./configure \
  --python=/c/BuildTools/Python312/python.exe \
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
