--[[ Save and Load Tables (SALT) ]]--
--
--Url: http://github.com/VaiN474/salt.git
--
--Author: VaiN474 - http://github.com/VaiN474
--Last Update: Aug 15, 2017
--Description: Recursively saves table data to a file, human-readable and
--             indented. Tables are loaded using loadfile().
--             Supported types: number, string, boolean, sub-tables of same.
--
--License: MIT (read LICENSE for more details)
--
--Example Usage:
--
--salt = require("salt")
--salt.save(my_table,"/path/to/file")
--
--my_table,err = salt.load("/path/to/file")
--

local salt = {}

function salt.save(tbl,file)

    local f,err = io.open(file,"w")
    if err then print(err) return end
    local indent = 1

    -- local functions to make things easier
    local function exportstring(s)
        s=string.format("%q",s)
        s=s:gsub("\\\n","\\n")
        s=s:gsub("\r","")
        s=s:gsub(string.char(26),"\"..string.char(26)..\"")
        return s
    end
    local function serialize(o)
        if type(o) == "number" then
            f:write(o)
        elseif type(o) == "boolean" then
            if o then f:write("true") else f:write("false") end
        elseif type(o) == "string" then
            f:write(exportstring(o))
        elseif type(o) == "table" then
            f:write("{\n")
            indent = indent + 1
            local tab = ""
            for i=1,indent do tab = tab .. "    " end
            for k,v in pairs(o) do
                f:write(tab .. "[")
                serialize(k)
                f:write("] = ")
                serialize(v)
                f:write(",\n")
            end
            indent = indent - 1
            tab = ""
            for i=1,indent do tab = tab .. "    " end
            f:write(tab .. "}")
        else
            print("unable to serialzie data: "..tostring(o))
            f:write("nil, -- ***ERROR: unsupported data type: "..type(o).."!***")
        end
    end

    f:write("return {\n")
    for k,v in pairs(tbl) do
        f:write("    [")
        serialize(k)
        f:write("] = ")
        serialize(v)
        f:write(",\n")
    end
    f:write("}")
    f:close()
end

function salt.load(file)
    local data,err = loadfile(file)
    if err then return nil,err else return data() end
end

return salt

