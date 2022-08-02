--- @module box
--- @field NULL userdata  @ msgpack null value

--- @class Schema
--- @field space Space
--- @field user User
--- @field role Role
--- @field func Function
--- @field sequence SequenceProto
schema = {}

-- value types for Tarantool:
--- @class function_ptr
local _function_ptr = {}

--- @class scalar
local _scalar = {}

--- @class scalar
local _scalar = {}

--- @class tuple
local _tuple = {}

--- @class field
local _field = {}

--

--- @class Space
--- @field enabled boolean
--- @field field_count number
--- @field id number
--- @field index Index[] @table of indexes
local spaceObject = {}

---
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

---
--- Drop a function tuple. For explanation of how Tarantool maintains function data, see reference on _func space.
--- @param func_name string @the name of the function
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if the _func tuple does not exist.
--- @return nil
function schema.func.drop(func_name, options) end

---
--- Return true if a function tuple exists; return false if a function tuple does not exist.
--- @param func_name string @the name of the function
--- @return boolean
function schema.func.exists(func_name) end

---
--- Reload a C module with all its functions without restarting the server.
---
--- Under the hood, Tarantool loads a new copy of the module (*.so shared library) and starts routing all
--- new request to the new version. The previous version remains active until all started calls are finished. All shared
--- libraries are loaded with RTLD_LOCAL (see “man 3 dlopen”), therefore multiple copies can co-exist without any problems.
--- @param name string @the name of the module to reload
--- @return boolean
function schema.func.reload(name) end

