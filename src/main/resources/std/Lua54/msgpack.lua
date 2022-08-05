---
--- Definitions:
---
--- MsgPack is short for MessagePack.
--- A “raw MsgPack string” is a byte array formatted according to the MsgPack specification including type bytes and
--- sizes. The type bytes and sizes can be made displayable with string.hex(), or the raw MsgPack strings can be converted
--- to Lua objects by using the msgpack module methods.
--- The msgpack module decodes raw MsgPack strings by converting them to Lua objects, and encodes Lua objects by converting
--- them to raw MsgPack strings. Tarantool makes heavy internal use of MsgPack because tuples in Tarantool are stored as
--- MsgPack arrays.
---
--- Besides, starting from version 2.10.0, the msgpack module enables creating a specific userdata Lua object – MsgPack
--- object. The MsgPack object stores arbitrary MsgPack data, and can be created from any Lua object including another
--- MsgPack object and from a raw MsgPack string. The MsgPack object has its own set of methods and iterators.
--- @field __serialize @ The MsgPack output structure can be specified with the __serialize parameter: ‘seq’, ‘sequence’, ‘array’ - table encoded as an array | ‘map’, ‘mappping’ - table encoded as a map  | function - the meta-method called to unpack serializable representation of table, cdata or userdata objects
--- @field NULL @ A value comparable to Lua “nil” which may be useful as a placeholder in a tuple.
--- @module msgpack

---
--- Convert a Lua object to a raw MsgPack string.
--- @param lua_value @ either a scalar value or a Lua table value.
--- @return string @ the original contents formatted as a raw MsgPack string;
function encode(lua_value) end

---
--- Convert a Lua object to a raw MsgPack string in an ibuf, which is a buffer such as buffer.ibuf() creates. As with
--- encode(lua_value), the result is a raw MsgPack string, but it goes to the ibuf output instead of being returned.
--- @param lua_value @ either a scalar value or a Lua table value.
--- @param ibuf buffer @ (output parameter) where the result raw MsgPack string goes
--- @return string @ the original contents formatted as a raw MsgPack string;
function encode(lua_value, ibuf) end

---
--- Convert a Lua object to a raw MsgPack string in an ibuf, which is a buffer such as buffer.ibuf() creates. As with
--- encode(lua_value), the result is a raw MsgPack string, but it goes to the ibuf output instead of being returned.
--- @param msgpack_string string @ a raw MsgPack string.
--- @param start_position integer @ where to start, minimum = 1, maximum = string length, default = 1.
--- @return object @ Lua object and number
function decode(msgpack_string, start_position) end

---
--- @class pointer

---
--- Convert a raw MsgPack string, whose address is supplied as a C-style string pointer such as the rpos pointer which
--- is inside an ibuf such as buffer.ibuf() creates, to a Lua object. A C-style string pointer may be described as
--- cdata<char *> or cdata<const char *>.
--- @param C_style_string_pointer buffer @ a pointer to a raw MsgPack string.
--- @param size integer @ number of bytes in the raw MsgPack string
--- @return table, pointer @ (if C_style_string_pointer points to a valid raw MsgPack string) the original contents of msgpack_string, formatted as a Lua object, usually a Lua table, (otherwise) a scalar value, such as a string or a number; | returned_pointer = a C-style pointer to the byte after what was passed, so that C_style_string_pointer + size = returned_pointer
function decode(C_style_string_pointer, size) end

---
--- Input and output are the same as for decode(string).
--- @param msgpack_string
--- @param start_position
function decode_unchecked(msgpack_string, start_position) end

---
--- Input and output are the same as for decode(string).
--- @param byte_array
--- @param size
--- @return number, pointer @ Return: the size of the array; a pointer to after the array header.
function decode_array_header(byte_array, size) end

---
--- Call the mp_decode_map function in the MsgPuck library and return the map size and a pointer to the first map component.
--- A subsequent call to msgpack_decode can decode the component instead of the whole map.
--- @param byte_array
--- @param size
--- @return number, pointer @ Return: the size of the map; a pointer to after the map header.
function decode_array_header(byte_array, size) end

---
--- Some MsgPack configuration settings can be changed.
---
--- The values are all either integers or boolean true/false.
function cfg(table) end

