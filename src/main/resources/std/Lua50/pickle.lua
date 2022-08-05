---
--- @module pickle

---
--- To use Tarantool binary protocol primitives from Lua, it’s necessary to convert Lua variables to binary format.
--- The pickle.pack() helper function is prototyped after Perl pack.
--- @param format string @ string containing format specifiers
--- @param argument scalar @ scalar values to be formatted
--- @return string @ a binary string containing all arguments, packed according to the format specifiers.
function pack(format, argument, argument) end

---
--- Counterpart to pickle.pack(). Warning: if format specifier ‘A’ is used, it must be the last item.
--- @param format string
--- @param binary_string string
--- @return table @ A list of strings or numbers.
function unpack(format, binary_string) end

