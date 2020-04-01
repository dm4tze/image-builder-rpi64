FROM hypriot/image-builder:latest

ENV HYPRIOT_OS_VERSION=dirty \
    RAW_IMAGE_VERSION=v0.3.2

#Note that the checksums and build timestamps only apply when fetching missing
#artifacts remotely is enabled to validate downloaded remote artifacts
ENV FETCH_MISSING_ARTIFACTS=true \
    ROOT_FS_ARTIFACT=rootfs-arm64-debian-$HYPRIOT_OS_VERSION.tar.gz \
    KERNEL_ARTIFACT=4.19.58-hypriotos-v8.tar.gz \
    RPI4_KERNEL_ARTIFACT=bcm2711-kernel-bis \
    BOOTLOADER_ARTIFACT=rpi-bootloader.tar.gz \
    RAW_IMAGE_ARTIFACT=rpi-raw.img.zip \
    DOCKER_ENGINE_VERSION="5:19.03.6~3-0~debian-buster" \
    CONTAINERD_IO_VERSION="1.2.10-3" \
    DOCKER_COMPOSE_VERSION="1.23.1" \
    DOCKER_MACHINE_VERSION="0.16.2" \
    KERNEL_VERSION="4.19.58" \
    ROOTFS_TAR_CHECKSUM="6b05700238db954ab44e37e66694478ec0686dd9b32488e1bb7f6564dcddffc1" \
    RAW_IMAGE_CHECKSUM="d598e20fe0d5514ffd5ee6d6745b837e4df11437e3e75b11351b475102fba297" \
    BOOTLOADER_BUILD="20190713-140339" \
    KERNEL_BUILD="20190715-111025" \
    RPI4_KERNEL_BUILD="4.19.102.20200211"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu \
    qemu-user-static \
    xz-utils \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/gruntwork-io/fetch/releases/download/v0.1.0/fetch_linux_amd64 /usr/local/bin/fetch
RUN chmod +x /usr/local/bin/fetch

COPY builder/ /builder/

# build sd card image
CMD /builder/build.sh
