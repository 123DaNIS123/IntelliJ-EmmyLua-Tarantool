---
--- The http module, specifically the http.client submodule, provides the functionality of an HTTP client with support
--- for HTTPS and keepalive. It uses routines in the libcurl library.
--- @module http

---
--- Construct a new HTTP client instance.
---
--- @param options table @ integer settings which are passed to libcurl.
---
--- The two possible options are max_connections and max_total_connections.
---
--- max_connections is the maximum number of entries in the cache. It affects libcurl CURLMOPT_MAXCONNECTS. The default is -1.
---
--- max_total_connections is the maximum number of active connections. It affects libcurl CURLMOPT_MAX_TOTAL_CONNECTIONS.
--- It is ignored if the curl version is less than 7.30. The default is 0, which allows libcurl to scale accordingly to
--- easily handles count.
---
--- The default option values are usually good enough but in rare cases it might be good to set them. In that case here are two tips.
---
--- You may want to control the maximum number of sockets that a particular HTTP client uses simultaneously. If a system
--- passes many requests to distinct hosts, then libcurl cannot reuse sockets. In this case setting max_total_connections
--- may be useful, since it causes curl to avoid creating too many sockets which would not be used anyway.
--- Do not set max_connections less than max_total_connections unless you are confident about your actions.
--- When max_connections is less then max_total_connections, in some cases libcurl will not reuse sockets for requests
--- that are going to the same host. If the limit is reached and a new request occurs, then libcurl will first create a
--- new socket, send the request, wait for the first connection to be free, and close it, in order to avoid exceeding
--- the max_connections cache size. In the worst case, libcurl will create a new socket for every request, even if all
--- requests are going to the same host. See this Tarantool issue on github for details.
function client.new(options) end

---
local clientObject = {}

---
--- If http_client is an HTTP client instance, http_client:request() will perform an HTTP request and, if there
--- is a successful connection, will return a table with connection information.
--- @param method string @ HTTP method, for example ‘GET’ or ‘POST’ or ‘PUT’
--- @param url string @ location, for example ‘https://tarantool.org/doc’
--- @param body string @ optional initial message, for example ‘My text string!’
--- @param opts table @ table of connection options, with any of these components: ca_file; ca_path - (link: [https://www.tarantool.io/en/doc/latest/reference/reference_lua/http/#client-object-stat])
--- @return table @ connection information, with all of these components: * status - HTTP response status; *reason - HTTP response status text; * headers - a Lua table with normalized HTTP headers; * body - response body; * proto - protocol version
function clientObject:request() end
