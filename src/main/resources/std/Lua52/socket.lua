---
--- Create a new TCP or UDP socket. The argument values are the same as in the Linux socket(2) man page.
--- @return userdata @ an unconnected socket, or nil.
function socket() end

---
--- The socket module allows exchanging data via BSD sockets with a local or remote host in connection-oriented (TCP)
--- or datagram-oriented (UDP) mode. Semantics of the calls in the socket API closely follow semantics of the corresponding POSIX calls.
---
--- The functions for setting up and connecting are socket, sysconnect, tcp_connect. The functions for sending data are
--- send, sendto, write, syswrite. The functions for receiving data are recv, recvfrom, read. The functions for waiting
--- before sending/receiving data are wait, readable, writable. The functions for setting flags are nonblock, setsockopt.
--- The functions for stopping and disconnecting are shutdown, close. The functions for error checking are errno, error.
--- @module socket

---
--- Create a new TCP or UDP socket. The argument values are the same as in the Linux socket(2) man page.
--- @return userdata @ an unconnected socket, or nil.
function __call(domain, type, protocol) end

---
--- Connect a socket to a remote host.
---
--- Return:
---
--- (if error) {nil, error-message-string}. (if no error) a new socket object.
---
--- Return type:
---
--- socket object, which may be viewed as a table
--- @param host string @ URL or IP address
--- @param port number @ port number
--- @param timeout number @ number of seconds to wait
function tcp_connect(host, port, timeout) end

---
--- The socket.getaddrinfo() function is useful for finding information about a remote site so that the correct arguments
--- for sock:sysconnect() can be passed. This function may use the worker_pool_threads configuration parameter.
--- @param host string @ URL or IP address
--- @param port number|string @ port number as a numeric or string
--- @param timeout number @ maximum number of seconds to wait
--- @param options table @ * type – preferred socket type | * family – desired address family for the returned addresses | * protocol | * flags – additional options (see details here)
--- @return table @ (if error) {nil, error-message-string}. (if no error) A table containing these fields: “host”, “family”, “type”, “protocol”, “port”.
function getaddrinfo(host, port, timeout, option_list) end

---
--- The socket.tcp_server() function makes Tarantool act as a server that can accept connections. Usually the same
--- objective is accomplished with box.cfg{listen=…}.
--- @param host string @ host name or IP
--- @param port number @ host port, may be 0
--- @param handler_function_or_table function|table @ what to execute when a connection occurs
--- @param timeout number @ host resolving timeout in seconds
--- @return table @ Return: (if error) {nil, error-message-string}. (if no error) a new socket object. Return type: socket object, which may be viewed as a table
function tcp_server(host, port, handler_function_or_table, timeout) end

---
--- Bind a socket to the given host/port. This is equivalent to socket_object:bind(), but is done on the result of require('socket'), rather than on the socket object.
--- @param host string @ URL or IP address
--- @param port number @ port number
--- @return table @ (if error) {nil, error-message-string}. (if no error) A table which may have information about the bind result.
function bind(host, port)  end

---
--- @class socket_objectClass
local socket_object = {}

---
--- Connect an existing socket to a remote host. The argument values are the same as in tcp_connect(). The host must be an IP address.
--- Parameters:
---
--- Either:
---
--- host - a string representation of an IPv4 address or an IPv6 address;
---
--- port - a number.
---
--- Or:
---
--- host - a string containing “unix/”;
---
--- port - a string containing a path to a unix socket.
---
--- Or:
---
--- host - a number, 0 (zero), meaning “all local interfaces”;
---
--- port - a number. If a port number is 0 (zero), the socket will be bound to a random local port.
--- @return boolean @ the socket object value may change if sysconnect() succeeds.
function socket_object:sysconnect(host, port) end

---
--- Send data over a connected socket.
--- @param data string @ what is to be sent
--- @return number @ the number of bytes sent.
function socket_object:send(data) end

---
--- Send data over a connected socket.
--- @param data string @ what is to be sent
--- @return number @ the number of bytes sent.
function socket_object:write(data) end

---
--- Write as much data as possible to the socket buffer if non-blocking. Rarely used. For details see this description.
function socket_object:syswrite(size) end

---
--- Read size bytes from a connected socket. An internal read-ahead buffer is used to reduce the cost of this call.
--- @param size integer @ maximum number of bytes to receive. See Recommended size.
--- @return string @ a string of the requested length on success.
function socket_object:recv(size) end

