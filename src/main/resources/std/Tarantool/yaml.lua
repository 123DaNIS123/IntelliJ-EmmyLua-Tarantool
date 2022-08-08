---
--- The yaml module takes strings in YAML format and decodes them, or takes a series of non-YAML values and encodes them.
--- @field __serialize @ The YAML output structure can be specified with __serialize: 'seq', 'sequence', 'array': table encoded as an array | 'map', 'mapping': table encoded as a map  | function: the meta-method called to unpack serializable representation of table, cdata, or userdata objects | 'seq' or 'map' also enable the flow (compact) mode for the YAML serializer (flow="[1,2,3]" vs block=" - 1\n - 2\n - 3\n").
--- @field NULL @ A value comparable to Lua “nil” which may be useful as a placeholder in a tuple.
--- @module yaml

---
--- Convert a Lua object to a YAML string.
--- @param lua_value lua_value @ either a scalar value or a Lua table value.
--- @return string @ the original value reformatted as a YAML string.
function encode(lua_value) end

---
--- Convert a YAML string to a Lua object.
--- @param string @ a string formatted as YAML.
--- @return table @ the original contents formatted as a Lua table.
function decode(lua_value) end

---
--- Set values affecting the behavior of encode and decode functions.
---
--- The values are all either integers or boolean true/false.
function cfg(table) end

---
--- @class YAMLCfg
--- @field encode_invalid_numbers @ Default: true | Use: A flag saying whether to enable encoding of NaN and Inf numbers
--- @field encode_number_precision @ Default: 14 | Use: Precision of floating point numbers
--- @field encode_load_metatables @ Default: true | Use: A flag saying whether the serializer will follow __serialize metatable field
--- @field encode_use_tostring @ Default: false | Use: 	A flag saying whether to use tostring() for unknown types
--- @field encode_invalid_as_nil @ Default: false | Use: A flag saying whether to use NULL for non-recognized types
--- @field encode_sparse_convert @ Default: true | Use: A flag saying whether to handle excessively sparse arrays as maps. See detailed description below
--- @field encode_sparse_ratio @ Default: 2 | Use: 1/encode_sparse_ratio is the permissible percentage of missing values in a sparse array
--- @field encode_sparse_safe @ Default: 10 | Use: 	A limit ensuring that small Lua arrays are always encoded as sparse arrays (instead of generating an error or encoding as map)
--- @field decode_invalid_numbers @ Default: true | Use: A flag saying whether to enable decoding of NaN and Inf numbers
--- @field decode_save_metatables @ Default: true | Use: 	A flag saying whether to set metatables for all arrays and maps
local yamlcfg = {}

---
--- @type YAMLCfg
yaml.cfg = {}
