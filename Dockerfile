FROM alpine:3.5

LABEL maintainer "ivan.ilves@gmail.com"

ENV BLACKVPN_USER my.blackvpn.username
ENV BLACKVPN_PASS my.blackvpn.password
ENV BLACKVPN_CONF random

EXPOSE 1080

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >>/etc/apk/repositories \
  && apk update && apk add openvpn dante-server openssl ca-certificates \
  && wget -O /tmp/blackvpn_linux.zip 'https://www.blackvpn.com/?wpdmact=process&did=NTUuaG90bGluaw==' \
  && unzip /tmp/blackvpn_linux.zip -d /tmp/ && mv /tmp/blackvpn_linux/* /etc/openvpn/ \
  && chmod 0644 /etc/openvpn/*.conf && chmod 0600 /etc/openvpn/ssl/*.key \
  && sed -i '/^up .*/d;/^down .*/d' /etc/openvpn/*.conf

ADD ./start-blackvpn.sh /start-blackvpn.sh
ADD ./start-sockd.sh /start-sockd.sh
ADD ./sockd.conf /etc/sockd.conf

CMD ["/start-blackvpn.sh"]
