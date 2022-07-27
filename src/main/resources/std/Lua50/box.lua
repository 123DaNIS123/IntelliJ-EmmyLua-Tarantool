--- @module box
--- @field NULL userdata  @ msgpack null value

--- @class Schema
--- @field space Space
--- @field user User
--- @field role Role
--- @field func Function
--- @field sequence SequenceProto
schema = {}

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

--- @class Space
--- @field enabled boolean
--- @field field_count number
--- @field id number
--- @field index Index[] @table of indexes
local spaceObject = {}

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

-- UTILITY

--- @class BoxInfo
--- @field id string @same as replication id
--- @field lsn number
--- @field pid number
--- @field ro boolean @is readonly
--- @field signature number @is the sum of all lsn values from the vector clocks (vclock) of all instances in the replica set.
--- @field status string @corresponds to replication.upstream.status
--- @field uuid string
--- @field vclock number[] @ ontains the vector clock, which is a table of „id, lsn“ pairs, for example vclock: {1: 3054773, 4: 8938827, 3: 285902018}. Even if an instance is removed, its values will still appear here
--- @field version string @ tarantool version
--- @field uptime number @ uptime seconds
--- @field memory BoxInfoMemory
--- @field vinyl table @ vinyl memory statistics
local boxinfo = {}

--- @class BoxInfoMemory
--- @field cache number @ number of bytes used for caching user data. The memtx storage engine does not require a cache, so in fact this is the number of bytes in the cache for the tuples stored for the vinyl storage engine.
--- @field data number @ number of bytes used for storing user data (the tuples) with the memtx engine and with level 0 of the vinyl engine, without taking memory fragmentation into account.
--- @field index number @ number of bytes used for indexing user data, including memtx and vinyl memory tree extents, the vinyl page index, and the vinyl bloom filters.
--- @field lua number @ number of bytes used for Lua runtime.
--- @field net number @ number of bytes used for network input/output buffers.
--- @field tx number @ number of bytes in use by active transactions. For the vinyl storage engine, this is the total size of all allocated objects (struct txv, struct vy_tx, struct vy_read_interval) and tuples pinned for those objects.
local boxinfomemory = {}

--- @return BoxInfoMemory
function boxinfo.memory() end

--- @type BoxInfo
info = {}

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
