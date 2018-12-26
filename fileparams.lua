-- THESE FUNCTIONS ARE UNTESTED
function save_data(filename,tablename)
  file.open(filename, 'w') -- you don't need to do file.remove if you use the 'w' method of writing
  local buf = ""  
  for k,v in pairs(tablename) do  
     buf = tablename .. k .. " = \"" .. v .. "\""  
     file.writeline(buf)  
    end 
  file.close()
end

function read_data(filename)
  if (file.open(filename)~=nil) then
      result = string.sub(file.readline(), 1, -2) -- to remove newline character
      file.close()
      return true, result
  else
      return false, nil
  end
end
