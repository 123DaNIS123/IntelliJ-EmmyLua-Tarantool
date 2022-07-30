--- @module box
--- @field NULL userdata  @ msgpack null value

--- @class Schema
--- @field space Space
--- @field user User
--- @field role Role
--- @field func Function
--- @field sequence SequenceProto
schema = {}

--- Create a function tuple without including the body option. For functions created with the body option,
--- see box.schema.func.create(func-name , {options-with-body}).
--- This is called a “not persistent” function because functions without bodies are not persistent. This does not
--- create the function itself – that is done with Lua – but if it is necessary to grant privileges for a function,
--- box.schema.func.create must be done first. For explanation of how Tarantool maintains function data, see the
--- reference for the box.space._func space.
--- @param func_name string @name of function, which should conform to the rules for object names
--- @param options table @if_not_exists, setuid, language, takes_raw_args.
--- @return nil
function schema.func.create(func_name, options) end

--- Drop a function tuple. For explanation of how Tarantool maintains function data, see reference on _func space.
--- @param func_name string @the name of the function
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if the _func tuple does not exist.
--- @return nil
function schema.func.drop(func_name, options) end

--- Return true if a function tuple exists; return false if a function tuple does not exist.
--- @param func_name string @the name of the function
--- @return boolean
function schema.func.exists(func_name) end

--- Reload a C module with all its functions without restarting the server.
--- Under the hood, Tarantool loads a new copy of the module (*.so shared library) and starts routing all
--- new request to the new version. The previous version remains active until all started calls are finished. All shared
--- libraries are loaded with RTLD_LOCAL (see “man 3 dlopen”), therefore multiple copies can co-exist without any problems.
--- @param name string @the name of the module to reload
--- @return boolean
function schema.func.reload(name) end

--- Create a role. For explanation of how Tarantool maintains role data, see section Roles.
--- @param role_name string @name of role, which should conform to the rules for object names
--- @param options table @if_not_exists = true|false (default = false) - boolean; true means there should be no error
---if the role already exists
--- @return nil
function schema.role.create(role_name, options) end

--- Drop a role. For explanation of how Tarantool maintains role data, see section Roles.
--- @param role_name string @the name of the role
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if
--- the role does not exist.
function schema.role.drop(role_name, options) end

--- Grant privileges to a role.
--- @param role_name string @the name of the role
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @the name of a function or space or sequence or role.
--- @param option table @if_not_exists = true|false (default = false) - boolean; true means there should be no error
--- if the role already has the privilege.
function schema.role.grant(role_name, privilege, object_type, object_name, option) end

--- Return a description of a role’s privileges.
--- @param role_name string @the name of the role
function schema.role.info(role_name) end

--- Return a description of a role’s privileges.
--- @param role_name string @the name of the role
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @the name of a function or space or sequence or role.
function schema.role.revoke(role_name, privilege, object_type, object_name) end

--- Create a space.
--- @param space_name string @name of space, which should conform to the rules for object names
--- @param options table @see “Options for box.schema.space.create” chart, below
function schema.space.create(space_name, options) end

