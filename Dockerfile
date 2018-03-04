FROM ubuntu:16.04

RUN apt-get update \
    &&  apt-get install -y build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake

RUN git clone https://github.com/z-classic/zclassic.git

RUN cd zclassic \
    && ./zcutil/build.sh -j$(nproc) \
    && ./zcutil/fetch-params.sh

VOLUME ["$HOME/.zclassic/zclassic.conf"]

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