---
--- Read from a connected socket until some condition is true, and return the bytes that were read. Reading goes
--- on until limit bytes have been read, or a delimiter has been read, or a timeout has expired. Unlike
--- socket_object:recv (which uses an internal read-ahead buffer), socket_object:read depends on the socket’s buffer.
--- @param limit integer @ maximum number of bytes to read, for example 50 means “stop after 50 bytes”
--- @param delimiter string @ separator for example ‘?’ means “stop after a question mark”
--- @param timeout number @ maximum number of seconds to wait, for example 50 means “stop after 50 seconds”.
--- @param options table @ chunk=limit and/or delimiter=delimiter, for example {chunk=5,delimiter='x'}.
--- @return string @ an empty string if there is nothing more to read, or a nil value if error, or a string up to limit bytes long, which may include the bytes that matched the delimiter expression.
function socket_object:read(limit, timeout) end

---
--- Read from a connected socket until some condition is true, and return the bytes that were read. Reading goes
--- on until limit bytes have been read, or a delimiter has been read, or a timeout has expired. Unlike
--- socket_object:recv (which uses an internal read-ahead buffer), socket_object:read depends on the socket’s buffer.
--- @param limit integer @ maximum number of bytes to read, for example 50 means “stop after 50 bytes”
--- @param delimiter string @ separator for example ‘?’ means “stop after a question mark”
--- @param timeout number @ maximum number of seconds to wait, for example 50 means “stop after 50 seconds”.
--- @param options table @ chunk=limit and/or delimiter=delimiter, for example {chunk=5,delimiter='x'}.
--- @return string @ an empty string if there is nothing more to read, or a nil value if error, or a string up to limit bytes long, which may include the bytes that matched the delimiter expression.
function socket_object:read(delimiter, timeout) end

---
--- Read from a connected socket until some condition is true, and return the bytes that were read. Reading goes
--- on until limit bytes have been read, or a delimiter has been read, or a timeout has expired. Unlike
--- socket_object:recv (which uses an internal read-ahead buffer), socket_object:read depends on the socket’s buffer.
--- @param limit integer @ maximum number of bytes to read, for example 50 means “stop after 50 bytes”
--- @param delimiter string @ separator for example ‘?’ means “stop after a question mark”
--- @param timeout number @ maximum number of seconds to wait, for example 50 means “stop after 50 seconds”.
--- @param options table @ chunk=limit and/or delimiter=delimiter, for example {chunk=5,delimiter='x'}.
--- @return string @ an empty string if there is nothing more to read, or a nil value if error, or a string up to limit bytes long, which may include the bytes that matched the delimiter expression.
function socket_object:read(options, timeout) end

---
--- Return data from the socket buffer if non-blocking. In case the socket is blocking, sysread() can block the calling
--- process. Rarely used. For details, see also this description.
--- @param size integer @ maximum number of bytes to read, for example 50 means “stop after 50 bytes”
--- @return string @ an empty string if there is nothing more to read, or a nil value if error, or a string up to size bytes long.
function socket_object:sysread(size) end

---
--- Bind a socket to the given host/port. A UDP socket after binding can be used to receive data (see socket_object.recvfrom).
--- A TCP socket can be used to accept new connections, after it has been put in listen mode.
--- @param host string @ URL or IP address
--- @param port number @ port number
--- @return boolean @ true for success, false for error. If return is false, use socket_object:errno() or socket_object:error() to see details.
function socket_object:bind(host, port) end

---
--- Start listening for incoming connections.
--- @param backlog @ on Linux the listen backlog backlog may be from /proc/sys/net/core/somaxconn, on BSD the backlog may be SOMAXCONN.
--- @return boolean @ true for success, false for error.
function socket_object:listen(backlog) end

---
--- Accept a new client connection and create a new connected socket. It is good practice to set the socket’s blocking
--- mode explicitly after accepting.
--- @return userdata @ new socket if success.
function socket_object:accept() end

---
--- Send a message on a UDP socket to a specified host.
--- @param host string @ URL or IP address
--- @param port number @ port number
--- @param data string @ what is to be sent
--- @return number @ the number of bytes sent.
function socket_object:sendto(host, port, data) end

---
--- Receive a message on a UDP socket.
--- @param size integer @ maximum number of bytes to receive. See Recommended size.
--- @return string, table @ message, a table containing “host”, “family” and “port” fields.
function socket_object:recvfrom() end

---
--- Shutdown a reading end, a writing end, or both ends of a socket.
--- @param how @ socket.SHUT_RD, socket.SHUT_WR, or socket.SHUT_RDWR.
--- @return boolean @ true or false.
function socket_object:shutdown(how) end

---
--- Close (destroy) a socket. A closed socket should not be used any more. A socket is closed automatically when the
--- Lua garbage collector removes its user data.
--- @return boolean @ true on success, false on error. For example, if sock is already closed, sock:close() returns false.
function socket_object:close() end

