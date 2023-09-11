FROM ubuntu:mantic

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --force-yes sed cpio curl tar zstd libssl-dev openssl libxml2 which bc gawk perl diffutils make python3 xz-utils bison flex git unzip

WORKDIR /build

RUN mkdir tc && cd tc && curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/09092023/neutron-clang-09092023.tar.zst && tar -I zstd -xf clang.tar.zst && cd ..

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --force-yes sed cpio curl tar zstd libssl-dev openssl libxml2 which bc gawk perl diffutils make python3 xz-utils bison flex git unzip

ENV TC_BIN = /build/tc/bin

