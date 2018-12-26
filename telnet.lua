-- remote programming via wifi
function startServer()
sv=net.createServer(net.TCP, 28800)
sv:listen(9876, function(c)
tnserver=c
print("Wifi console connected.")
function s_output(str)
if (tnserver~=nil) then
tnserver:send(str)
end
end
node.output(s_output,0)
tnserver:on("receive", function(tnserver, pl)
node.input(pl)
end)
tnserver:on("disconnection",function(c)
tnserver=nil
node.output(nil)
end)
end)
print("server running at :9876")
end
print("Connecting...")
startServer()

