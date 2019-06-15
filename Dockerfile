FROM alpine:3.9
MAINTAINER firekcc <lyk_1226@126.com>

# update alpine download url
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.9/main/" > /etc/apk/repositories

# update apk and install plugin and set the timeZone
RUN apk update \
        && apk upgrade \
        && apk add --no-cache --update bash tree curl wget tzdata \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# glibc version
ENV GLIBC_VERSION 2-29-r0

# Install glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && apk add glibc-${GLIBC_VERSION}.apk

CMD ["/bin/bash"]
