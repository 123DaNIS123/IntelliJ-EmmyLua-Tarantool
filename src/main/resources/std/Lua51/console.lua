---
--- The console module allows one Tarantool instance to access another Tarantool instance, and allows one Tarantool
--- instance to start listening on an admin port.
--- @module console

---
--- Connect to the instance at URI [https://www.tarantool.io/en/doc/latest/reference/configuration/#index-uri], change the prompt from ‘tarantool>’ to ‘uri>’, and act henceforth as a client until
--- the user ends the session or types control-D.
---
--- The console.connect function allows one Tarantool instance, in interactive mode, to access another Tarantool instance.
--- Subsequent requests will appear to be handled locally, but in reality the requests are being sent to the remote instance
--- and the local instance is acting as a client. Once connection is successful, the prompt will change and subsequent requests
--- are sent to, and executed on, the remote instance. Results are displayed on the local instance. To return to local mode, enter control-D.
---
--- If the Tarantool instance at uri requires authentication, the connection might look something like:
--- console.connect('admin:secretpassword@distanthost.com:3301').
---
--- There are no restrictions on the types of requests that can be entered, except those which are due to privilege
--- restrictions – by default the login to the remote instance is done with user name = ‘guest’. The remote instance
--- could allow for this by granting at least one privilege: box.schema.user.grant('guest','execute','universe').
--- @param uri string @ the URI of the remote instance
--- @return nil
function connect(uri) end

---
--- Listen on URI. The primary way of listening for incoming requests is via the connection-information string,
--- or URI, specified in box.cfg{listen=...}. The alternative way of listening is via the URI specified in
--- console.listen(...). This alternative way is called “administrative” or simply “admin port”. The listening is
--- usually over a local host with a Unix domain socket.
---
--- The “admin” address is the URI to listen on. It has no default value, so it must be specified if connections will
--- occur via an admin port. The parameter is expressed with URI = Universal Resource Identifier format, for example
--- “/tmpdir/unix_domain_socket.sock”, or a numeric TCP port. Connections are often made with telnet. A typical port value is 3313.
--- @param uri string @ the URI of the local instance
--- @return nil
function listen(uri) end

---
--- Start the console on the current interactive terminal.
function start() end

---
--- Set the auto-completion flag. If auto-completion is true, and the user is using Tarantool as a client or the
--- user is using Tarantool via console.connect(), then hitting the TAB key may cause tarantool to complete a word
--- automatically. The default auto-completion value is true.
--- @param boolean boolean @ true|false
function ac(boolean) end

---
--- Set a custom end-of-request marker for Tarantool console.
---
--- The default end-of-request marker is a newline (line feed). Custom markers are not necessary because Tarantool
---can tell when a multi-line request has not ended (for example, if it sees that a function declaration does not
---have an end keyword). Nonetheless for special needs, or for entering multi-line requests in older Tarantool
---versions, you can change the end-of-request marker. As a result, newline alone is not treated as end of request.
---
--- To go back to normal mode, say: console.delimiter('')<marker>
--- @param marker string @ a custom end-of-request marker for Tarantool console
function delimiter(marker) end

---
--- Return the current default output format. The result will be fmt="yaml", or it will be fmt="lua" if the
--- last set_default_output call was console.set_default_output('lua').
function get_default_output() end

---
--- Set the default output format. The possible values are ‘yaml’ (the default default) or ‘lua’. The output format
--- can be changed within a session by executing console.eval('\set output yaml|lua'); see the description of output
--- format in the Interactive console section.
function set_default_output(yaml_or_lua) end

---
--- Set or access the end-of-output string if default output is ‘lua’. This is the string that appears at the end of
--- output in a response to any Lua request. The default value is ; semicolon. Saying eos() will return the current
--- value. For example, after require('console').eos('!!') responses will end with ‘!!’.
--- @param string
function eos(string) end
