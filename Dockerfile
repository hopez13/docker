FROM ubuntu:mantic AS initial
RUN apt-get update -y && apt install -y curl tar zstd
WORKDIR /tc
RUN curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/09092023/neutron-clang-09092023.tar.zst && tar -I zstd -xf clang.tar.zst && rm -f clang.tar.zst

FROM ubuntu:mantic
WORKDIR /build
COPY --from=initial /tc /build/tc
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y sed cpio curl tar zstd libssl-dev openssl libxml2 which bc gawk perl diffutils make python3 xz-utils bison flex git unzip && \
 sudo apt autoremove && sudo apt clean && rm -rf /usr/share/man/* && rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/archives/* && rm -rf /var/lib/apt/caches/* && rm -rf /build/tc/share && rm -rf /build/tc/lib/cmake && rm -f /build/tc/lib/libclang-cpp.so.18git && rm -f /build/tc/lib/LLVMgold.so

ENV TC_BIN = /build/tc/bin
