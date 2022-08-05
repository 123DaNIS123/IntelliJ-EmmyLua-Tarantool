--- @module uuid
--- @class UUID
--- @field nil UUID @ A nil object
local uuid = {}

--- @return boolean
function uuid:isnil() end

--- @return string
function uuid:str() end

--- @param byteOrder string @l, b, h or n - endianness
--- @return string
function uuid:bin(byteOrder) end

--- @param str string @16 bytes binary string
--- @return cdata @ converted UUID
function uuid.frombin(str) end

--- @return string @36 bytes
function uuid.str() end

--- @return string @16 bytes
function uuid.bin() end

--- @return cdata @UUID
function uuid() end

--

---
--- Since version 2.4.1. Create a UUID sequence. You can use it in an index over a uuid field. For example, to create
--- such index for a space named test, say:
--- @return cdata @ a UUID
function uuid.new() end

---
--- @return cdata @ a UUID
function uuid.__call() end

---
--- @param uuid_str string @UUID in 36-byte hexadecimal string
--- @return cdata @ converted UUID
function uuid.fromstr(uuid_str) end

---
--- @param value @ a value to check
--- @return boolean @ true if the specified value is a uuid, and false otherwise
function uuid.is_uuid(uuid_str) end

---
--- @class UUIDObject
local uuid_object = {}

---
--- @param byte_order string @l, b, h or n - endianness
--- @return string @ UUID converted from cdata input value. 16-byte binary string
function uuid_object:bin(byte_order) end

---
--- @return string @ UUID converted from cdata input value. 36-byte hexadecimal string
function uuid_object:str() end

---
--- The all-zero UUID value can be expressed as uuid.NULL, or as uuid.fromstr('00000000-0000-0000-0000-000000000000').
--- The comparison with an all-zero value can also be expressed as uuid_with_type_cdata == uuid.NULL.
--- @return boolean @ true if the value is all zero, otherwise false.
function uuid_object:isnil() end

return uuid;
