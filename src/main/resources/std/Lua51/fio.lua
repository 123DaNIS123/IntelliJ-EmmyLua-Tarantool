
--- @module fio
local fio = {}

--- @param str string
--- @return string
--- Concatenate partial string, separated by ‘/’ to form a path name.
function fio.pathjoin(str, ...) end

--- @param pathname string
--- Given a full path name, remove all but the final part (the file name). Also remove the suffix, if it is passed.
function fio.basename(pathname) end

--- @param pathname string
--- @param suffix string
--- @return string
function fio.basename(pathname, suffix) end

--- @param path string
--- @return string
--- Given a full path name, remove the final part (the file name).
function fio.dirname(path) end

--- @param file string
--- @return string
--- Given a final part (the file name), return the full path name.
function fio.abspath(file) end

--- @param path string
--- @return string
--- Returns true if path-name refers to a directory or file that exists and is not a broken symbolic link; otherwise false
function path.exists(path) end

--- @param path string
--- @return boolean
function path.is_dir(path) end

--- @param path string
--- @return boolean
function path.is_file(path) end

--- @param path string
--- @return boolean
function path.is_link(path) end

--- @param path string
--- @return boolean
--- Returns true if path-name refers to a directory or file that exists or is a broken symbolic link; otherwise false
function path.lexists(path) end

--- @param mask number
--- @return number
--- Set the mask bits used when creating files or directories. For a detailed description type `man 2 umask`.
--- Returns previous mask bits.
function fio.umask(mask) end

--- @param path string
--- @return table
function fio.stat(path) end

--- @param path string
--- @return table
function fio.lstat(path) end

--- @param path string
function fio.mkdir(path) end

--- @param path string
--- @param mode number
function fio.mkdir(path, mode) end

--- @param path string
function fio.rmdir(path) end

--- @param path string
--- Change working directory. For details type `man 2 chdir`.
function fio.chdir(path) end

--- @param path string
--- @return table
--- List files in directory. The result is similar to the result from the `ls` command.
function fio.listdir(path) end

--- @param path string
--- @return table
--- Return a list of files that match an input string. The list is constructed with a single flag that controls the
--- behavior of the function: `GLOB_NOESCAPE`. For details type `man 3 glob`.
function fio.glob(path) end

--- @return string
function fio.tempdir() end

--- @return string
function fio.cwd() end

--- @param from string
--- @param to string
--- @return boolean, string
--- Copy everything in the from-path, including subdirectory contents, to the to-path.
--- The result is similar to the result that one gets from the `cp -r` command. The to-path should be empty.
function fio.copytree(from, to) end

--- @param path string
--- @return boolean, string
--- Create the path, including subdirectories, but without file contents. The result is similar to the result that one gets from the mkdir command.
function fio.mktree(path) end

--- @param path string
--- @return boolean, string
--- Remove the directory indicated by path-name, including subdirectories.
--- The result is similar to the result that one gets from the `rmdir` command, recursively. The directory must be empty.
function fio.rmtree(path) end

function fio.link(src, dst) end
function fio.symlink(src, dst) end
function fio.readlink(src) end
function fio.unlink(src) end

--- @param path string
--- @param new_path string
--- @return boolean, string
--- Rename a file or directory. For details type `man 2 rename`.
function fio.rename(path, new_path) end

--- @param path string
--- @param new_path string
--- @return boolean, string
--- Copy a file. The effect is similar to the effect that one gets with the `cp` command.
function fio.copyfile(path, new_path) end

--- @param path string
--- @param owner_user string
--- @param owner_group string
--- @return boolean,string
function fio.chown(path, owner_user, owner_group) end

--- @param path string
--- @param rights number
--- @return boolean,string
function fio.chmod(path, rights) end

--- @param path string
--- @param size number
--- Reduce file size to a specified value. For details type `man 2 truncate`.
function fio.truncate(path, size) end

--- @return boolean
--- Ensure that changes are written to disk. For details type `man 2 sync`.
function fio.sync() end

--- @class FileHandle
local fhandle = {}

--- @return boolean
function fhandle:close() end

--- @param count number
--- @param offset number
--- @return string
function fhandle:pread(count, offset) end

function fhandle:pread(buffer, count, offset) end

--- @param string string
--- @param offset number
--- @return boolean
function fhandle:pwrite(string, offset) end

--- @return string
function fhandle:read() end

--- @param count number
--- @return string
function fhandle:read(count) end

--- @param str string
--- @return boolean
function fhandle:write(str) end

--- @param size number
--- @return boolean
function fhandle:truncate(size) end

--- @param position number
--- @return number
function fhandle:seek(position) end

--- @param position number
--- @param offset number
--- @return number
function fhandle:seek(position, offset) end

--- @return table
function fhandle:stat() end

--- @return boolean
function fhandle:fsync() end
--- @return boolean
function fhandle:fdatasync() end

--- @param path string
--- @return FileHandle
function fio.open(path) end

--- @param path string
--- @param flags number|table<string>
--- @return FileHandle
--- flags:
--- O_APPEND (start at end of file),
--- O_ASYNC (signal when IO is possible),
--- O_CLOEXEC (enable a flag related to closing),
--- O_CREAT (create file if it doesn’t exist),
--- O_DIRECT (do less caching or no caching),
--- O_DIRECTORY (fail if it’s not a directory),
--- O_EXCL (fail if file cannot be created),
--- O_LARGEFILE (allow 64-bit file offsets),
--- O_NOATIME (no access-time updating),
--- O_NOCTTY (no console tty),
--- O_NOFOLLOW (no following symbolic links),
--- O_NONBLOCK (no blocking),
--- O_PATH (get a path for low-level use),
--- O_SYNC (force writing if it’s possible),
--- O_TMPFILE (the file will be temporary and nameless),
--- O_TRUNC (truncate)
function fio.open(path, flags) end

--- @param path string
--- @param flags number|table<string>
--- @param mode number
--- @return FileHandle
function fio.open(path, flags, mode) end