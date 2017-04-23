#!/bin/sh

echo "NB! Remember to pass '--cap-add=NET_ADMIN --device=/dev/net/tun' on docker run!"

if [[ ${BLACKVPN_USER} == "set.me.please" ]]; then
  echo "* Please set BLACKVPN_USER environment variable to your actual BlackVPN username!"
  exit 1
fi

if [[ ${BLACKVPN_PASS} == "set.me.please" ]]; then
  echo "* Please set BLACKVPN_PASS environment variable to your actual BlackVPN password!"
  exit 2
fi

echo ${BLACKVPN_USER} >/tmp/blackvpn.up
echo ${BLACKVPN_PASS} >>/tmp/blackvpn.up
chmod 0600 /tmp/blackvpn.up

BLACKVPN_CONFS="$(ls -1 /etc/openvpn/*.conf | sed 's|.*/||;s|\.conf$||')"
if [[ $(echo "${BLACKVPN_CONFS}" | grep "^${BLACKVPN_CONF}$" | wc -l) -ne 1 ]]; then
  echo "* Please set BLACKVPN_CONF environment variable to one of these values:"
  echo "${BLACKVPN_CONFS}"
  echo "NB! 'Privacy' VPNs are always included, while for 'TV' ones you may need to pay extra \$\$\$ ;)"
  exit 3
fi

openvpn --cd /etc/openvpn --config ${BLACKVPN_CONF}.conf --cipher AES-256-CBC --auth-user-pass /tmp/blackvpn.up
