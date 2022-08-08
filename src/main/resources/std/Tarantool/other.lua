---
--- Convert a string or a Lua number to a 64-bit integer. The input value can be expressed in decimal,
--- binary (for example 0b1010), or hexadecimal (for example -0xffff). The result can be used in arithmetic,
--- and the arithmetic will be 64-bit integer arithmetic rather than floating-point arithmetic. (Operations on
--- an unconverted Lua number use floating-point arithmetic.) The tonumber64() function is added by Tarantool;
--- the name is global.
function tonumber64(value) end

---
--- Parse and execute an arbitrary chunk of Lua code. This function is mainly useful to define and run Lua code without
--- having to introduce changes to the global Lua environment.
--- @param lua_chunk_string string @ Lua code
--- @param lua_chunk_string_argument lua_value @ zero or more scalar values which will be appended to, or substitute for, items in the Lua chunk.
--- @return ... @ whatever is returned by the Lua code chunk.
function dostring(lua_chunk_string, lua_chunk_string_argument) end

---
--- @field path @ This is a string that Tarantool uses to search for Lua modules, especially important for require(). See Modules, rocks and applications. [https://www.tarantool.io/en/doc/latest/book/app_server/creating_app/modules_rocks_and_applications/#app-server-modules]
--- @field cpath @ This is a string that Tarantool uses to search for C modules, especially important for require(). See Modules, rocks and applications. [https://www.tarantool.io/en/doc/latest/book/app_server/creating_app/modules_rocks_and_applications/#app-server-modules]
--- @field loaded @ This is a string that shows what Lua or C modules Tarantool has loaded, so that their functions and members are available. Initially it has all the pre-loaded modules, which don’t need require().
--- @field loaded @ This is a string that shows what Lua or C modules Tarantool has loaded, so that their functions and members are available. Initially it has all the pre-loaded modules, which don’t need require().
package = {}

---
--- Set the search root. The search root is the root directory from which dependencies are loaded.
---
--- The search-root string must contain a relative or absolute path. If it is a relative path, then it will be expanded
--- to an absolute path. If search-root is omitted, or is box.NULL, then the search root is reset to the current directory,
--- which is found with debug.sourcedir().
--- @param search_root string @ the path. Default = current directory.
function package.setsearchroot(search_root) end

---
--- Return a string with the current search root. After package.setsearchroot('/home') the returned string will be /home'.
function package.searchroot() end