--- See Upgrading a Tarantool database:
--- [https://www.tarantool.io/en/doc/latest/book/admin/upgrades/#admin-upgrades]
function schema.upgrade() end

--- Create a user. For explanation of how Tarantool maintains user data, see section Users and reference on _user space.
---
--- The possible options are:
---
--- if_not_exists = true|false (default = false) - boolean; true means there should be no error if the user already exists,
--- password (default = ‘’) - string; the password = password specification is good because in a URI
--- (Uniform Resource Identifier) it is usually illegal to include a user-name without a password.
---
--- Note
---
--- The maximum number of users is 32.
--- @param user_name string @name of user, which should conform to the rules for object names
--- @param options table @if_not_exists, password
--- @return nil
function schema.user.create(user_name, options) end

--- Drop a user. For explanation of how Tarantool maintains user data, see section Users and reference on _user space.
--- @param user_name @the name of the user
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if
--- the user does not exist.
function schema.user.drop(user_name, options) end

--- Return true if a user exists; return false if a user does not exist. For explanation of how Tarantool maintains
--- user data, see section Users - [https://www.tarantool.io/en/doc/latest/book/box/authentication/#authentication-users]
--- and reference on _user space - [https://www.tarantool.io/en/doc/latest/reference/reference_lua/box_space/_user/#box-space-user].
--- @param user_name @the name of the user
--- @return boolean
function schema.user.exists(user_name) end

--- Grant privileges to a user or to another role.
--- @param user_name string @the name of the user.
--- @param privileges string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @name of object to grant permissions for.
--- @param role_name string @name of role to grant to user.
--- @param option table @if_not_exists = true|false (default = false) - boolean; true means there should be no error
function schema.user.grant(user_name, privileges, object_type, object_name, role_name, option) end

--- Return a description of a user’s privileges.
--- @param user_name string @the name of the user. This is optional; if it is not supplied, then the information will
--- be for the user who is currently logged in.
function schema.user.info(user_name) end

--- Associate a password with the user who is currently logged in, or with the user specified by user-name. The user must exist and must not be ‘guest’.
---
--- Users who wish to change their own passwords should use box.schema.user.passwd(password) syntax.
---
--- Administrators who wish to change passwords of other users should use box.schema.user.passwd(user-name, password) syntax.
--- @param user_name string @user-name
--- @param password string @password
function schema.user.passwd(user_name, password) end

--- Revoke privileges from a user or from another role.
---
--- The user must exist, and the object must exist, but if the option setting is {if_exists=true} then it is not an
--- error if the user does not have the privilege.
--- @param user_name string @the name of the user
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’.
--- @param object_name string @the name of a function or space or sequence.
--- @param options table @if_exists
function schema.user.revoke(user_name, privilege, object_type, object_name, options) end


--- @class Session

session = {}

--- @class IndexProto
--- @field EQ string
--- @field REQ string
--- @field LE string
--- @field LT string
--- @field GE string
--- @field GT string
--- @field ALL string
--- @field BITS_ALL_SET string
--- @field BITS_ANY_SET string
--- @field BITS_ALL_NOT_SET string
index = {}

-- box.backup

backup = {}

--- Informs the server that activities related to the removal of outdated
--- backups must be suspended.
---
--- To guarantee an opportunity
--- to copy these files, Tarantool will not delete them. But there will be no
--- read-only mode and checkpoints will continue by schedule as usual.
---
--- Param: number n: optional argument starting with Tarantool 1.10.1 that
--- indicates the checkpoint
--- to use relative to the latest checkpoint. For example ``n = 0`` means
--- “backup will be based on the latest checkpoint”, ``n = 1`` means "backup
--- will be based on the first checkpoint before the latest checkpoint (counting
--- backwards)", and so on. The default value for n is zero.
---
--- Return:  a table with the names of snapshot and vinyl files that should
--- be copied
--- @param n number
--- @return table
function backup.start(n)
    n = 0
end

--- Informs the server that normal operations may resume.
function backup.stop() end

-- box.ctl

ctl = {}

--- Check whether the recovery process has finished.
--- Until it has finished, space changes such as insert or update are not possible.
--- Return: true if recovery has finished, otherwise false
--- @return boolean
function ctl.is_recovery_finished() end


--- The box.ctl submodule also contains two functions for the two server trigger definitions:
--- on_shutdown and on_schema_init. Please, familiarize yourself with the mechanism of trigger functions before using them.
--- Create a “schema_init trigger”. The trigger-function will be executed when box.cfg{} happens for the first time.
--- That is, the schema_init trigger is called before the server’s configuration and recovery begins,
--- and therefore box.ctl.on_schema_init must be called before box.cfg is called.
---
--- Parameters:
--- trigger-function (function) – function which will become the trigger function
---
--- old-trigger-function (function) – existing trigger function which will be replaced by trigger-function
---
--- Return: nil or function pointer
--- @param trigger_function function
--- @param old_trigger_function function
--- @return function_ptr|nil
function ctl.on_schema_init(trigger_function, old_trigger_function) end


--- Create a “shutdown trigger”. The trigger-function will be executed whenever os.exit() happens,
--- or when the server is shut down after receiving a SIGTERM or SIGINT or SIGHUP signal
--- (but not after SIGSEGV or SIGABORT or any signal that causes immediate program termination).
---
--- Parameters:
---
--- trigger-function (function) – function which will become the trigger function
--- old-trigger-function (function) – existing trigger function which will be replaced by trigger-function
---
--- Return: nil or function pointer
--- @param trigger_function function
--- @param old_trigger_function function
--- @return function_ptr|nil
function ctl.on_shutdown(trigger_function, old_trigger_function) end


--- Wait, then choose new replication leader.
---
--- For synchronous transactions it is possible that a new leader will be chosen but the
--- transactions of the old leader have not been completed. Therefore to finalize the transaction,
--- the function box.ctl.promote() should be called, as mentioned in the notes for leader election.
--- The old name for this function is box.ctl.clear_synchro_queue().
---
---The election state should change to leader.
---
---Parameters: none
---
---Return: nil or function pointer
---@return function_ptr|nil
function ctl.promote() end


--- Wait until box.info.ro is true.
---
--- Parameters: timeout (number) – maximum number of seconds to wait
---
--- Return: nil, or error may be thrown due to timeout or fiber cancellation
--- @param number number
--- @return Error|nil
function ctl.wait_ro(number) end


--- Wait until box.info.ro is false.
---
--- Parameters: timeout (number) – maximum number of seconds to wait
---
--- Return: nil, or error may be thrown due to timeout or fiber cancellation
--- @param number number
--- @return Error|nil
function ctl.wait_rw(number) end


-- box.error

error = {}

---
--- Clear the record of errors, so functions like box.error() or box.error.last()
--- will have no effect.
function error.clear() end

-- function box.error() end

--- @class Error
--- @field prev
local errorObject = {}

--- Clear the record of errors, so functions like box.error() or box.error.last()
--- will have no effect.
function error.clear() end

--- Return a description of the last error, as a Lua table with four members:
---
--- “code” (number) error’s number
---
--- “type” (string) error’s C++ class
---
--- “message” (string) error’s message
---
--- “trace” (table) with 2 members:
---
--- “line” (number) Tarantool source file line number
---
--- “file” (string) Tarantool source file
---
--- Additionally, if the error is a system error (for example due to a failure in socket or file io),
--- there may be a fifth member: “errno” (number) C standard error number.
--- @param error Error
--- @return table
function error.last() end

--- Create an error object, but not throw it as box.error() does.
--- This is useful when error information should be saved for later retrieval. Since version 2.4.1,
--- to set an error as the last explicitly use box.error.set().
---
--- Parameters:
---
--- code (number) – number of a pre-defined error
--- errtext(s) (string) – part of the message which will accompany the error
--- @param code number
--- @param errtext string
function error.new(code, errtext) end

--- Since version 2.4.1. Set an error  as the last system error explicitly.
--- Accepts an error object and makes it available via box.error.last().
--- @param errorObject Error
function error.set(errorObject) end

--- @class Space
--- @field enabled boolean
--- @field field_count number
--- @field id number
--- @field index Index[] @table of indexes
local spaceObject = {}

-- SPACES

--- Box runtime spaces table
--- @type Space[]
space = {}

--- @class SpaceOptions
--- @field temporary boolean
--- @field id number
--- @field field_count number
--- @field if_not_exists boolean
--- @field engine string
--- @field format table
local sp_options = {}

--- @class Iterator
--- @field iterator string @comparison method
local iter = {}

--- @class Index
--- @field type string @type of index (hash, tree, rtree, bitset, etc.)
--- @field unique boolean
--- @field parts table
local indexObj = {}

--- @class IndexOptions
--- @field type string @type of index (hash, tree, rtree, bitset, etc.)
--- @field id number @unique ID of this index, may be set automatically
--- @field unique boolean
--- @field if_not_exists boolean
--- @field parts table
--- @field sequence string|number
local indexOpts = {}

--- @param name string
--- @return Space
function spaceObject.create(name) end

--- @overload
--- @param name string
--- @param options SpaceOptions
function spaceObject.create(name, options) end

--- @param table table
--- @return table
function spaceObject:select(table) end

--- Returns number of bytes taken by this space
--- @return number
function spaceObject:bsize() end

--- @param key number|string|table
--- @param iterator Iterator
--- @return number
function spaceObject:count(key, iterator) end

--- @param key number|string|table
--- @return number
function spaceObject:count(key) end

--- @param name string
--- @return Index
function spaceObject:create_index(name) end

--- @param name string
--- @param options IndexOptions
--- @return Index
function spaceObject:create_index(name, options) end

--- @param key number|string|table
--- @return table
function spaceObject:delete(key) end

function spaceObject:drop() end

--- @class Format
--- @field name string @name of parameter.
--- @field type string @one of (boolean, string, unsigned, etc.)
local format = {}

--- @return Format[]
function spaceObject:format() end

--- @overload
--- @param description Format[]
function spaceObject:format(description) end



--- @param key number|string|table
--- @return table
function spaceObject:get(key) end

--- @param tuple table
--- @return table
function spaceObject:insert(tuple) end

--- Total amount of tuples (not that in vinyl engine this does not work)
--- @return number
function spaceObject:len() end

--- @param trigger any
function spaceObject:on_replace(trigger) end

--- @param trigger any
--- @param oldTrigger any
--- @return any
function spaceObject:on_replace(trigger, oldTrigger) end

--- This is a template of on_replace or before_replace trigger
--- If this function returns nothing, then proceed
--- If this function returns old one - rollback
--- If this function returns new - nothing changes
--- @param old table @changing tuple
--- @param new table @new tuple
function REPLACE_TRIGGER (old, new) end

--- @param trigger any
function spaceObject:before_replace(trigger) end

--- @param trigger any
--- @param oldTrigger any
--- @return any
function spaceObject:before_replace(trigger, oldTrigger) end

--- @return iterator
function spaceObject:pairs() end

--- @param key number|string|table
--- @return iterator
function spaceObject:pairs(key) end

--- @param key number|string|table
--- @param iterator Iterator
--- @return iterator
function spaceObject:pairs(key, iterator) end

--- @param new_name string
function spaceObject:rename(new_name) end

--- @param tuple table
--- @return table
function spaceObject:replace(tuple) end

--- @param tuple table
--- @return table
function spaceObject:put(tuple) end

--- @param run boolean
function spaceObject:run_triggers(run) end

--- @return table
function spaceObject:select() end

--- @param key number|string|table
--- @return table
function spaceObject:select(key) end

--- Delete all records
function spaceObject:truncate() end

--- @param key number|string|table
--- @param updates table @update format: {param (+,-,= ...), field_no, new_value}
function spaceObject:update(key, updates) end

--- @param default table @default value to be inserted if not found
--- @param updates table @update format: {param (+,-,= ...), field_no, new_value}
function spaceObject:upsert(default, updates) end



-- USERS

--- @class User
local userObject = {}

--- @class UserCreationOptions
--- @field if_not_exists boolean
--- @field password string
local useropts = {}

--- @param name string
--- @return User
function userObject.create(name) end

--- @param name string
--- @param options UserCreationOptions
--- @return User
function userObject.create(name, options) end

--- @param name string
--- @return boolean
function userObject.exists(name) end

--- @class GrantorOptions
--- @field grantor string | number
--- @field if_not_exists boolean

--- @overload
--- @param name string
--- @param privileges string
--- @param objectType string @space or function or sequence
--- @param objectName string @name of an object
--- @param roleName string
--- @param options GrantorOptions
function userObject.grant(name, privileges, objectType, objectName, roleName, options) end

--- @overload
--- @param name string
--- @param privileges string
--- @param objectType string @'universe' must be provided
function userObject.grant(name, privileges, objectType) end

--- @overload
--- @param name string
--- @param role string
function userObject.grant(name, role) end

--- @param name string
--- @param privileges string
--- @param objectType string @space or function or sequence
--- @param objectName string @name of an object
function userObject.revoke(name, privileges, objectType, objectName) end

--- @param name string
--- @param role string
function userObject.revoke(name, role) end

--- @param password string @this will be hashed
--- @return string
function userObject.password(password) end

--- @param user string @username to change password
--- @param password string
function userObject.passwd(user, password) end

--- @param password string
function userObject.passwd(password) end

function userObject.info() end

--- @param username string
function userObject.info(username) end


-- ROLES

--- @class RoleOptions
--- @field if_not_exists boolean
local roleOptions = {}

--- @class Role
local roleObject = {}

--- @param role_name string
function roleObject.create(role_name) end
--- @param role_name string
--- @param options RoleOptions
function roleObject.create(role_name, options) end

function roleObject.drop() end
--- @param role_name string
function roleObject.drop(role_name) end

--- @param role_name string
--- @return boolean
function roleObject.exists(role_name) end

--- @param name string @role name
--- @param privileges string @read, write or execute
--- @param objectType string @space or function or sequence
--- @param objectName string @name of an object
--- @param roleName string
--- @param options RoleOptions
function roleObject.grant(name, privileges, objectType, objectName, roleName, options) end

--- @param name string
--- @param privileges string
--- @param objectType string @'universe' must be provided
function roleObject.grant(name, privileges, objectType) end

--- Acts like user.grant (inheritance)
--- @param name string
--- @param role string
function roleObject.grant(name, role) end

--- @param name string @role name
--- @param privileges string @read, write or execute
--- @param objectType string @space or function or sequence
--- @param objectName string @name of an object
function roleObject.revoke(name, privileges, objectType, objectName) end

--- @param role_name string
function roleObject.info(role_name) end

-- FUNCTIONS

--- @class FuncOptions
--- @field if_not_exists boolean
--- @field setuid boolean @treat function caller as function creator (e.g. if this function was defined by 'admin', anybody,
--- who called this function will be treated like 'admin' user)
--- @field language string @either LUA or C
local funcOptions = {}

--- @class FuncDropOptions
--- @param if_exists boolean
local funcDropOptions

--- @class Function
local funcObject = {}

--- @param name Function
function funcObject.create(name) end
--- @param name Function
--- @param options FuncOptions
function funcObject.create(name, options) end

--- @param name string
function funcObject.drop(name) end

--- @param name string
--- @param options FuncDropOptions
function funcObject.drop(name, options) end

--- @param name string
--- @return boolean
function funcObject.exists(name) end

--- This function reloads C module dynamically.
function funcObject.reload() end

--- This function reloads C module dynamically.
--- @param name string @module name
function funcObject.reload(name) end

-- SEQUENCE
-- box sequence table
--- @type Sequence[]
sequence = {}

--- @class SequenceProto
local seq = {}

--- @class SequenceOptions
--- @field start number @sequence starts from this number
--- @field min number
--- @field max number
--- @field cycle boolean
--- @field cache number @reserved for future releases
--- @field step number @increment of the sequence
local seqOptions = {}

--- @class Sequence
local seqObject = {}

--- @param name string
--- @return Sequence
function seq.create(name) end

--- @param name string
--- @param options SequenceOptions
--- @return Sequence
function seq.create(name, options) end

--- Increment the sequence
function seqObject:next() end

--- @param options SequenceOptions
function seqObject:alter(options) end

function seqObject:reset() end

--- @param newValue number @previous value, from where this sequence continues
function seqObject:set(newValue) end

function seqObject:drop() end

-- SESSION

--- Returns current session ID number
--- @return number
function session.id() end

--- @param id number
--- @return number @(1 - true, 0 - false)
function session.exists(id) end

--- @param id number
--- @return string @peer connection string
function session.peer(id) end

--- @return number
function session.sync() end

--- @return string @current user name
function session.user() end

--- Retrieves current session type (binary, console, repl, applier, background, etc..)
--- @return string
function session.type() end

--- Acts like SUDO
--- @param username string
--- @param func any
--- @return number @id of the current user
function session.su(username, func) end

--- Acts like SU (switch user)
--- @param username string
--- @return number @id of the current user
function session.su(username) end

--- @return string @effective ID of the current user
function session.euid() end

function session.on_connect(trigger) end
function session.on_connect(trigger, old_trigger) end
function session.on_disconnect(trigger) end
function session.on_disconnect(trigger, old_trigger) end
function session.on_auth(trigger) end
function session.on_auth(trigger, old_trigger) end

-- INDICES

--- @class IndexSearchOptions
--- @field iterator string @type of iterator
--- @field limit number
--- @field offset number
local indexSearch = {}

--- @param key number|string|table
--- @return iterator
function indexObj:pairs(key) end

--- @param key number|string|table
--- @param iterator Iterator
--- @return iterator
function indexObj:pairs(key, iterator) end

--- @param key number|string|table
--- @param options IndexSearchOptions
--- @return table
function indexObj:select(key, options) end

--- @param key number|string|table
--- @return table
function indexObj:get(key) end

--- @return table
function indexObj:min() end
--- @param key number|string|table
--- @return table
function indexObj:min(key) end

--- @return table
function indexObj:max() end
--- @param key number|string|table
--- @return table
function indexObj:max(key) end

--- Returns random tuple (vinyl engine does not support this function)
--- @param seed number
--- @return table
function indexObj:random(seed) end

--- @return number
function indexObj:count() end
--- @param key number|string|table
--- @return number
function indexObj:count(key) end
--- @param key number|string|table
--- @param iterator Iterator
--- @return number
function indexObj:count(key, iterator) end

--- @param key number|string|table
--- @param update table
--- @return table
function indexObj:update(key, update) end

--- @param key number|string|table
--- @return table
function indexObj:delete(key) end

--- Alter options. Vinyl engine does not support this function.
--- @param options IndexOptions
function indexObj:alter(options) end

--- Drops current index and all bound tuples.
function indexObj:drop() end

--- @param new_name string
function indexObj:rename(new_name) end

--- Returns number of bytes taken by this index.
--- @return number
function indexObj:bsize() end

-- << Added indexObj functions

--- An array describing the index fields. To learn more about the index field types,
--- refer to this table: https://www.tarantool.io/en/doc/latest/reference/reference_lua/box_space/create_index/#box-space-index-field-types
--- @return table
function indexObj:parts() end

--- Remove unused index space. For the memtx storage engine this method does nothing;
--- index_object:compact() is only for the vinyl storage engine. For example, with vinyl,
--- if a tuple is deleted, the space is not immediately reclaimed. There is a scheduler for
--- reclaiming space automatically based on factors such as lsm shape and amplification as discussed in the section
--- Storing data with vinyl, so calling index_object:compact() manually is not always necessary.
---
--- Return: nil (Tarantool returns without waiting for compaction to complete)
--- @return nil
function indexObj:compact() end

--- Return statistics about actions taken that affect the index.
---
--- This is for use with the vinyl engine.
---
--- Some detail items in the output from index_object:stat() are:
---
--- index_object:stat().latency – timings subdivided by percentages;
---
--- index_object:stat().bytes – the number of bytes total;
---
--- index_object:stat().disk.rows – the approximate number of tuples in each range;
---
--- index_object:stat().disk.statement – counts of inserts|updates|upserts|deletes;
---
--- index_object:stat().disk.compaction – counts of compactions and their amounts;
---
--- index_object:stat().disk.dump – counts of dumps and their amounts;
---
--- index_object:stat().disk.iterator.bloom – counts of bloom filter hits|misses;
---
--- index_object:stat().disk.pages – the size in pages;
---
--- index_object:stat().disk.last_level – size of data in the last LSM tree level;
---
--- index_object:stat().cache.evict – number of evictions from the cache;
---
--- index_object:stat().range_size – maximum number of bytes in a range;
---
--- index_object:stat().dumps_per_compaction – average number of dumps required to trigger major compaction in any range of the LSM tree.
---
--- Summary index statistics are also available via box.stat.vinyl().
---
--- Parameters: index_object (index_object) – an object reference.
--- @param indexObj Index
--- @return table statistics
function indexObj:stat() end

-- >>

-- UTILITY

--- @class BoxInfo
--- @field version string @ tarantool version
--- @field id string @same as replication id
--- @field ro boolean @is readonly
--- @field uuid string
--- @field package string
--- @field cluster @a table array with statistics for all instances in the replica set that the current instance belongs to
--- @field listen string @Return a real address to which an instance was bound
--- @field replication table @a table array with statistics for all instances in the replica set that the current instance belongs to
--- @field signature number @is the sum of all lsn values from the vector clocks (vclock) of all instances in the replica set.
--- @field status string @corresponds to replication.upstream.status
--- @field vinyl table @ vinyl memory statistics
--- @field uptime number @ uptime seconds
--- @field lsn number
--- @field sql
--- @field gc
--- @field pid number
--- @field memory BoxInfoMemory
--- @field vclock number[] @ ontains the vector clock, which is a table of „id, lsn“ pairs, for example vclock: {1: 3054773, 4: 8938827, 3: 285902018}. Even if an instance is removed, its values will still appear here
local info = {}

--- @class BoxInfoMemory
--- @field cache number @ number of bytes used for caching user data. The memtx storage engine does not require a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
--- @field data number @ number of bytes used for storing user data (the tuples) with the memtx engine and with level 0 of the vinyl engine, without taking memory fragmentation into account.
--- @field index number @ number of bytes used for indexing user data, including memtx and vinyl memory tree extents, the vinyl page index, and the vinyl bloom filters.
--- @field lua number @ number of bytes used for Lua runtime.
--- @field net number @ number of bytes used for network input/output buffers.
--- @field tx number @ number of bytes in use by active transactions. For the vinyl storage engine, this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.
local boxinfomemory = {}

--- This function gives the admin user a picture of the whole Tarantool instance.
--- @field cache number @number of bytes used for caching user data. The memtx storage engine does not require
--- a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
--- @field data number @number of bytes used for storing user data (the tuples) with the memtx engine and with level 0
--- of the vinyl engine, without taking memory fragmentation into account.
--- @field index number @number of bytes used for indexing user data, including memtx and vinyl memory tree extents,
--- the vinyl page index, and the vinyl bloom filters.
--- @field lua number number of bytes used for Lua runtime.
--- @field net number number of bytes used for network input/output buffers.
--- @field tx number number of bytes in use by active transactions. For the vinyl storage engine,
--- this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.
--- @return BoxInfoMemory
function info.memory() end

-- box.info

--- The gc function of box.info gives the admin user a picture of the factors that affect the Tarantool
--- garbage collector. The garbage collector compares vclock (vector clock) values of users and checkpoints,
--- garbage collector. The garbage collector compares vclock (vector clock) values of users and checkpoints,
--- so a look at box.info.gc() may show why the garbage collector has not removed old WAL files,
--- or show what it may soon remove.
--- @field consumers @a list of users whose requests might affect the garbage collector.
--- @field checkpoints @a list of users whose requests might affect the garbage collector.
--- @field checkpoints.references @a list of references to a checkpoint.
--- @field checkpoints.vclock @a checkpoint’s vclock value.
--- @field checkpoints.signature @a sum of a checkpoint’s vclock’s components.
--- @field checkpoint_is_in_progress @true if a checkpoint is in progress, otherwise false
--- @field vclock @the garbage collector’s vclock.
--- @field signature @the sum of the garbage collector’s checkpoint’s components.
function info.gc() end

--- a list of users whose requests might affect the garbage collector.
function info.gc().consumers end

--- @class Info
--- @field election
--- @field listen
--- @type BoxInfo
info = {}

--123
info.election = {}
info.listen = {}

--- List all the anonymous replicas following the instance.
---
--- The output is similar to the one produced by box.info.replication with an exception that anonymous replicas
--- are indexed by their uuid strings rather than server ids, since server ids have no meaning for anonymous replicas.
function info.replication_anon() end

--- @return BoxInfo
function info() end

--- @class Config
--- @field listen number
--- @field memtx_memory number
--- @field memtx_min_tuple_size number
--- @field memtx_max_tuple_size number
--- @field slab_alloc_factor number
--- @field work_dir string
--- @field memtx_dir string
--- @field wal_dir string
--- @field vinyl_dir
--- @field pid_file string
--- @field username string
--- @field custom_proc_title string
--- @field read_only boolean
--- @field vinyl_memory number
--- @field vinyl_cache number
--- @field vinyl_max_tuple_size number
--- @field vinyl_read_threads number
--- @field vinyl_write_threads number
--- @field vinyl_timeout number
--- @field vinyl_run_count_per_level number
--- @field vinyl_run_size_ratio number
--- @field vinyl_range_size number
--- @field vinyl_page_size number
--- @field vinyl_bloom_fpr number
--- @field log string @connection URI
--- @field background boolean
--- @field checkpoint_interval number
--- @field checkpoint_count number
--- @field force_recovery boolean
--- @field rows_per_wal number
--- @field snap_io_rate_limit number
--- @field wal_mode string
--- @field wal_dir_rescan_delay number
--- @field hot_standby boolean
--- @field replication string @url
--- @field replication_timeout number
--- @field replication_connect_quorum number
--- @field replicaset_uuid string
--- @field instance_uuid string
--- @field io_collect_interval number
--- @field readahead number
--- @field log_level number
--- @field log_nonblock boolean
--- @field too_long_threshold number
--- @field log_format string @plain or json

cfg = {}

--- @param newConfig Config
function cfg(newConfig) end

-- TUPLE

--- @class Tuple
tuple = {}

--- @param value table
--- @return TupleObject
function tuple.new(value) end

--- @class TupleObject
local tupleObject = {}

--- @return number
function tupleObject:bsize() end

--- @param searchValue table
--- @param ... table
--- @return number
function tupleObject:find(searchValue, ...) end

--- @param fieldOffset number
--- @param searchValue table
--- @return number
function tupleObject:find(fieldOffset, searchValue, ...) end
--- @param searchValue table
--- @param ... table
--- @return number
function tupleObject:findall(searchValue, ...) end
--- @param fieldOffset number
--- @param searchValue table
--- @return number
function tupleObject:findall(fieldOffset, searchValue, ...) end

--- @param startno number
--- @param endno number
--- @return any
function tupleObject:unpack(startno, endno) end

--- @param startno number
--- @return any
function tupleObject:unpack(startno) end

--- @return any
function tupleObject:unpack() end

--- @param startno number
--- @param endno number
--- @return table
function tupleObject:totable(startno, endno) end

--- @param startno number
--- @return table
function tupleObject:totable(startno) end

--- @return table
function tupleObject:totable() end

--- @return table
function tupleObject:tomap() end

--- @return iterator
function tupleObject:pairs() end

--- @param updates table
function tupleObject:update(updates) end

-- FUNCTIONS

function begin() end
function commit() end
function rollback() end
--- @return table
function savepoint() end
--- @param sp table @savepoint
function rollback_to_savepoint(sp) end

-- added functions:

-- from error:

--- When called without arguments, box.error() re-throws whatever the last error was.
function error() end

--- When called without arguments, box.error() re-throws whatever the last error was.
--- Throw an error. When called with a Lua-table argument, the code and reason have any user-desired values.
--- The result will be those values.
---
--- Parameters:
---
--- reason (string) – description of an error, defined by user
--- code (integer) – numeric code for this error, defined by user
--- @param code integer
--- @param reason string
function error(reason, code) end

--- Throw an error. This method emulates a request error, with text based on one of
--- the pre-defined Tarantool errors defined in the file errcode.h in the source tree. Lua
--- constants which correspond to those Tarantool errors are defined as members of box.error,
--- for example box.error.NO_SUCH_USER == 45.
---
--- Parameters:
---
--- code (number) – number of a pre-defined error
--- errtext(s) (string) – part of the message which will accompany the error
--- @param code number
--- @param errtext string
function error(code, errtext) end

--- Execute function as a transaction (explicit box.begin/commit, implicit box.rollback)
--- @param func fun(...):any
--- @param ... any
--- @return any
function atomic(func, ...) end

-- SQL

sql = {}

--- @param statement string
function sql.execute(statement) end
function sql.debug() end
