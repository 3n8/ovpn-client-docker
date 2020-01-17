FROM alpine:latest

RUN apk add --no-cache openvpn

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/sh","/entrypoint.sh"]
WORKDIR /etc/openvpn