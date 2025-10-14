# linux-musl

Linux [musl](https://musl.cc/) cross toolchain Docker images, built with [musl-cross-make](https://github.com/richfelker/musl-cross-make/). The toolchain binaries are dynamically linked.

The images are volume-only `scratch` images, and have no OS.

## Use

A few docker images have been published to [Bitshock](https://hub.docker.com/u/bitshock) docker hub:

* `bitshock/x86_64-linux-musl-ubuntu-24.04` for `linux/amd64` / `linux/arm64` 
* `bitshock/aarch64-linux-musl-ubuntu-24.04` for `linux/amd64` / `linux/arm64`

### Target x86_64 for Ubuntu

To target x86_64-linux-musl:

``` dockerfile
FROM bitshock/x86_64-linux-musl-ubuntu-24.04:latest AS musl

FROM ubuntu:24.04 AS builder

COPY --from=musl /musl /opt/x86_64-linux-musl

RUN export PATH=/opt/x86_64-linux-musl/bin:$PATH

```

### Target aarch64 for Ubuntu

To target aarch64-linux-musl:

``` dockerfile
FROM bitshock/aarch64-linux-musl-ubuntu-24.04:latest AS musl

FROM ubuntu:24.04 AS builder

COPY --from=musl /musl /opt/aarch64-linux-musl

RUN export PATH=/opt/aarch64-linux-musl/bin:$PATH

```

## Build

Set the `TARGET` build arg to target the musl target. See  [musl-cross-make](https://github.com/richfelker/musl-cross-make/) for a list of available targets.

Use `--platform` to set the compiler host architecture. 

Example:

``` shell
docker buildx build --platform linux/amd64,linux/arm64 --build-arg TARGET=x86_64-linux-musl --load -t x86_64-linux-musl -f ubuntu.Dockerfile . 
```