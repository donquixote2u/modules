-- get HTTP request (web client)  (v2)
-- usage: set up server params in connPARM table any time
-- load request in REQ, call sendReq() to send it
function sendReq()
RECEIVED=false
local BODY={}
BODY[1]="GET /"
BODY[2]=connParm["SUBDIR"]
BODY[3]=REQ
BODY[4]=" HTTP/1.1\r\nHost: "
BODY[5]=connParm["NAME"]
BODY[6]="\r\nConnection: keep-alive\r\n"
BODY[7]="Accept: */*\r\n".."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n\r\n"
local REQUEST=table.concat(BODY)
-- connection to server
-- DEBUG print("Sending data to "..connParm["IP"]..":"..connParm["NAME"])
sk=net.createConnection(net.TCP, 0)
sk:on("receive", function(sck, payload)
    buffer=payload
    RECEIVED=true
    end)
sk:on("connection", function(sck)
    conn=sck
    -- DEBUG print ("Sending: "..REQUEST.."...\r\n");
    conn:send(REQUEST)
    end)
sk:on("sent",function(sck)
   tmr.alarm( 6, 10000, 0, function()
    print("Closing connection")
    sk:close()
    end)    
   end)
sk:connect(80,connParm["IP"])
end
--  START HERE - just init (samples of config below)
connParm={} -- connection params  for REMOTE server
--connParm["IP"]="192.168.0.4" -- set address 
--connParm["NAME"]="alpha" -- set host
--connParm["SUBDIR"]="NODEMCU-OTA" -- set dir
