FROM alpine:3.19
ARG ARCH=amd64

RUN VERSION=$(wget -qO- https://api.github.com/repos/fatedier/frp/releases/latest \
        | grep '"tag_name"' \
        | sed 's/.*"v\([^"]*\)".*/\1/') \
    && wget -qO- https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${ARCH}.tar.gz \
    | tar -xzf - --strip-components=1 -C /usr/local/bin frp_${VERSION}_linux_${ARCH}/frpc \
    && chmod +x /usr/local/bin/frpc

ENTRYPOINT ["frpc"]
CMD ["-c", "/etc/frp/frpc.toml"]
