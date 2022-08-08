---
--- The errno module is typically used within a function or within a Lua program, in association with a module whose
--- functions can return operating-system errors, such as fio.
--- @module errno

---
--- Return an error number for the last operating-system-related function, or 0. To invoke it, simply say errno(), without the module name.
--- @return integer
function errno() end

---
--- Return a string, given an error number. The string will contain the text of the conventional error message for the
--- current operating system. If code is not supplied, the error message will be for the last operating-system-related
--- function, or 0.
--- @param code integer @ number of an operating-system error
--- @return string
function errno.strerror(code) end
