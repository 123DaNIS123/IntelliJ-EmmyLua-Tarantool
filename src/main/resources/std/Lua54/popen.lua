---
--- Since version 2.4.1, Tarantool has the popen built-in module that supports execution of external programs. It is similar to Python’s subprocess() or Ruby’s Open3. However, Tarantool’s popen module does not have all the helpers that those languages provide, it provides only basic functions. popen uses the vfork() system call to create an object, so the caller thread is blocked until execution of a child process begins.
---
--- The popen module provides two functions to create the popen object:
---
--- popen.shell which is similar to the libc popen syscall
--- popen.new to create a popen object with more specific options
--- Either function returns a handle which we will call popen_handle or ph. With the handle one can execute methods.
--- @module popen

---
--- Execute a shell command.
---
--- Return:
---
--- (if success) a popen handle, which we will call popen_handle or ph
---
--- (if failure) nil, err
---
--- Possible errors: if a parameter is incorrect, the result is IllegalParams: incorrect type or value of a parameter. For other possible errors, see popen.new().
---
--- The possible mode values are:
---
--- 'w' which enables popen_handle:write()
--- 'r' which enables popen_handle:read()
--- 'R' which enables popen_handle:read({stderr = true})
--- 'nil' which means inherit parent’s std* file descriptors
--- Several mode characters can be set together, for example 'rw', 'rRw'.
---
--- The shell function is just a shortcut for popen.new({command}, opts) with opts.shell.setsid and opts.shell.group_signal both set to true, and with opts.stdin and opts.stdout and opts.stderr all set based on the mode parameter.
---
--- All std* streams are inherited from the parent by default unless it is changed using mode: 'r' for stdout, 'R' for stderr, or 'w' for stdin.
--- @param command string @ a command to run, mandatory
--- @param mode string @ communication mode, optional
function shell(command, mode) end

---
--- Execute a child program in a new process.
--- @param argv array @ an array of a program to run with command line options, mandatory; absolute path to the program is required when opts.shell is false (default)
--- @param opts table @ table of options, optional
function new(argv, opts) end

---
--- @class popen_handleObject
popen_handle = {}

---
--- Read data from a child peer.
--- @param opts table @ options
function popen_handle:read(opts) end

---
--- Write string str to stdin stream of a child process.
--- @param str string @ string to write
--- @param opts table @ options
--- @return boolean @ true on success, false on error
function popen_handle:write(str, opts) end

---
--- Close parent’s ends of std* fds.
--- @param opts table @ options
--- @return boolean @ true on success, false on error
function popen_handle:shutdown(opts) end

---
--- Send SIGTERM signal to a child process.
function popen_handle:terminate()end

---
--- Send SIGKILL signal to a child process.
function popen_handle:kill()end

---
--- Send signal to a child process.
--- @param signo number @ signal to send
function popen_handle:signal(signo)end

---
--- Return information about the popen handle.
--- @param signo number @ signal to send
function popen_handle:info() end

---
--- Wait until a child process gets exited or signaled.
--- @param signo number @ signal to send
function popen_handle:wait() end

--
--- Close a popen handle.
function popen_handle:close() end