---
--- Create a role. For explanation of how Tarantool maintains role data, see section Roles. [https://www.tarantool.io/en/doc/latest/book/box/authentication/#authentication-roles]
--- @param role_name string @name of role, which should conform to the rules for object names
--- @param options table @if_not_exists = true|false (default = false) - boolean; true means there should be no error
---if the role already exists
--- @return nil
function schema.role.create(role_name, options) end

---
--- Drop a role. For explanation of how Tarantool maintains role data, see section Roles.
--- @param role_name string @the name of the role
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if the role does not exist.
function schema.role.drop(role_name, options) end

---
--- Return true if a role exists; return false if a role does not exist.
--- @param role_name string @the name of the role
--- @return  boolean
function schema.role.exists(role_name) end

---
--- Grant privileges to a role.
--- @param role_name string @the name of the role
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @the name of a function or space or sequence or role.
--- @param option table @if_not_exists = true|false (default = false) - boolean; true means there should be no error  if the role already has the privilege.
function schema.role.grant(role_name, privilege, object_type, object_name, option) end

---
--- Return a description of a role’s privileges.
--- @param role_name string @the name of the role
function schema.role.info(role_name) end

---
--- Return a description of a role’s privileges.
--- @param role_name string @the name of the role
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @the name of a function or space or sequence or role.
function schema.role.revoke(role_name, privilege, object_type, object_name) end

---
--- Create a space.
--- @param space_name string @name of space, which should conform to the rules for object names
--- @param options table @see “Options for box.schema.space.create” chart, below
--- @return Space
function schema.space.create(space_name, options) end

---
--- See Upgrading a Tarantool database:
--- [https://www.tarantool.io/en/doc/latest/book/admin/upgrades/#admin-upgrades]
function schema.upgrade() end

---
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

---
--- Drop a user. For explanation of how Tarantool maintains user data, see section Users and reference on _user space.
--- @param user_name @the name of the user
--- @param options table @if_exists = true|false (default = false) - boolean; true means there should be no error if the user does not exist.
function schema.user.drop(user_name, options) end

---
--- Return true if a user exists; return false if a user does not exist. For explanation of how Tarantool maintains
--- user data, see section Users - [https://www.tarantool.io/en/doc/latest/book/box/authentication/#authentication-users]
--- and reference on _user space - [https://www.tarantool.io/en/doc/latest/reference/reference_lua/box_space/_user/#box-space-user].
--- @param user_name @the name of the user
--- @return boolean
function schema.user.exists(user_name) end

---
--- Grant privileges to a user or to another role.
--- @param user_name string @the name of the user.
--- @param privileges string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’ or ‘role’.
--- @param object_name string @name of object to grant permissions for.
--- @param role_name string @name of role to grant to user.
--- @param option table @if_not_exists = true|false (default = false) - boolean; true means there should be no error
function schema.user.grant(user_name, privileges, object_type, object_name, role_name, option) end

---
--- Return a description of a user’s privileges.
--- @param user_name string @the name of the user. This is optional; if it is not supplied, then the information will be for the user who is currently logged in.
function schema.user.info(user_name) end

---
--- Associate a password with the user who is currently logged in, or with the user specified by user-name. The user must exist and must not be ‘guest’.
---
--- Users who wish to change their own passwords should use box.schema.user.passwd(password) syntax.
---
--- Administrators who wish to change passwords of other users should use box.schema.user.passwd(user-name, password) syntax.
--- @param user_name string @user-name
--- @param password string @password
function schema.user.passwd(user_name, password) end

---
--- Return a hash of a user’s password. For explanation of how Tarantool maintains passwords - [https://www.tarantool.io/en/doc/latest/book/box/authentication/#authentication-passwords],
---see section Passwords and reference on _user - [https://www.tarantool.io/en/doc/latest/reference/reference_lua/box_space/_user/#box-space-user] space.
--- @param password string @password
function schema.user.password(password) end

---
--- Revoke privileges from a user or from another role.
--- @param user_name string @the name of the user
--- @param privilege string @‘read’ or ‘write’ or ‘execute’ or ‘create’ or ‘alter’ or ‘drop’ or a combination.
--- @param object_type string @‘space’ or ‘function’ or ‘sequence’.
--- @param object_name string @the name of a function or space or sequence.
--- @param options table @if_exists
function schema.user.revoke(user_name, privilege, object_type, object_name, options) end

-- Sequence

--- @class Sequence
local seqObject = {}

---
--- The alter() function can be used to change any of the sequence’s options. Requirements and restrictions are the
--- same as for box.schema.sequence.create().
--- Options:
---
--- start – the STARTS WITH value. Type = integer, Default = 1.
---
--- min – the MINIMUM value. Type = integer, Default = 1.
---
--- max - the MAXIMUM value. Type = integer, Default = 9223372036854775807.
---
--- There is a rule: min <= start <= max. For example it is illegal to say {start=0} because then the specified start value (0) would be less than the default min value (1).
---
--- There is a rule: min <= next-value <= max. For example, if the next generated value would be 1000, but the maximum value is 999, then that would be considered “overflow”.
---
--- cycle – the CYCLE value. Type = bool. Default = false.
---
--- If the sequence generator’s next value is an overflow number, it causes an error return – unless cycle == true.
---
--- But if cycle == true, the count is started again, at the MINIMUM value or at the MAXIMUM value (not the STARTS WITH value).
---
--- cache – the CACHE value. Type = unsigned integer. Default = 0.
---
--- Currently Tarantool ignores this value, it is reserved for future use.
---
--- step – the INCREMENT BY value. Type = integer. Default = 1.
---
--- Ordinarily this is what is added to the previous value.
--- @param options
function seqObject:alter(options) end

---
--- Since version 2.4.1. Return the last retrieved value of the specified sequence or throw an error if no value has
--- been generated yet (next() has not been called yet, or current() is called right after reset() is called).
function seqObject:current() end

---
--- Drop an existing sequence.
function seqObject:drop() end

---
--- Generate the next value and return it.
---
--- The generation algorithm is simple:
---
--- If this is the first time, then return the STARTS WITH value.
---
--- If the previous value plus the INCREMENT value is less than the MINIMUM value or greater than the MAXIMUM value,
--- that is “overflow”, so either raise an error (if cycle = false) or return the MAXIMUM value (if cycle = true and step
--- < 0) or return the MINIMUM value (if cycle = true and step > 0).
function seqObject:next() end

---
--- Set the sequence back to its original state. The effect is that a subsequent next() will return the start value.
--- This function requires a ‘write’ privilege on the sequence.
function seqObject:reset() end

---
--- Set the “previous value” to new-previous-value. This function requires a ‘write’ privilege on the sequence.
function seqObject:set() end

---
--- Create an index.
---
--- It is mandatory to create an index for a space before trying to insert tuples into it, or select tuples from it.
--- The first created index will be used as the primary-key index, so it must be unique.
--- @param space_object Space @ an object reference
--- @param index_name string @ name of index, which should conform to the rules for object names
--- @param options table @ see “Options for space_object:create_index()”, below
function spaceObject:create_index(space_object, index_name, options) end

---
--- Create a new sequence generator.
---
--- Return:
---
--- a reference to a new sequence object.
---
--- Options:
---
--- start – the STARTS WITH value. Type = integer, Default = 1.
---
--- min – the MINIMUM value. Type = integer, Default = 1.
---
--- max - the MAXIMUM value. Type = integer, Default = 9223372036854775807.
---
--- There is a rule: min <= start <= max. For example it is illegal to say {start=0} because then the specified start value (0) would be less than the default min value (1).
---
--- There is a rule: min <= next-value <= max. For example, if the next generated value would be 1000, but the maximum value is 999, then that would be considered “overflow”.
---
--- There is a rule: start and min and max must all be <= 9223372036854775807 which is 2^63 - 1 (not 2^64).
---
--- cycle – the CYCLE value. Type = bool. Default = false.
---
--- If the sequence generator’s next value is an overflow number, it causes an error return – unless cycle == true.
---
--- But if cycle == true, the count is started again, at the MINIMUM value or at the MAXIMUM value (not the STARTS WITH value).
---
--- cache – the CACHE value. Type = unsigned integer. Default = 0.
---
--- Currently Tarantool ignores this value, it is reserved for future use.
---
--- step – the INCREMENT BY value. Type = integer. Default = 1.
---
--- Ordinarily this is what is added to the previous value.
--- @param name string @ the name of the sequence
--- @param options table @ see a quick overview in the “Options for box.schema.sequence.create()” chart (in the Sequences section of the “Data model” chapter), and see more details below.
function schema.sequence.create(name, options) end



--- @class Session
--- @field storage @ A Lua table that can hold arbitrary unordered session-specific names and values, which will last until the session ends. For example, this table could be useful to store current tasks when working with a Tarantool queue manager - [https://github.com/tarantool/queue]
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

---
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
function backup.start(n) end

---
--- Informs the server that normal operations may resume.
function backup.stop() end

-- box.ctl

ctl = {}

---
--- Check whether the recovery process has finished.
--- Until it has finished, space changes such as insert or update are not possible.
--- Return: true if recovery has finished, otherwise false
--- @return boolean
function ctl.is_recovery_finished() end

---
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

---
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

---
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

---
--- Wait until box.info.ro is true.
---
--- Parameters: timeout (number) – maximum number of seconds to wait
---
--- Return: nil, or error may be thrown due to timeout or fiber cancellation
--- @param number number
--- @return Error|nil
function ctl.wait_ro(number) end

---
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


-- function box.error() end

---
--- Since version 2.4.1. Errors can be organized into lists. To achieve this, a Lua table representing an error object
--- has .prev field and e:set_prev(err) method.
---
--- error_object.prev --
--- Return a previous error, if any.
---
--- error_object:set_prev(error object) --
--- Set an error as the previous error. Accepts an error object or nil.
--- @class Error
--- @field prev
local errorObject = {}

---
--- Set an error as the previous error. Accepts an error object or nil.
--- @param err Error|nil
function errorObject:set_prev(err) end

---
--- Set an error as the previous error. Accepts an error object or nil.
--- @param error_object Error
function errorObject:set_prev(error_object) end

---
--- Clear the record of errors, so functions like box.error() or box.error.last()
--- will have no effect.
function error.clear() end

---
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
--- @return table
function error.last() end

local errorLast = error.last()

---
function errorLast:unpack() end

---
--- Create an error object, but not throw it as box.error() does.
--- This is useful when error information should be saved for later retrieval. Since version 2.4.1,
--- to set an error as the last explicitly use box.error.set().
---
--- Parameters:
---
--- code (number) – number of a pre-defined error
--- errtext(s) (string) – part of the message which will accompany the error
--- @param code number @number of a pre-defined error
--- @param errtext string @part of the message which will accompany
function error.new(code, errtext) end

---
--- Since version 2.4.1. Set an error  as the last system error explicitly.
--- Accepts an error object and makes it available via box.error.last().
--- @param errorObject Error
function error.set(errorObject) end

-- SPACES

---
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
--- @field type string @ Index type, 'TREE' or 'HASH' or 'BITSET' or 'RTREE'.
--- @field unique boolean @  True if the index is unique, false if the index is not unique. rtype: boolean
--- @field parts table
local indexObj = {}
-- @field type string @type of index (hash, tree, rtree, bitset, etc.)

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

---
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

---
--- Total amount of tuples (not that in vinyl engine this does not work)
--- @return number
function spaceObject:len() end

--- @param trigger any
function spaceObject:on_replace(trigger) end

--- @param trigger any
--- @param oldTrigger any
--- @return any
function spaceObject:on_replace(trigger, oldTrigger) end

---
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

--- @return Iterator
function spaceObject:pairs() end

--- @param key number|string|table
--- @return Iterator
function spaceObject:pairs(key) end

--- @param key number|string|table
--- @param Iterator Iterator
--- @return Iterator
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

---
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
--- @field setuid boolean @treat function caller as function creator (e.g. if this function was defined by 'admin', anybody, who called this function will be treated like 'admin' user)
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

---
--- This function reloads C module dynamically.
function funcObject.reload() end

---
--- This function reloads C module dynamically.
--- @param name string @module name
function funcObject.reload(name) end

-- SEQUENCE
-- box sequence table

--- @type Sequence[]
sequence = {}

--- @class SequenceProto
local seq = {}

---
--- @class SequenceOptions
--- @field start number @sequence starts from this number
--- @field min number
--- @field max number
--- @field cycle boolean
--- @field cache number @reserved for future releases
--- @field step number @increment of the sequence
local seqOptions = {}

---
--- @param name string
--- @return Sequence
function seq.create(name) end

---
--- @param name string
--- @param options SequenceOptions
--- @return Sequence
function seq.create(name, options) end

-- SESSION

---
--- Returns current session ID number
--- @return number @ the unique identifier (ID) for the current session. The result can be 0 or -1 meaning there is no session.
function session.id() end

---
--- @param id number
--- @return number @ true if the session exists, false if the session does not exist
function session.exists(id) end

---
--- Define a trigger for reacting to user’s attempts to execute actions that are not within the user’s privileges.
---
--- If the parameters are (nil, old-trigger-function), then the old trigger is deleted. If both parameters are omitted,
--- then the response is a list of existing trigger functions. Details about trigger characteristics are in the triggers section.
--- @param trigger_function function @ function which will become the trigger function
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr
function session.on_access_denied() end

---
--- This function works only if there is a peer, that is, if a connection has been made to a separate Tarantool instance.
--- @param id number
--- @return string @ The host address and port of the session peer, for example “127.0.0.1:55457”. If the session exists but there is no connection to a separate instance, the return is null. The command is executed on the server instance, so the “local name” is the server instance’s host and port, and the “peer name” is the client’s host and port.
function session.peer(id) end

---
--- Generate an out-of-band message. By “out-of-band” we mean an extra message which supplements what is passed in a
--- network via the usual channels. Although box.session.push() can be called at any time, in practice it is used with
--- networks that are set up with module net.box, and it is invoked by the server (on the “remote database system” to use
--- our terminology for net.box), and the client has options for getting such messages.
---
--- This function returns an error if the session is disconnected.
--- @param message @ what to send
--- @param sync integer @ an optional argument to indicate what the session is, as taken from an earlier call to box.session.sync(). If it is omitted, the default is the current box.session.sync() value. In Tarantool version 2.4.2, sync is deprecated and its use will cause a warning. Since version 2.5.1, its use will cause an error.
--- @return ( nil, Error| boolean) @ If the result is an error, then the first part of the return is nil and the second part is the error object. If the result is not an error, then the return is the boolean value true. When the return is true, the message has gone to the network buffer as a packet with a different header code so the client can distinguish from an ordinary Okay response.
function session.push(id) end

---
--- This function is local for the request, i.e. not global for the session. If the connection behind the session is
--- multiplexed, this function can be safely used inside the request processor.
--- @return number @ the value of the sync integer constant used in the binary protocol. This value becomes invalid when the session is disconnected.
function session.sync() end

---
--- @return string @ the name of the current user
function session.user() end

---
--- Possible return values are:
---
--- ‘binary’ if the connection was done via the binary protocol, for example to a target made with box.cfg{listen=…};
---
--- ‘console’ if the connection was done via the administrative console, for example to a target made with console.listen;
---
--- ‘repl’ if the connection was done directly, for example when using Tarantool as a client;
---
--- ‘applier’ if the action is due to replication, regardless of how the connection was done;
---
--- ‘background’ if the action is in a background fiber, regardless of whether the Tarantool server was started in the background.
---
--- box.session.type() is useful for an on_replace() trigger on a replica – the value will be ‘applier’ if and only if
--- the trigger was activated because of a request that was done on the master.
--- @return string @ the type of connection or cause of action.
function session.type() end

---
--- Every user has a unique name (seen with box.session.user()) and a unique ID (seen with box.session.uid()).
--- The values are stored together in the _user space
--- @return number @ the user ID of the current user.
function session.uid() end

---
--- Change Tarantool’s current user – this is analogous to the Unix command su.
---
--- Or, if function-to-execute is specified, change Tarantool’s current user temporarily while executing the function –
--- this is analogous to the Unix command sudo.
--- @param user_name string @ name of a target user
--- @param function_to_execute any @ name of a function, or definition of a function. Additional parameters may be passed to box.session.su, they will be interpreted as parameters of function-to-execute.
--- @return number @id of the current user
function session.su(user_name, function_to_execute) end

---
--- This is the same as box.session.uid(), except in two cases:
---
--- The first case: if the call to box.session.euid() is within a function invoked by box.session.su(user-name,
--- function-to-execute) – in that case, box.session.euid() returns the ID of the changed user (the user who is specified
--- by the user-name parameter of the su function) but box.session.uid() returns the ID of the original user
--- (the user who is calling the su function).
---
--- The second case: if the call to box.session.euid() is within a function specified with
--- box.schema.func.create(function-name, {setuid= true}) and the binary protocol is in use – in that case, box.session.euid()
--- returns the ID of the user who created “function-name” but box.session.uid() returns the ID of the the user who is calling “function-name”.
--- @return string @ the effective user ID of the current user.
function session.euid() end

---
--- Define a trigger for execution when a new session is created due to an event such as console.connect. The trigger
--- function will be the first thing executed after a new session is created. If the trigger execution fails and raises
--- an error, the error is sent to the client and the connection is closed.
--- @param trigger_function function @ function which will become the trigger function
--- @param old_trigger_function function @  existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr
function session.on_connect(trigger, old_trigger) end

---
--- Define a trigger for execution after a client has disconnected. If the trigger function causes an error, the error
--- is logged but otherwise is ignored. The trigger is invoked while the session associated with the client still exists
--- and can access session properties, such as box.session.id().
---
--- Since version 1.10, the trigger function is invoked immediately after the disconnect, even if requests that were made
--- during the session have not finished.
--- @param trigger_function function @ function which will become the trigger function
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr
function session.on_disconnect(trigger, old_trigger) end

---
--- Define a trigger for execution during authentication.
---
--- The on_auth trigger function is invoked in these circumstances:
--- The console.connect function includes an authentication check for all users except ‘guest’. For this case, the
--- on_auth trigger function is invoked after the on_connect trigger function, if and only if the connection has succeeded so far.
--- The binary protocol has a separate authentication packet. For this case, connection and authentication are considered
--- to be separate steps.
--- Unlike other trigger types, on_auth trigger functions are invoked before the event. Therefore a trigger function
--- like function auth_function () v = box.session.user(); end will set v to “guest”, the user name before the authentication is done. To get the user name after the authentication is done, use the special syntax: function auth_function (user_name) v = user_name; end
---
--- If the trigger fails by raising an error, the error is sent to the client and the connection is closed.
--- @param trigger_function function @ function which will become the trigger function
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr
function session.on_auth(trigger, old_trigger) end

-- INDICES

--- @class IndexSearchOptions
--- @field iterator string @type of iterator
--- @field limit number
--- @field offset number
local indexSearch = {}

-- Search for a tuple or a set of tuples via the given index, and allow iterating over one tuple at a time.
--
-- The key parameter specifies what must match within the index.
-- @param key number|string|table
-- @return iterator
-- function indexObj:pairs(key) end

---
--- Search for a tuple or a set of tuples via the given index, and allow iterating over one tuple at a time.
---
--- The key parameter specifies what must match within the index.
--- @param key scalar|table @ value to be matched against the index key, which may be multi-part
--- @param iterator Iterator @ The default iterator type is ‘EQ’
--- @return Iterator @ iterator which can be used in a for/end loop or with totable()
function indexObj:pairs(key, iterator) end

---
--- This is an alternative to box.space…select() which goes via a particular index and can make use of additional
--- parameters that specify the iterator type, and the limit, and the offset.
--- @param key scalar|table @ values to be matched against the index key
--- @param options table|nil @ none, any, or all of the following parameters: iterator – type of iterator | limit – maximum number of tuples | offset – start tuple number (do not use it. See warning)
--- @return tuple @ the tuple or tuples that match the field values.
function indexObj:select(key, options) end

---
--- Search for a tuple via the given index, as described earlier.
--- @param key scalar|table @ values to be matched against the index key
--- @return tuple @ the tuple whose index-key fields are equal to the passed key values.
function indexObj:get(key) end

---
--- Find the minimum value in the specified index.
--- @param key scalar|table @ values to be matched against the index key
--- @return tuple @ the tuple for the first key in the index. If the optional key value is supplied, returns the first key that is greater than or equal to key. Starting with Tarantool 2.0.4, index_object:min(key) returns nothing if key doesn’t match any value in the index.
function indexObj:min(key) end

---
--- Find the maximum value in the specified index.
--- @param key scalar|table @ values to be matched against the index key
--- @return tuple @the tuple for the last key in the index. If the optional key value is supplied, returns the last key that is less than or equal to key. Starting with Tarantool 2.0.4, index_object:max(key) returns nothing if key doesn’t match any value in the index.
function indexObj:max(key) end

---
--- Find a random value in the specified index. This method is useful when it’s important to get insight
--- into data distribution in an index without having to iterate over the entire data set.
---
--- Complexity factors: Index size, Index type.
---
--- Note re storage engine: vinyl does not support random()
--- @param seed number @ an arbitrary non-negative integer
--- @return tuple @ the tuple for the random key in the index.
function indexObj:random(seed) end

---
--- Iterate over an index, counting the number of tuples which match the key-value.
--- @param key scalar|table @ values to be matched against the index key
--- @param iterator Iterator @ comparison method
--- @return number @ the number of matching tuples.
function indexObj:count(key, iterator) end

---
--- Update a tuple.
---
--- Same as box.space…update(), but key is searched in this index instead of primary key. This index should be unique.
--- @param key scalar|table @ values to be matched against the index key
--- @param operator string @ operation type represented in string
--- @param field_identifier field|string @ what field the operation will apply to. The field number can be negative, meaning the position from the end of tuple. (#tuple + negative field number + 1)
--- @param value @ what value will be applied
--- @return tuple|nil @ the updated tuple. nil if the key is not found
function indexObj:update(key, operator, field_identifier, value) end

-- Users can define any functions they want, and associate them with indexes: in effect they can make their own index methods. They do this by:
--
-- creating a Lua function,
-- adding the function name to a predefined global variable which has type = table, and
-- invoking the function any time thereafter, as long as the server is up, by saying index_object:function-name([parameters]).
-- There are three predefined global variables:
--
-- Adding to box_schema.index_mt makes the method available for all indexes.
-- Adding to box_schema.memtx_index_mt makes the method available for all memtx indexes.
-- Adding to box_schema.vinyl_index_mt makes the method available for all vinyl indexes.
-- This index ought to be unique.
-- @param any_name @ whatever the user defines
-- function indexObj:user_defined(key) end

---
--- Delete a tuple identified by a key.
---
--- Same as box.space…delete(), but key is searched in this index instead of in the primary-key index.
--- This index ought to be unique.
--- @param key scalar|table @ values to be matched against the index key
--- @return tuple @ the deleted tuple.
function indexObj:delete(key) end

---
--- Alter options. Vinyl engine does not support this function.
---
--- Alter an index. It is legal in some circumstances to change one or more of the index characteristics,
--- for example its type, its sequence options, its parts, and whether it is unique. Usually this causes rebuilding
--- of the space, except for the simple case where a part’s is_nullable flag is changed from false to true.
--- @param index_object Index
--- @param options table
function indexObj:alter(index_object, options) end
-- was: @param options IndexOptions changed to:

---
--- Drop an index. Dropping a primary-key index has
--- a side effect: all tuples are delete
--- @return nil
function indexObj:drop() end

---
--- Rename an index.
--- @param new_name string @ new name for index
--- @return nil
function indexObj:rename(new_name) end

---
--- Returns number of bytes taken by this index.
--- @return number
function indexObj:bsize() end

-- << Added indexObj functions

---
--- An array describing the index fields. To learn more about the index field types,
--- refer to this table: https://www.tarantool.io/en/doc/latest/reference/reference_lua/box_space/create_index/#box-space-index-field-types
--- @return table
function indexObj:parts() end

---
--- Remove unused index space. For the memtx storage engine this method does nothing;
--- index_object:compact() is only for the vinyl storage engine. For example, with vinyl,
--- if a tuple is deleted, the space is not immediately reclaimed. There is a scheduler for
--- reclaiming space automatically based on factors such as lsm shape and amplification as discussed in the section
--- Storing data with vinyl, so calling index_object:compact() manually is not always necessary.
---
--- Return: nil (Tarantool returns without waiting for compaction to complete)
--- @return nil
function indexObj:compact() end

---
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

---
--- Since box.info contents are dynamic, it’s not possible to iterate over keys with the Lua pairs() function. For this purpose, box.info() builds and returns a Lua table with all keys and values provided in the submodule.
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
local boxinfo = {}

--- @class BoxInfoMemory
--- @field cache number @ number of bytes used for caching user data. The memtx storage engine does not require a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
--- @field data number @ number of bytes used for storing user data (the tuples) with the memtx engine and with level 0 of the vinyl engine, without taking memory fragmentation into account.
--- @field index number @ number of bytes used for indexing user data, including memtx and vinyl memory tree extents, the vinyl page index, and the vinyl bloom filters.
--- @field lua number @ number of bytes used for Lua runtime.
--- @field net number @ number of bytes used for network input/output buffers.
--- @field tx number @ number of bytes in use by active transactions. For the vinyl storage engine, this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.
local boxinfomemory = {}

---
--- This function gives the admin user a picture of the whole Tarantool instance.
--- @field cache number @number of bytes used for caching user data. The memtx storage engine does not require a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
--- @field data number @number of bytes used for storing user data (the tuples) with the memtx engine and with level 0 of the vinyl engine, without taking memory fragmentation into account.
--- @field index number @number of bytes used for indexing user data, including memtx and vinyl memory tree extents, the vinyl page index, and the vinyl bloom filters.
--- @field lua number number of bytes used for Lua runtime.
--- @field net number number of bytes used for network input/output buffers.
--- @field tx number number of bytes in use by active transactions. For the vinyl storage engine, this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.
--- @return BoxInfoMemory
function info.memory() end

-- box.info

info = {}

---
--- Since version 2.6.1. Show the current state of a replica set node in regards to leader election.
---
--- The following information is provided:
---
--- state – election state (mode) of the node. Possible values are leader, follower, or candidate. For more details, refer to description of the leader election process. When election is enabled, the node is writable only in the leader state.
--- term – current election term.
--- vote – ID of a node the current node votes for. If the value is 0, it means the node hasn’t voted in the current term yet.
--- leader – leader node ID in the current term. If the value is 0, it means the node doesn’t know which node is the leader in the current term.
--- leader_idle – time in seconds since the last interaction with the known leader. Since version 2.10.0
---
--- Note
---
--- IDs in the box.info.election output are the replica IDs visible in the box.info.id output on each node and in the _cluster space.
info.election = {}

---
--- Since version 2.4.1. Return a real address to which an instance was bound. For example, if box.cfg{listen} was set with a zero port, box.info.listen will show a real port. The address is stored as a string:
---
--- unix/:<path> for UNIX domain sockets
---
--- <ip>:<port> for IPv4
---
--- [ip]:<port> for IPv6
---
--- If an instance does not listen to anything, box.info.listen is nil.
info.listen = {}

-- classes

---
--- The replication section of box.info() is a table array with statistics for all instances in the replica set that
--- the current instance belongs to (see also “Monitoring a replica set”):
---
--- In the following, n is the index number of one table item, for example replication[1], which has data about server instance
--- number 1, which may or may not be the same as the current instance (the “current instance” is what is responding to box.info).
--- @class Replication
--- @field id @ is a short numeric identifier of instance n within the replica set. This value is stored in the box.space._cluster system space.
--- @field uuid @ is a globally unique identifier of instance n. This value is stored in the box.space._cluster system space
--- @field lsn @ is the log sequence number (LSN) for the latest entry in instance n’s write ahead log (WAL).
--- @field upstream @ appears (is not nil) if the current instance is following or intending to follow instance n, which ordinarily means replication[n].upstream.status = follow, replication[n].upstream.peer = url of instance n which is being followed, replication[n].lag and idle = the instance’s speed, described later. Another way to say this is: replication[n].upstream will appear when replication[n].upstream.peer is not of the current instance, and is not read-only, and was specified in box.cfg{replication={...}}, so it is shown in box.cfg.replication.
--- @field downstream @ appears (is not nil) with data about an instance that is following instance n or is intending to follow it, which ordinarily means replication[n].downstream.status = follow,
local replicationObj = {}

--- @type Replication[]
info.replication = {}

--- @class Replication_Downstream
--- @field vclock @ contains the vector clock, which is a table of ‘id, lsn’ pairs, for example vclock: {1: 3054773, 4: 8938827, 3: 285902018}. (Notice that the table may have multiple pairs although vclock is a singular name).
--- @field idle @ is the time (in seconds) since the last time that instance n sent events through the downstream replication.
--- @field status @ is the replication status for downstream replications: * stopped means that downstream replication has stopped, * follow means that downstream replication is in progress (instance n is ready to accept data from the master or is currently doing so).
--- @field message @ will be nil unless a problem occurs with the connection. For example, if instance n goes down, then one may see status = 'stopped', message = 'unexpected EOF when reading from socket', and system_message = 'Broken pipe'. See also degraded state.
--- @field system_message
local repObj_downstream = {}

--- @type Replication_Downstream
info.replication[number].downstream = {}

--- @class Replication_Upstream
--- @field status @ is the replication status of the connection with instance n: * auth means that authentication is happening. * connecting means that connection is happening. * disconnected means that it is not connected to the replica set (due to network problems, not replication errors). * follow means that the current instance’s role is “replica” (read-only, or not read-only but acting as a replica for this remote peer in a master-master configuration), and is receiving or able to receive data from instance n’s (upstream) master. * stopped means that replication was stopped due to a replication error (for example duplicate key). * sync means that the master and replica are synchronizing to have the same data.
--- @field idle @ is the time (in seconds) since the last event was received. This is the primary indicator of replication health. See more in Monitoring a replica set.
--- @field peer @ contains instance n’s URI for example 127.0.0.1:3302. See more in Monitoring a replica set.
--- @field lag @ is the time difference between the local time of instance n, recorded when the event was received, and the local time at another master recorded when the event was written to the write ahead log on that master. See more in Monitoring a replica set.
--- @field message @ contains an error message in case of a degraded state, otherwise it is nil.
local repObj_upstream = {}

--- @type Replication_Upstream
info.replication[number].upstream = {}

---
--- The gc function of box.info gives the admin user a picture of the factors that affect the Tarantool
--- garbage collector. The garbage collector compares vclock (vector clock) values of users and checkpoints,
--- garbage collector. The garbage collector compares vclock (vector clock) values of users and checkpoints,
--- so a look at box.info.gc() may show why the garbage collector has not removed old WAL files,
--- or show what it may soon remove.
---
--- gc().consumers @a list of users whose requests might affect the garbage collector.
---
--- gc().checkpoints @a list of users whose requests might affect the garbage collector.
---
--- gc().checkpoints[n].references @a list of references to a checkpoint.
---
--- gc().checkpoints[n].vclock @a checkpoint’s vclock value.
---
--- gc().checkpoints[n].signature @a sum of a checkpoint’s vclock’s components.
---
--- gc().checkpoint_is_in_progress @true if a checkpoint is in progress, otherwise false
---
--- gc().vclock @the garbage collector’s vclock.
---
--- gc().signature @the sum of the garbage collector’s checkpoint’s components.
function info.gc() end

---
--- a list of users whose requests might affect the garbage collector.
info.gc().consumers = {}

---
--- a list of preserved checkpoints.
info.gc().checkpoints = {}

---
--- a list of references to a checkpoint.
info.gc().checkpoints[n].references = {}

---
--- a checkpoint's vclock value.
info.gc().checkpoints[n].vclock = {}

---
--- a sum of a checkpoint's vclock's components..
info.gc().checkpoints[n].signature = {}

---
--- true if a checkpoint is in progress, otherwise false
info.gc().checkpoint_is_in_progress = {}

---
--- the garbage collector's vclock.
info.gc().vclock = {}

---
--- the sum of the garbage collector's checkpoint's components.
info.gc().signature = {}

-- @class Info
-- @field election
-- @field listen
-- @type BoxInfo
--info = {}

---
--- Since box.info contents are dynamic, it’s not possible to iterate over keys with the Lua pairs() function.
--- For this purpose, box.info() builds and returns a Lua table with all keys and values provided in the submodule.
--- @return table @ keys and values in the submodule
function box.info() end

---
--- List all the anonymous replicas following the instance.
---
--- The output is similar to the one produced by box.info.replication with an exception that anonymous replicas
--- are indexed by their uuid strings rather than server ids, since server ids have no meaning for anonymous replicas.
function info.replication_anon() end

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

---
---The box.cfg submodule is used for specifying server configuration parameters.
---
---To view the current configuration, say box.cfg without braces:
cfg = {}

---
---The box.cfg submodule is used for specifying server configuration parameters.
---
---To view the current configuration, say box.cfg without braces:
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

-- box.runtime [

runtime = {}

---
--- Show runtime memory usage report in bytes.
---
--- The runtime memory encompasses internal Lua memory as well as the runtime arena. The Lua memory stores Lua objects.
--- The runtime arena stores Tarantool-specific objects – for example, runtime tuples, network buffers and other objects
--- associated with the application server subsystem.
--- @return table @ {lua - is the size of the Lua heap that is controlled by the Lua garbage collector , maxalloc - is the maximum size of the runtime memory , used - is the current number of bytes used by the runtime memory}
function runtime.info() end

-- ]

-- added functions:

-- from error:

---
--- Throw an error. This method emulates a request error, with text based on one of
--- the pre-defined Tarantool errors defined in the file errcode.h in the source tree. Lua
--- constants which correspond to those Tarantool errors are defined as members of box.error,
--- for example box.error.NO_SUCH_USER == 45.
---
--- Parameters:
---
--- code (number) – number of a pre-defined error
--- errtext(s) (string) – part of the message which will accompany the error
---
--- When called without arguments, box.error() re-throws whatever the last error was.
--- @param code number
--- @param errtext string
function box.error(code, errtext) end

---
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