---
--- Some MsgPack configuration settings can be changed.
---
--- The values are all either integers or boolean true/false.
--- @class MsgpackCfg
--- @field encode_max_depth @ Default: 128 | Use: Max recursion depth for encoding
--- @field encode_deep_as_nil @ Default: false | Use: A flag saying whether to crop tables with nesting level deeper than cfg.encode_max_depth. Not-encoded fields are replaced with one null. If not set, too high nesting is considered an error.
--- @field encode_invalid_numbers @ Default: true | Use: A flag saying whether the serializer will follow __serialize metatable field
--- @field encode_load_metatables @ Default: true | Use: A flag saying whether the serializer will follow __serialize metatable field
--- @field encode_use_tostring @ Default: false | Use: A flag saying whether to use tostring() for unknown types
--- @field encode_invalid_as_nil @ Default: false | Use: A flag saying whether to use NULL for non-recognized types
--- @field encode_sparse_convert @ Default: true | Use: A flag saying whether to handle excessively sparse arrays as maps. See detailed description below
--- @field encode_sparse_ratio @ Default: 2 | Use: 1/encode_sparse_ratio is the permissible percentage of missing values in a sparse array
--- @field encode_sparse_safe @ Default: 10 | Use: A limit ensuring that small Lua arrays are always encoded as sparse arrays (instead of generating an error or encoding as a map)
--- @field decode_invalid_numbers @ Default: true | Use: A flag saying whether to enable decoding of NaN and Inf numbers
--- @field decode_save_metatables @ Default: true | Use: A flag saying whether to set metatables for all arrays and maps
local msgpackcfg = {}

--- @type MsgpackCfg
msgpack.cfg = {}

---
--- Encode an arbitrary Lua object into the MsgPack format.
--- @param lua_value @ Encode an arbitrary Lua object into the MsgPack format.
--- @return userdata @ encoded MsgPack data encapsulated in a MsgPack object.
function object(lua_value) end

---
--- Create a MsgPack object from a raw MsgPack string.
--- @param msgpack_string string @ a raw MsgPack string.
--- @return userdata @ a MsgPack object
function object(lua_value) end

---
--- Create a MsgPack object from a raw MsgPack string. The address of the MsgPack string is supplied as a C-style
--- string pointer such as the rpos pointer inside an ibuf that the buffer.ibuf() creates. A C-style string pointer may
--- be described as cdata<char *> or cdata<const char *>.
--- @param C_style_string_pointer buffer @ a pointer to a raw MsgPack string.
--- @param size integer @ number of bytes in the raw MsgPack string.
--- @return userdata @ a MsgPack object
function object_from_raw(C_style_string_pointer, size) end

---
--- Check if the given argument is a MsgPack object.
--- @param some_argument @ any argument.
--- @return boolean true if the argument is a MsgPack object; otherwise, false
function is_object(some_argument) end

---
--- A MsgPack object can be passed to the MsgPack encoder with the same effect as passing the original Lua object:
---
--- local msgpack = require('msgpack')
---
--- local mp = msgpack.object(123)
---
--- msgpack.object({mp, mp}):decode()         -- returns {123, 123}
---
--- msgpack.decode(msgpack.encode({mp, mp}))  -- returns {123, 123}
---
--- In particular, this means that if a MsgPack object stores an array, it can be inserted into a database space:
---
--- box.space.my_space:insert(msgpack.object({1, 2, 3}))
local msgpack_object = {}

---
--- Decode MsgPack data in the MsgPack object.
--- @return object @ a Lua object
function msgpack_object:decode() end

---
--- Create an iterator over the MsgPack data.
---
--- A MsgPack iterator object has its own set of methods.
--- @return userdata @ an iterator object over the MsgPack data
function msgpack_object:iterator() end

---
--- The MsgPack iterator object has the following methods:
local iterator_object = {}

---
--- Decode a MsgPack array header under the iterator cursor and advance the cursor. After calling this function,
--- the iterator points to the first element of the array or to the value following the array if the array is empty.
--- @return number @ number of elements in the array
function iterator_object:decode_array_header() end

---
--- Decode a MsgPack map header under the iterator cursor and advance the cursor. After calling this function,
--- the iterator points to the first key stored in the map or to the value following the map if the map is empty.
--- @return number @ number of key value pairs in the map
function iterator_object:decode_map_header() end

---
--- Decode a MsgPack value under the iterator cursor and advance the cursor.
--- @return object @ a Lua object corresponding to the MsgPack value
function iterator_object:decode() end


---
--- Return a MsgPack value under the iterator cursor as a MsgPack object without decoding and advance the cursor.
--- The method doesn’t copy MsgPack data. Instead, it takes a reference to the original object.
function iterator_object:take() end

---
--- Advance the iterator cursor by skipping one MsgPack value under the cursor. Returns nothing
function iterator_object:skip() end
