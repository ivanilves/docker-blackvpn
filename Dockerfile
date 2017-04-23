FROM alpine:3.5

LABEL maintainer "ivan.ilves@gmail.com"

ENV BLACKVPN_USER set.me.please
ENV BLACKVPN_PASS set.me.please
ENV BLACKVPN_CONF set.me.please

RUN apk update && apk add openvpn openssl ca-certificates \
  && wget -O /tmp/blackvpn_linux.zip 'https://www.blackvpn.com/?wpdmact=process&did=NTUuaG90bGluaw==' \
  && unzip /tmp/blackvpn_linux.zip -d /tmp/ && mv /tmp/blackvpn_linux/* /etc/openvpn/ \
  && chmod 0644 /etc/openvpn/*.conf && chmod 0600 /etc/openvpn/ssl/*.key \ 
  && sed -i 's|^up .*|up /bin/true|;s|^down .*|down /bin/true|' /etc/openvpn/*.conf

ADD ./start-blackvpn.sh /start-blackvpn.sh

CMD ["/start-blackvpn.sh"]
