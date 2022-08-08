---
--- The xlog module contains one function: pairs(). It can be used to read Tarantool’s snapshot files or write-ahead-log
--- (WAL) files. A description of the file format is in section Data persistence and the WAL file format.
--- @module xlog

---
--- Open a file, and allow iterating over one file entry at a time.
--- @return Iterator @ iterator which can be used in a for/end loop.
function pairs(file_name) end
