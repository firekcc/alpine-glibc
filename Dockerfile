FROM alpine:3.9
MAINTAINER firekcc <lyk_1226@126.com>

# glibc version
ARG GLIBC_VERSION=2.29-r0

# set Unicode
ENV LANG=C.UTF-8

# set mirror and update apk and upgrade apk and install ca-certificates,wget and install glibc and set Unicode timezone
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories &&\
    apk update &&\
    apk upgrade &&\
    apk add --update --no-cache ca-certificates wget tzdata &&\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk &&\
    apk add glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk &&\
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) &&\
    ( /usr/glibc-compat/bin/locale -a ) &&\
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    date -R &&\
    apk del ca-certificates wget tzdata &&\
    rm -rf glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk /var/cache/apk/*

CMD ["/bin/sh"]
