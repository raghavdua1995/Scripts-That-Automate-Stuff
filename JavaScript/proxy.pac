function FindProxyForURL(url, host)
 {
 if (myIpAddress() == "192.168.1.6") { 
 return "DIRECT";
 }
 else {
 return "PROXY ip:port";
 }
 }
