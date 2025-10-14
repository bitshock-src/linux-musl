# linux-musl

Linux [musl](https://musl.cc/) cross toolchain Docker images, built with [musl-cross-make](https://github.com/richfelker/musl-cross-make/). The toolchain binaries are dynamically linked.

The images are volume-only `scratch` images, and have no OS.

## Use

A few docker images have been published to [Bitshock](https://hub.docker.com/u/bitshock) docker hub:

* x86_64-linux-musl, linux/arm64 platform only
* aarch64-linux-musl, linux/amd64 platform only

When compiling with a target that matches the platform, use your distro's musl packages, not one of these images.

### Target x86_64 for Ubuntu

To target x86_64-linux-musl when compiling on linux/arm64:

``` dockerfile
FROM bitshock/x86_64-linux-musl-ubuntu-24.04:latest AS musl

FROM ubuntu:24.04 AS builder

COPY --from=musl /musl /opt/x86_64-linux-musl

RUN export PATH=/opt/x86_64-linux-musl/bin:$PATH

```

### Target aarch64 for Ubuntu

To target aarch64-linux-musl when compiling on linux/amd64:

``` dockerfile
FROM bitshock/aarch64-linux-musl-ubuntu-24.04:latest AS musl

FROM ubuntu:24.04 AS builder

COPY --from=musl /musl /opt/aarch64-linux-musl

RUN export PATH=/opt/aarch64-linux-musl/bin:$PATH

```

## Build

Set the `TARGET` build arg to target the musl target. See  [musl-cross-make](https://github.com/richfelker/musl-cross-make/) for a list of available targets.

Use `--platform` to set the compiler host architecture. You most likely won't need an architecture that matches  `TARGET`, as your distro most likely already supplies it.

Example:

``` shell
docker buildx build --platform linux/arm64 --build-arg TARGET=x86_64-linux-musl --load -t x86_64-linux-musl . 
```