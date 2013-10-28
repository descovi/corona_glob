Stat = {}

Stat.write = function(saveData)
  local path = system.pathForFile( "record.txt", system.DocumentsDirectory )
  local file = io.open( path, "w+" )
  file:write( saveData )
  io.close( file )
  file = nil

end

Stat.read = function()
  local path = system.pathForFile( "record.txt", system.DocumentsDirectory )
  local file = io.open(path,"r+")
  if file == nil then
    file = io.open(path,"w+")
    file:write("0")
  end
  local savedData = file:read()
  if savedData == "" or savedData == nil then
    file:write("0")
    savedData = "0"
  end
  io.close( file )
  file = nil
  return tonumber(savedData)
end

return Stat