FROM ubuntu:24.04  AS builder

ARG TARGET

WORKDIR /

RUN apt update -y && \
apt upgrade -y && \
apt install git build-essential wget texinfo -y && \
git clone https://github.com/richfelker/musl-cross-make.git /musl-cross-make

WORKDIR /musl-cross-make

RUN TARGET=${TARGET} make && \
    TARGET=${TARGET} make install OUTPUT=/musl

FROM scratch

COPY --from=builder /musl /musl
