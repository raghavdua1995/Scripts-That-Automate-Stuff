function FindProxyForURL(url, host)
 {
  if (isInNet(myIpAddress(), "192.168.2.0", "255.255.255.0"))
  { 
   return "PROXY 192.168.2.4:3128";
  }
  else
  {
   return "DIRECT";
  }
 }
