Runs **[BlackVPN](https://www.blackvpn.com/)** client inside Docker with OpenVPN. Exposes SOCKSv5 proxy for user applications.

**NB!** BlackVPN is a commercial VPN provider, so you will need to pay for a subscription to use it.

## Why do I need this?
Well, I need it to perform security, testing and ethical hacking tasks. I have no idea of your needs though! :laughing:

### How do I run it?
```
docker run --cap-add=NET_ADMIN --device=/dev/net/tun -p 1080:1080 \
  -e BLACKVPN_USER=<your.blackvpn.username> -e BLACKVPN_PASS=<your.blackvpn.password> \
  ivanilves/blackvpn
```
You can also pass `BLACKVPN_CONF` environment variable to make it use specific configuration, i.e. route traffic through specific country. By-default it's selected randomly among one of the "Privacy" configurations, which is a good beginning.

### How do I use it?
Like this: `curl --socks5 127.0.0.1:1080  http://checkip.amazonaws.com/`
Very simple! As long as container will run and expose SOCKSv5 proxy on port TCP/1080, you may use any SOCKSv5-aware software to pass traffic through BlackVPN connection. Even if your software doesn't support SOCKSv5 directly, you could use something like `tsocks` to "proxify" it. 
