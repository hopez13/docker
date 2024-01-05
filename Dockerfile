FROM ubuntu:mantic AS initial
WORKDIR /tc
RUN apt-get update -y && apt install -y curl tar zstd
RUN curl -Lo clang.tar.zst https://github.com/Neutron-Toolchains/clang-build-catalogue/releases/download/05012024/neutron-clang-05012024.tar.zst && \
tar -I zstd -xf clang.tar.zst && \
rm -rf /tc/lib/cmake && \
rm -f /tc/lib/libclang-cpp.so.18git && \
rm -f /tc/lib/LLVMgold.so && \
rm -f clang.tar.zst

FROM ubuntu:mantic
WORKDIR /build
COPY --from=initial /tc /build/tc
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
apt-get install --force-yes -y sed sudo cpio curl tar zstd libssl-dev openssl libxml2 \
which bc gawk perl diffutils locales make python3 xz-utils bison flex git unzip && \
apt autoremove && apt clean && \
rm -rf /usr/share/man/* && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/lib/apt/archives/* && \
rm -rf /var/lib/apt/caches/* && \
echo "LC_ALL=en_US.UTF-8" | sudo tee -a /etc/environment && \
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen && \
echo "LANG=en_US.UTF-8" | sudo tee -a /etc/locale.conf && \
sudo locale-gen en_US.UTF-8


ENV PATH "$PATH:/build/tc/bin"
