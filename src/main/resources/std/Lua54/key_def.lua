---
--- The key_def module has a function for defining the field numbers and types of a tuple. The definition is
--- usually used with an index definition to extract or compare the index key values.
--- @module key_def

---
--- @class KeyDefObject
local key_def_object = {}

---
--- Create a new key_def instance.
---
--- The parts table has components which are the same as the parts option in Options for space_object:create_index().
---
--- fieldno (integer), for example, fieldno = 1. It is legal to use field instead of fieldno.
---
--- type (string), for example, type = 'string'.
---
--- Other components are optional.
---
--- Example: key_def.new({{type = 'unsigned', fieldno = 1}})
---
--- Example: key_def.new({{type = 'string', collation = 'unicode', field = 2}})
--- @param parts table @ field numbers and types. There must be at least one part. Every part must contain the attributes type and fieldno/field. Other attributes are optional.
--- @return KeyDefObject
function key_def.new(parts) end

---
--- Return a tuple containing only the fields of the key_def object.
--- @param tuple tuple @ tuple or Lua table with field contents
--- @return key_def
function key_def_object:extract_key(tuple) end

---
--- Compare the key fields of tuple_1 with the key fields of tuple_2. It is a tuple-by-tuple comparison so users do not
--- have to write code that compares one field at a time. Each field’s type and collation will be taken into account.
--- In effect it is a comparison of extract_key(tuple_1) with extract_key(tuple_2).
--- @param tuple_1 table @ tuple or Lua table with field contents
--- @param tuple_2 table @ tuple or Lua table with field contents
--- @return number @ > 0 if tuple_1 key fields > tuple_2 key fields, = 0 if tuple_1 key fields = tuple_2 key fields, < 0 if tuple_1 key fields < tuple_2 key fields
function key_def_object:compare(tuple_1, tuple_2) end

---
--- Compare the key fields of tuple_1 with all the fields of tuple_2. This is the same as key_def_object:compare()
--- except that tuple_2 contains only the key fields. In effect it is a comparison of extract_key(tuple_1) with tuple_2.
--- @param tuple_1 table @ tuple or Lua table with field contents
--- @param tuple_2 table @ tuple or Lua table with field contents
--- @return number @ > 0 if tuple_1 key fields > tuple_2 fields, = 0 if tuple_1 key fields = tuple_2 fields, < 0 if tuple_1 key fields < tuple_2 fields
function key_def_object:compare_with_key(tuple_1, tuple_2) end

---
--- Combine the main key_def_object with other_key_def_object. The return value is a new key_def_object containing all
--- the fields of the main key_def_object, then all the fields of other_key_def_object which are not in the main key_def_object.
--- @param other_key_def_object KeyDefObject @ definition of fields to add
--- @return KeyDefObject
function key_def_object:merge(other_key_def_object) end

---
--- Returns a table containing the fields of the key_def_object. This is the reverse of key_def.new():
---
--- key_def.new() takes a table and returns a key_def object,
---
--- key_def_object:totable() takes a key_def object and returns a table.
--- This is useful for input to _serialize methods.
--- @return table
function key_def_object:totable() end
