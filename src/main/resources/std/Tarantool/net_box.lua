---
--- The net.box module contains connectors to remote database systems. One variant, to be discussed later, is for
--- connecting to MySQL or MariaDB or PostgreSQL (see SQL DBMS modules reference). The other variant, which is discussed
--- in this section, is for connecting to Tarantool server instances via a network.
--- @module net_box

---
--- The names connect() and new() are synonyms: connect() is preferred; new() is retained for backward compatibility.
--- For more information, see the description of net_box.new() below.
function connect(URI, options) end

---
--- Create a new connection. The connection is established on demand, at the time of the first request. It can be
--- re-established automatically after a disconnect (see reconnect_after option below). The returned conn object
--- supports methods for making remote requests, such as select, update or delete.
--- @param URI string @ the URI of the target for the connection
--- @param options @ the supported options are [https://www.tarantool.io/en/doc/latest/reference/reference_lua/net_box/]
--- @return userdata @ conn object
function new(URI, options) end

---
--- @class ConnObject
local connobject = {}

--- @type ConnObject
conn = {}

---
--- Execute a PING command.
--- @param options table @ the supported option is timeout=seconds
--- @return boolean @ true on success, false on erro
function conn:ping(options) end

---
--- Wait for connection to be active or closed.
--- @param timeout number @ in seconds
--- @return boolean @ true when connected, false on failure.
function conn:wait_connected(timeout) end

---
--- Show whether connection is active or closed.
--- @return boolean @ true if connected, false on failure.
function conn:is_connected(timeout) end

---
--- [since 1.7.2] Wait for a target state.
--- @param states string @ target states
--- @param timeout number @ in seconds
--- @return boolean @ true when a target state is reached, false on timeout or connection closure
function conn:wait_state(states, timeout) end

---
--- Close a connection.
---
--- Connection objects are destroyed by the Lua garbage collector, just like any other objects in Lua, so an explicit
--- destruction is not mandatory. However, since close() is a system call, it is good programming practice to close a
--- connection explicitly when it is no longer needed, to avoid lengthy stalls of the garbage collector.
function conn:close() end

---
--- conn:eval(Lua-string) evaluates and executes the expression in Lua-string, which may be any statement or series of
--- statements. An execute privilege is required; if the user does not have it, an administrator may grant it with
--- box.schema.user.grant(username, 'execute', 'universe').
---
--- To ensure that the return from conn:eval is whatever the Lua expression returns, begin the Lua-string with the word “return”.
function conn:eval(Lua_string, arguments, options) end

--- conn:call('func', {'1', '2', '3'}) is the remote-call equivalent of func('1', '2', '3'). That is, conn:call is a
--- remote stored-procedure call. The return from conn:call is whatever the function returns.
---
--- Limitation: the called function cannot return a function, for example if func2 is defined as function func2 ()
--- return func end then conn:call(func2) will return “error: unsupported Lua type ‘function’”.
function conn:call(function_name, arguments, options) end

---
--- Subscribe to events broadcast by a remote host.
--- @param key string @ a key name of an event to subscribe to
--- @param func function @ a callback to invoke when the key value is updated
--- @return function @ a watcher handle. The handle consists of one method – unregister(), which unregisters the watcher.
function conn:wait_state(states, timeout) end

---
--- timeout(...) is a wrapper which sets a timeout for the request that follows it. Since version 1.7.4 this method is
--- deprecated – it is better to pass a timeout value for a method’s {options} parameter.
function conn:timeout(timeout) end

---
function conn:request(...) end

---
--- Create a stream.
function conn:new_stream(options) end

---
--- @class StreamObject
local stream = {}

---
--- Begin a stream transaction. Instead of the direct method, you can also use the call, eval or execute methods with SQL transaction.
--- @param txn_isolation @ transaction isolation level - [https://www.tarantool.io/en/doc/latest/book/box/atomic/txn_mode_mvcc/#txn-mode-mvcc-options]
function stream:begin(txn_isolation) end

---
--- Commit a stream transaction. Instead of the direct method, you can also use the call, eval or execute methods with SQL transaction.
function stream:commit() end

---
--- Rollback a stream transaction. Instead of the direct method, you can also use the call, eval or execute methods with SQL transaction.
function stream:rollback() end

---
--- Define a trigger for execution when a new connection is established, and authentication and schema fetch are completed
--- due to an event such as net_box.connect. If the trigger execution fails and an exception happens, the connection’s state
--- changes to ‘error’. In this case, the connection is terminated, regardless of the reconnect_after option’s value. Can be
--- called as many times as reconnection happens, if reconnect_after is greater than zero.
--- @param trigger_function function @ function which will become the trigger function. Takes the conn object as the first argument
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return boolean @ true when a target state is reached, false on timeout or connection closure
function conn:on_connect(trigger_function, old_trigger_function) end

---
--- Define a trigger for execution after a connection is closed. If the trigger function causes an error, the error is
--- logged but otherwise is ignored. Execution stops after a connection is explicitly closed, or once the Lua garbage
--- collector removes it.
--- @param trigger_function function @ function which will become the trigger function. Takes the conn object as the first argument
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr @ nil or function pointer
function conn:on_disconnect(trigger_function, old_trigger_function) end

---
--- Define a trigger executed when some operation has been performed on the remote server after schema has been updated.
--- So, if a server request fails due to a schema version mismatch error, schema reload is triggered.
--- @param trigger_function function @ function which will become the trigger function. Takes the conn object as the first argument
--- @param old_trigger_function function @ existing trigger function which will be replaced by trigger-function
--- @return nil|function_ptr @ nil or function pointer
function conn:on_schema_reload(trigger_function, old_trigger_function) end
