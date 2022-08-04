---
--- The json module provides JSON manipulation routines. It is based on the Lua-CJSON module by Mark Pulford.
--- For a complete manual on Lua-CJSON please read the official documentation.
--- @module json

---
--- Convert a Lua object to a JSON string.
--- @param lua_value @ either a scalar value or a Lua table value.
--- @param configuration @ see json.cfg
--- @return string @ the original value reformatted as a JSON string.
function json.encode(lua_value, configuration) end

---
--- Convert a JSON string to a Lua object.
---
--- See the tutorial Sum a JSON field for all tuples to see how json.decode() can fit in an application.
--- @param string string @ a string formatted as JSON.
--- @param configuration @ see json.cfg
--- @return table @ the original contents formatted as a Lua table.
function json.decode(string, configuration) end

---
--- Set values that affect the behavior of json.encode and json.decode.
---
--- The values are all either integers or boolean true/false.
function json.cfg(table) end

---
--- @class JsonCfg
--- @field encode_max_depth @ Default: 128 | Use: Max recursion depth for encoding
--- @field encode_deep_as_nil @ Default: false | Use: A flag saying whether to crop tables with nesting level deeper than cfg.encode_max_depth. Not-encoded fields are replaced with one null. If not set, too deep nesting is considered an error.
--- @field encode_invalid_numbers @ Default: true | Use: A flag saying whether to enable encoding of NaN and Inf numbers.
--- @field encode_number_precision @ Default: 14 | Use: Precision of floating point numbers.
--- @field encode_load_metatables @ Default: true | Use: A flag saying whether the serializer will follow __serialize metatable field.
--- @field encode_use_tostring @ Default: false | Use: A flag saying whether to use tostring() for unknown types.
--- @field encode_invalid_as_nil @ Default: false | Use:A flag saying whether use NULL for non-recognized types
--- @field encode_sparse_convert @ Default: true | Use: A flag saying whether to handle excessively sparse arrays as maps. See detailed description below..
--- @field encode_sparse_ratio @ Default: 2 | Use: 1/encode_sparse_ratio is the permissible percentage of missing values in a sparse array.
--- @field encode_sparse_safe @ Default: 10 | Use: 	A limit ensuring that small Lua arrays are always encoded as sparse arrays (instead of generating an error or encoding as a map).
--- @field decode_invalid_numbers @ Default: true | Use: A flag saying whether to enable decoding of NaN and Inf numbers
--- @field decode_save_metatables @ Default: true | Use: A flag saying whether to set metatables for all arrays and maps
--- @field decode_max_depth @ Default: 128 | Use: Max recursion depth for decoding
local jsoncfg = {}

--- @type JsonCfg
json.cfg = {}

---
--- A value comparable to Lua “nil” which may be useful as a placeholder in a tuple.
json.NULL = {}
