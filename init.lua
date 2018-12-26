 -- Constants
SSID    = "98FM"
APPWD   = "potentiometer"
CMDFILE = "webserver.lua"   -- File that is executed after connection
INTERVAL = 450000
-- Some control variables
wifiTrys     = 0      -- Counter of trys to connect to wifi
NUMWIFITRYS  = 200    -- Maximum number of WIFI Testings while waiting for connection
  -- restart every 6 minutes
  tmr.alarm(0, INTERVAL, 1, function() dofile(CMDFILE) end )
  tmr.alarm( 1 , 2500 , 0 , function() dofile(CMDFILE) end )  -- Call main control pgm after timeout
-- Drop through here to let NodeMcu run

