ARG UBI_IMAGE=registry.access.redhat.com/ubi7/ubi-minimal:latest
ARG GO_IMAGE=goboring/golang:1.10.3b4

FROM ${UBI_IMAGE} as ubi

FROM ${GO_IMAGE} as builder
RUN apt update                         && \
    apt upgrade -y                     && \
    apt install -y ca-certificates git

RUN git clone --depth=1 https://github.com/coreos/flannel.git /go/src/github.com/coreos/flannel

WORKDIR /go/src/github.com/coreos/flannel

RUN git fetch --all --tags --prune       && \
    git checkout tags/v0.12.0 -b v0.12.0 && \
    CGO_ENABLED=1 make dist/flanneld

FROM ubi
RUN microdnf update -y && \
    rm -rf /var/cache/yum

COPY --from=builder /go/src/github.com/coreos/flannel/dist/flanneld /usr/local/bin
