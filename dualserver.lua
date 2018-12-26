-- version 1 of dualserver; serves http or telnet if c"telnet" cmd received
function init_webserver()
print("starting webserver"); 
srv=net.createServer(net.TCP,180)
srv:listen(80,function(c) 
  c:on("receive",function(c,d) 
    if d:sub(1,6) == "telnet" then
      -- switch to telnet service
      node.output(function(s)
        if c ~= nil then c:send(s) end
      end,0)
      c:on("receive",function(c,d)
        if d:byte(1) == 4 then c:close() -- ctrl-d to exit
        else node.input(d) end
      end)
      c:on("disconnection",function(c)
        node.output(nil)
      end)
      print("NodeMCU server")
      node.input("\r\n")
      return
    end
    if d:sub(1,5) ~= "GET /" then -- only process GET method
      c:close()
      return
    end
    local buf= "<h1>ESP8266 Web Server</h1>";
    getVars(c,d)
    for k, v in pairs(DATA) do
        buf = buf.."<p>"..k.." : "..v.."</p>"
   end
   c:send(buf);
   c:close();
   collectgarbage();
  end) 
end)
end
-- EXTRACT GET VARS
function getVars(client,request)
local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
if(method == nil)then
    _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
    end
if (vars ~= nil)then
    for k,v in string.gmatch(vars, '([^&=?]-)=([^&=?]+)' ) do
    -- for k, v in string.gmatch(vars, "(%w.+)=(%w.+)&*") do
        DATA[k] = v
        POSTED[k] = false
        print("k="..k..";v="..v)
        end
    end    
end 
-- STARTS HERE --
DATA={} -- GET key/value pairs received by web server OR console
tmr.alarm( 2 , 200 , 0 ,  function() init_webserver(); end)



