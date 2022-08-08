---
--- The csv module handles records formatted according to Comma-Separated-Values (CSV) rules.
---
--- The default formatting rules are:
---
--- Lua escape sequences such as \n or \10 are legal within strings but not within files,
---
--- Commas designate end-of-field,
---
--- Line feeds, or line feeds plus carriage returns, designate end-of-record,
---
--- Leading or trailing spaces are ignored,
---
--- Quote marks may enclose fields or parts of fields,
---
--- When enclosed by quote marks, commas and line feeds and spaces are treated as ordinary characters, and a pair of
---quote marks “” is treated as a single quote mark.
---
--- The possible options which can be passed to csv functions are:
---
--- delimiter = string (default: comma) – single-byte character to designate end-of-field
---
--- quote_char = string (default: quote mark) – single-byte character to designate encloser of string
---
--- chunk_size = number (default: 4096) – number of characters to read at once (usually for file-IO efficiency)
---
--- skip_head_lines = number (default: 0) – number of lines to skip at the start (usually for a header)
--- @module csv

---
--- @class object

---
--- Get CSV-formatted input from readable and return a table as output. Usually readable is either a string or a file
--- opened for reading. Usually options is not specified.
--- @param readable object @ a string, or any object which has a read() method, formatted according to the CSV rules
--- @param options table @ see (The possible options which can be passed to csv functions are: ...) [https://www.tarantool.io/en/doc/latest/reference/reference_lua/csv/#csv-options]
--- @return table @ loaded_value
function load(readable, options) end

---
--- Get table input from csv-table and return a CSV-formatted string as output. Or, get table input from csv-table and
--- put the output in writable. Usually options is not specified. Usually writable, if specified, is a file opened for
--- writing. csv.dump() is the reverse of csv.load().
--- @param csv_table table @ a table which can be formatted according to the CSV rules.
--- @param options table @ see (The possible options which can be passed to csv functions are: ...) [https://www.tarantool.io/en/doc/latest/reference/reference_lua/csv/#csv-options]
--- @param writable object @ any object which has a write() method
--- @return string @ dumped_value; string, which is written to writable if specified
function dump(csv_table, options, writable) end

---
--- @class Iterator_function

---
--- Form a Lua iterator function for going through CSV records one field at a time. Use of an iterator is strongly
--- recommended if the amount of data is large (ten or more megabytes).
--- @param csv_table table @ a table which can be formatted according to the CSV rules.
--- @param options table @ see (The possible options which can be passed to csv functions are: ...) [https://www.tarantool.io/en/doc/latest/reference/reference_lua/csv/#csv-options]
--- @return Iterator_function @ Lua iterator function
function iterate(csv_table, options) end
