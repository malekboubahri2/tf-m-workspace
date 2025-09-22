
#Supported version by tf-m: Ubuntu 18.04 x64+
FROM ubuntu:22.04

#Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    libssl-dev \
    python3 \
    python3-pip \
    python3-venv \
    cmake \
    make \
    ninja-build   \
    gdb \
    libusb-1.0-0 \
    libncurses5 \
    usbutils \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Export CMake path
ENV PATH="/opt/$(ls /opt | grep cmake | head -n1)/bin:${PATH}"

#Install ARM GCC toolchain
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 \
    && tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /opt \
    && rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

ENV PATH="/opt/gcc-arm-none-eabi-10.3-2021.10/bin:${PATH}"