--- Get data (via console) and send to host web server
-- usage: call functions setServer() and pass REQ 
--  with appropriate key/value pairs,call sendReq() to send it
function setServer(param,val)
serverParm[param]=val
end
function sendReq()
REQ=string.gsub(REQ,"&","?",1)  -- replace first & with ?        
-- REQUEST="GET /"..serverParm["SUBDIR"]..REQ..REQBODY1..REQBODY2;
-- connection to server
GET="http://"..serverParm["NAME"].."/"..serverParm["SUBDIR"]..REQ
print("Posting "..GET.."\r\n")
--http.get(GET, "Accept: */*\r\n", function(code, data)
http.get(GET, function(code, data)
    if (code < 0) then
      print("HTTP request failed:"..code)
    else
      print("received:"..code..";"..data)
    end
  end)
end
--  START HERE - just init (all funtions called via console)
serverParm={} -- connection params  for REMOTE server