---
--- Retrieve information about the last error that occurred on a socket, if any. Errors do not cause throwing of
--- exceptions so these functions are usually necessary.
--- @return number, string @ result for sock:errno(), result for sock:error(). If there is no error, then sock:errno() will return 0 and sock:error().
function socket_object:error() end

---
--- Retrieve information about the last error that occurred on a socket, if any. Errors do not cause throwing of
--- exceptions so these functions are usually necessary.
--- @return number, string @ result for sock:errno(), result for sock:error(). If there is no error, then sock:errno() will return 0 and sock:error().
function socket_object:errorno() end

---
--- Set socket flags. The argument values are the same as in the Linux getsockopt(2) man page. The ones that Tarantool accepts are:
---
---SO_ACCEPTCONN
---
---SO_BINDTODEVICE
---
---SO_BROADCAST
---
---SO_DEBUG
---
---SO_DOMAIN
---
---SO_ERROR
---
---SO_DONTROUTE
---
---SO_KEEPALIVE
---
---SO_MARK
---
---SO_OOBINLINE
---
---SO_PASSCRED
---
---SO_PEERCRED
---
---SO_PRIORITY
---
---SO_PROTOCOL
---
---SO_RCVBUF
---
---SO_RCVBUFFORCE
---
---SO_RCVLOWAT
---
---SO_SNDLOWAT
---
---SO_RCVTIMEO
---
---SO_SNDTIMEO
---
---SO_REUSEADDR
---
---SO_SNDBUF
---
---SO_SNDBUFFORCE
---
---SO_TIMESTAMP
---
---SO_TYPE
---
---Setting SO_LINGER is done with sock:linger(active).
function socket_object:setsockopt(level, name, value) end

---
--- Get socket flags. For a list of possible flags see sock:setsockopt().
function socket_object:getsockopt(level, name) end

---
--- Set or clear the SO_LINGER flag. For a description of the flag, see the Linux man page.
---
--- Return:
---
--- new active and timeout values.
--- @param active boolean
function socket_object:linger(active) end

---
--- sock:nonblock() returns the current flag value.
---
--- sock:nonblock(false) sets the flag to false and returns false.
---
--- sock:nonblock(true) sets the flag to true and returns true.
---
--- This function may be useful before invoking a function which might otherwise block indefinitely.
function socket_object:nonblock(flag) end

---
--- Wait until something is readable, or until a timeout value expires.
--- @return boolean @ true if the socket is now writable, false if timeout expired;
function socket_object:readable(timeout) end

---
--- Wait until something is writable, or until a timeout value expires.
--- @return boolean @ true if the socket is now writable, false if timeout expired;
function socket_object:writable(timeout) end

---
--- Wait until something is either readable or writable, or until a timeout value expires.
---
--- Return:
---
--- ‘R’ if the socket is now readable, ‘W’ if the socket is now writable, ‘RW’ if the socket is now both readable and
--- writable, ‘’ (empty string) if timeout expired;
function socket_object:wait(timeout) end

---
--- The sock:name() function is used to get information about the near side of the connection. If a socket was bound
--- to xyz.com:45, then sock:name will return information about [host:xyz.com, port:45]. The equivalent POSIX function is getsockname().
--- @return table @ A table containing these fields: “host”, “family”, “type”, “protocol”, “port”.
function socket_object:name() end

---
--- The sock:peer() function is used to get information about the far side of a connection. If a TCP connection has been
--- made to a distant host tarantool.org:80, sock:peer() will return information about [host:tarantool.org, port:80].
--- The equivalent POSIX function is getpeername().
--- @return table @ A table containing these fields: “host”, “family”, “type”, “protocol”, “port”.
function socket_object:peer() end

---
--- The socket.iowait() function is used to wait until read-or-write activity occurs for a file descriptor.
---
--- If the fd parameter is nil, then there will be a sleep until the timeout. If the timeout parameter is nil or unspecified, then timeout is infinite.
---
--- Ordinarily the return value is the activity that occurred (‘R’ or ‘W’ or ‘RW’ or 1 or 2 or 3). If the timeout period goes by without any reading or writing, the return is an error = ETIMEDOUT.
---
--- Example: socket.iowait(sock:fd(), 'r', 1.11)
--- @param fd @ file descriptor
--- @param read_or_write_flags @ ‘R’ or 1 = read, ‘W’ or 2 = write, ‘RW’ or 3 = read|write.
--- @param timeout @ number of seconds to wait
function iowait(fd, read_or_write_flags, timeout) end
