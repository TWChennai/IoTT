ip = wifi.sta.getip()
print('Present IP = ', ip)

wifi.setmode(wifi.STATION)
wifi.sta.config("ssid","password")
ip = wifi.sta.getip()
print('New IP = ', ip)

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
  conn:on("receive",function(conn,payload)
    print(payload)
    conn:send(STATUS)
  end)
  conn:on("sent",function(conn) conn:close() end)
end)
