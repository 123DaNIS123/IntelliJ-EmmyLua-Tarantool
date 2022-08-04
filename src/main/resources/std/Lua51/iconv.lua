--- The iconv module provides a way to convert a string with one encoding to a string with another encoding, for example
--- from ASCII to UTF-8. It is based on the POSIX iconv routines.
---
--- An exact list of the available encodings may depend on environment. Typically the list includes ASCII, BIG5, KOI8R,
--- LATIN8, MS-GREEK, SJIS, and about 100 others. For a complete list, type iconv --list on a terminal.
--- @module iconv

---
--- Construct a new iconv instance.
--- @param to string @ the name of the encoding that we will convert to.
--- @param from string @ the name of the encoding that we will convert from.
--- @return userdata @ the name of the encoding that we will convert from.
function iconv.new(to, from) end

---
--- Convert.
---
--- If anything in input-string cannot be converted, there will be an error message and the result string will be unchanged.
--- @param input_string string @ the string to be converted (the “from” string)
--- @return string @ the string that results from the conversion (the “to” string)
function iconv.converter(input_string) end
