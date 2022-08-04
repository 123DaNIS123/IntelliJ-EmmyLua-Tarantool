---
--- The merger module takes a stream of tuples and provides access to them as tables.
--- @module merger

---
--- @class MergerObject
local merger_object = {}

---
--- Create a new merger instance from a tuple source.
---
--- A tuple source just returns one tuple.
---
--- The generator function gen() allows creation of multiple tuples via an iterator.
---
--- The gen() function should return:
---
--- state, tuple each time it is called and a new tuple is available,
--- nil when no more tuples are available.
--- @param gen @ function for iteratively returning tuples
--- @param param @ parameter for the gen function
--- @return MergerObject
function merger.new_tuple_source(gen, param, state) end

---
--- Create a new merger instance from a buffer source.
---
--- Parameters and return: same as for merger.new_tuple_source.
---
--- To set up a buffer, or a series of buffers, use the buffer module.
--- @param gen @ function for iteratively returning tuples
--- @param param @ parameter for the gen function
--- @return MergerObject
function merger.new_buffer_source(gen, param, state) end

---
--- Create a new merger instance from a table source.
---
--- Parameters and return: same as for merger.new_tuple_source.
---
--- Example: see merger_object:select() method -  [https://www.tarantool.io/en/doc/latest/reference/reference_lua/merger/#merger-select]
--- @param gen @ function for iteratively returning tuples
--- @param param @ parameter for the gen function
--- @return MergerObject
function merger.new_table_source(gen, param, state) end

---
--- Create a new merger instance from a merger source.
---
--- A merger source is created from a key_def object and a set of (tuple or buffer or table or merger) sources.
--- It performs a kind of merge sort. It chooses a source with a minimal / maximal tuple on each step, consumes a tuple
--- from this source, and repeats.
---
--- A key_def can be cached across requests with the same ordering rules (typically these would be requests accessing the same space).
---
--- Example: see merger_object:pairs() method.
--- @field key_def @ object created with key_def
--- @field source @ parameter for the gen() function
--- @field options @ reverse=true if descending, false or nil if ascending
--- @return MergerObject
function merger.new(key_def, sources, options) end

---
--- Access the contents of a merger object with familiar select syntax.
--- @param buffer @ as in net.box client conn:select method
--- @param limit @ as in net.box client conn:select method
--- @return table|tuple @ similar to what select would return
function merger_object:select(buffer, limit) end

---
--- The pairs() method (or the equivalent ipairs() alias method) returns a luafun iterator. It is a Lua iterator, but
--- also provides a set of handy methods to operate in functional style.
--- @param tuple table @ tuple or Lua table with field contents
--- @return tuple @ the tuples that can be found with a standard pairs() function
function merger_object:pairs() end
