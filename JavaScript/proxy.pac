var proxy = "PROXY 192.168.2.3:3128";
function FindProxyForURL(url, host) {
    if (dnsResolve(host) == "127.0.0.1") {
        // Avoid using proxy for any domain that is resolved to be *localhost*.
        // Eg. foo.localtest.me
        return "DIRECT";
    }
    if (isInNet(myIpAddress(), "192.168.2.0", "255.255.255.0")) {
        return proxy;
    }
    else {
        return "DIRECT";
    }
}
