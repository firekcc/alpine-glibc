FROM alpine:3.9
MAINTAINER firekcc <lyk_1226@126.com>

# set Tsinghua University mirror for url
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories

# glibc version
ARG GLIBC_VERSION=2.29-r0

# update apk and install wget and install glibc
RUN apk update &&\
    apk upgrade &&\
    apk add --update --no-cache ca-certificates wget &&\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk &&\
    apk add glibc-${GLIBC_VERSION}.apk &&\
    apk del ca-certificates wget &&\
    rm -rf glibc-${GLIBC_VERSION}.apk /var/cache/apk/*

CMD ["/bin/sh"]
