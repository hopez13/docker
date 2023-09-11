FROM ubuntu:mantic AS initial
WORKDIR /tc
RUN apt-get update -y && apt install -y curl tar zstd
RUN curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/09092023/neutron-clang-09092023.tar.zst && \
tar -I zstd -xf clang.tar.zst && \
rm -rf /tc/share && \
rm -rf /tc/lib/cmake && \
rm -f /tc/lib/libclang-cpp.so.18git && \
rm -f /tc/lib/LLVMgold.so && \
rm -f clang.tar.zst

FROM ubuntu:mantic
WORKDIR /build
COPY --from=initial /tc /build/tc
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
apt-get install --force-yes -y sed cpio curl tar zstd libssl-dev openssl libxml2 \
which bc gawk perl diffutils make python3 xz-utils bison flex git unzip && \
apt autoremove && apt clean && \
rm -rf /usr/share/man/* && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/lib/apt/archives/* && \
rm -rf /var/lib/apt/caches/*

ENV TC_BIN = /build/tc/bin
