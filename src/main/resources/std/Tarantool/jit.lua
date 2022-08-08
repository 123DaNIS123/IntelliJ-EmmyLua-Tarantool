---
--- @module jit

---
--- Prints the byte code of a function.
---
--- For a list of available options, read the source code of bc.lua - [https://github.com/tarantool/luajit/blob/tarantool-1.7/src/jit/bc.lua]
--- @param func function
function jit_bc.dump(func) end

---
--- Prints the i386 assembler code of a string of bytes
---
--- For a list of available options, read the source code of bc.lua - [https://github.com/tarantool/luajit/blob/tarantool-1.7/src/jit/dis_x86.lua].
--- @param string
function jit_dis_x86.disass(string) end

---
--- Prints the x86-64 assembler code of a string of bytes.
---
--- For a list of available options, read the source code of dis_x64.lua. - [https://github.com/tarantool/luajit/blob/tarantool-1.7/src/jit/dis_x64.lua]
--- @param string
function jit_dis_x64.disass(string) end

--- Prints a trace of LuaJIT’s progress compiling and interpreting code.
---
--- For a list of available options, read the source code of dump.lua - [https://github.com/tarantool/luajit/blob/tarantool-1.7/src/jit/dump.lua]
function jit_dump.on(option, output_file) end

--- Prints a trace of LuaJIT’s progress compiling and interpreting code.
---
--- Prints the intermediate or machine code of the following Lua code.
---
--- For a list of available options, read the source code of dump.lua - [https://github.com/tarantool/luajit/blob/tarantool-1.7/src/jit/dump.lua]
function jit_dump.off() end
