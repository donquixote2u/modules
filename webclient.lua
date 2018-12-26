--- Get data (via console) and send to host web server
-- usage: call functions setServer() and pass REQ 
--  with appropriate key/value pairs,call sendReq() to send it
function setServer(param,val)
serverParm[param]=val
end
function sendReq()
buffer=""
REQ=string.gsub(REQ,"&","?",1)  -- replace first & with ?        
REQBODY1= " HTTP/1.1\r\nHost: "..serverParm["NAME"].."\r\nConnection: keep-alive\r\n";
REQBODY2="Accept: */*\r\n".."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n\r\n"
REQUEST="GET /"..serverParm["SUBDIR"]..REQ..REQBODY1..REQBODY2;
-- connection to server
print("Sending data to "..serverParm["IP"]..":"..serverParm["NAME"])
sk=net.createConnection(net.TCP, 0)
sk:on("receive", function(sck, payload)
    -- print("received:"..payload)
    buffer=buffer..payload
    end)
sk:on("connection", function(sck)
    conn=sck
    print ("Sending: "..REQUEST.."...\r\n");
    conn:send(REQUEST)
    end)
    sk:on("sent",function(sck)
      tmr.alarm( 6, 10000, 0, function()
      print("Closing connection")
      sk:close()
      end)    
    end)
sk:connect(80,serverParm["IP"])
end
--  START HERE - just init (all funtions called via console)
serverParm={} -- connection params  for REMOTE server
