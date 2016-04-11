# Building Beats on OpenBSD

This repo contains a few helper scripts I use for building [Elastic](https://elastic.co)
[Beats](https://www.elastic.co/products/beats) on OpenBSD.

## Usage

Due to the fact that Cgo is used heavily we'll have to build the beats on
their proper platforms so as not to deal with GCC cross-compile toolchains.

If you building for a single platform/architecture this will suffice:

```
make build
make tar
```

Otherwise you'll have to run `make build` on each and copy out the binaries into
the `obj` directory on the machine where you'll be running the tar step.
