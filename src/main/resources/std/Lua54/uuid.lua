--- @module uuid
--- @class UUID
--- @field nil UUID
local uuid = {}

--- @return boolean
function uuid:isnil() end

--- @return string
function uuid:str() end

--- @param byteOrder string @l, b, h or n - endianness
--- @return string
function uuid:bin(byteOrder) end

--- @param str string @16 bytes binary string
--- @return UUID
function uuid.frombin(str) end

--- @return string @36 bytes
function uuid.str() end

--- @return string @16 bytes
function uuid.bin() end

--- @return UUID
function uuid() end

return uuid;
