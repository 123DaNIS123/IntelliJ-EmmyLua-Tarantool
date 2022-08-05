---
--- The swim module contains Tarantool’s implementation of SWIM – Scalable Weakly-consistent Infection-style
--- Process Group Membership Protocol. It is recommended for any type of Tarantool cluster where the number of
--- nodes can be large. Its job is to discover and monitor the other members in the cluster and keep their
--- information in a “member table”. It works by sending and receiving, in a background event loop, periodically,
--- via UDP, messages.
--- @module swim

---
--- Create a new SWIM instance. A SWIM instance maintains a member table and interacts with other members. Multiple
--- SWIM instances can be created in a single Tarantool process.
--- @param cfg table @ an optional configuration parameter. If cfg is not specified or is nil, then the new SWIM instance is not bound to a socket and has nil attributes, so it cannot interact with other members and only a few methods are valid until swim_object:cfg() is called. If cfg is specified, then the effect is the same as calling s = swim.new() s:cfg(), except for generation. For configuration description see swim_object:cfg().
function new(cfg) end

---
--- @class SwimObject
--- @field cfg @ Expose all non-nil components of the read-only table which was set up or changed by swim_object:cfg().
local swim_object = {}

---
--- Configure or reconfigure a SWIM instance.
---
--- The cfg table may have these components:
---
--- heartbeat_rate (double) – rate of sending round messages, in seconds. Setting heartbeat_rate to X does not mean that every member will be checked every X seconds, instead X is the protocol speed. Protocol period depends on member count and heartbeat_rate. Default = 1.
---
--- ack_timeout (double) – time in seconds after which a ping is considered to be unacknowledged. Default = 30.
---
--- gc_mode (enum) – dead member collection mode.
---
--- If gc_mode == 'off' then SWIM never removes dead members from the member table (though users may remove them with swim_object:remove_member()), and SWIM will continue to ping them as if they were alive.
---
--- If gc_mode == 'on' then SWIM removes dead members from the member table after one round.
---
--- Default = 'on'.
---
--- uri (string or number) – either an 'ip:port' address, or just a port number (if ip is omitted then 127.0.0.1 is assumed). If port == 0, then the kernel will select any free port for the IP address.
---
--- uuid (string or cdata struct tt_uuid) – a value which should be unique among SWIM instances. Users may choose any value but the recommendation is: use box.cfg.instance_uuid, the Tarantool instance’s UUID.
---
--- All the cfg components are dynamic – swim_object:cfg() may be called more than once. If it is not being called for the first time and a component is not specified, then the component retains its previous value. If it is being called for the first time then uri and uuid are mandatory, since a SWIM instance cannot operate without URI and UUID.
---
--- swim_object:cfg() is atomic – if there is an error, then nothing changes.
--- @param cfg table @ the options to describe instance behavior
--- @return boolean|nil|Error @ true if configuration succeeds; nil, err if an error occurred. err is an error object
function swim_object:cfg(cfg) end

---
--- Delete a SWIM instance immediately. Its memory is freed, its member table entry is deleted, and it can no longer be
--- used. Other members will treat this member as ‘dead’.
---
--- After swim_object:delete() any attempt to use the deleted instance will cause an exception to be thrown.
function swim_object:delete() end

---
--- Return false if a SWIM instance was created via swim.new() without an optional cfg argument, and was not configured
--- with swim_object:cfg(). Otherwise return true.
--- @return boolean @ boolean result, true if configured, otherwise false
function swim_object:is_configured() end

---
--- Return the size of the member table. It will be at least 1 because the “self” member is included.
--- @return integer @ integer size
function swim_object:size() end

---
--- Leave the cluster.
---
--- This is a graceful equivalent of swim_object:delete() – the instance is deleted, but before deletion it sends to
--- each member in its member table a message, that this instance has left the cluster, and should not be considered dead.
---
--- Other instances will mark such a member in their tables as ‘left’, and drop it after one round of dissemination.
---
--- Consequences to the caller are the same as after swim_object:delete() – the instance is no longer usable, and an
--- error will be thrown if there is an attempt to use it.
function swim_object:quit() end

---
--- Explicitly add a member into the member table.
---
--- This method is useful when a new member is joining the cluster and does not yet know what members already exist.
--- In that case it can start interaction explicitly by adding the details about an already-existing member into its
--- member table. Subsequently SWIM will discover other members automatically via messages from the already-existing member.
--- @param cfg table @ description of the member
--- @return boolean|Error @ true if member is added; nil, err if an error occurred. err is an error object
function swim_object:add_member(cfg) end

---
--- Explicitly and immediately remove a member from the member table.
--- @param uuid @ (string-or-cdata-struct-tt_uuid) – UUID
--- @return boolean|Error @ true if member is removed; nil, err if an error occurred. err is an error object
function swim_object:remove_member(uuid) end

---
--- Send a ping request to the specified uri address. If another member is listening at that address, it will receive
--- the ping, and respond with an ACK (acknowledgment) message containing information such as UUID. That information will
--- be added to the member table.
---
--- swim_object:probe_member() is similar to swim_object:add_member(), but it does not require UUID, and it is not reliable because it uses UDP.
--- @param uri @ (string-or-number) – URI. Format is the same as for uri in swim_object:cfg().
--- @return boolean|Error @ true if member is pinged; nil, err if an error occurred. err is an error object
function swim_object:probe_member(uri) end

---
--- Broadcast a ping request to all the network interfaces in the system.
---
--- swim_object:broadcast() is like swim_object:probe_member() to many members at once.
--- @param port number @ All the sent ping requests have this port as destination port in their UDP headers. By default a currently bound port is used.
--- @return boolean|Error @ true if broadcast is sent; nil, err if an error occurred. err is an error object
function swim_object:broadcast(port) end

---
--- Set a payload, as formatted data.
---
--- Payload is arbitrary user defined data up to 1200 bytes in size and disseminated over the cluster. So each cluster
--- member will eventually learn what is the payload of other members in the cluster, because it is stored in the member
--- table and can be queried with swim_member_object:payload().
---
--- Different members may have different payloads.
--- @param payload object @ Arbitrary Lua object to disseminate. Set to nil to remove the payload, in which case it will be eventually removed on other instances. The object is serialized in MessagePack.
--- @return boolean|Error @ true if payload is set; nil, err if an error occurred. err is an error object
function swim_object:set_payload(payload) end

---
--- Set a payload, as raw data.
---
--- Sometimes a payload does not need to be a Lua object. For example, a user may already have a well formatted
--- MessagePack object and just wants to set it as a payload. Or cdata needs to be exposed.
---
--- set_payload_raw allows setting a payload as is, without MessagePack serialization.
--- @param payload string|cdata @ any value
--- @param size number @ Payload size in bytes. If payload is string then size is optional, and if specified, then should not be larger than actual payload size. If size is less than actual payload size, then only the first size bytes of payload are used. If payload is cdata then size is mandatory.
--- @return boolean|Error @ true if payload is set; nil, err if an error occurred. err is an error object
function swim_object:set_payload_raw(payload, size) end

---
--- Enable encryption for all following messages.
---
--- For a brief description of encryption algorithms see “enum_crypto_algo” and “enum crypto_mode” in the Tarantool source code file crypto.h.
---
--- When encryption is enabled, all the messages are encrypted with a chosen private key, and a randomly generated and updated public key.
--- @param codec_cfg table @ description of the encryption
function swim_object:set_codec(codec_cfg) end

---
--- Methods swim_object:member_by_uuid(), swim_object:self(), and swim_object:pairs() return swim member objects.
---
--- A swim member object has methods for reading its attributes: status(), uuid, uri(), incarnation(), payload_cdata,
--- payload_str(), payload(), is_dropped().
--- @class SwimMemberObject
local swim_member_object = {}

---
--- Return a swim member object (of self) from the member table, or from a cache containing earlier results of
--- swim_object:self() or swim_object:member_by_uuid() or swim_object:pairs().
--- @return SwimMemberObject @ not nil because self() will not fail
function swim_object:self() end

---
--- Return a swim member object (given UUID) from the member table, or from a cache containing earlier results of
--- swim_object:self() or swim_object:member_by_uuid() or swim_object:pairs().
--- @param uuid @ (string-or-cdata-struct-tt-uuid) – UUID
--- @return SwimMemberObject @ or nil if not found
function swim_object:member_by_uuid(uuid) end

---
--- Set up an iterator for returning swim member objects from the member table, or from a cache containing earlier
--- results of swim_object:self() or swim_object:member_by_uuid() or swim_object:pairs().
---
--- swim_object:pairs() should be in a ‘for’ loop, and there should only be one iterator in operation at one time.
--- (The iterator is implemented in an extra light fashion so only one iterator object is available per SWIM instance.)
--- @param generator_object_key @ as for any Lua pairs() iterators. generator function, iterator object (a swim member object), and initial key (a UUID).
function swim_object:pairs() end

---
--- Return the status, which may be ‘alive’, ‘suspected’, ‘left’, or ‘dead’.
--- @return string @ ‘alive’ | ‘suspected’ | ‘left’ | dead’
function swim_member_object:status() end

---
--- Return the UUID as cdata struct tt_uuid.
--- @return cdata @ cdata-struct-tt-uuid UUID
function swim_member_object:uuid() end

---
--- Return the URI as a string ‘ip:port’. Via this method a user can learn a real assigned port, if port = 0 was specified in swim_object:cfg().
--- @return string @ string ip:port
function swim_member_object:uri() end

---
--- Return a cdata object with the incarnation. The cdata object has two attributes: incarnation().generation and incarnation().version.
---
--- Incarnations can be compared to each other with any comparison operator (==, <, >, <=, >=, ~=).
---
--- Incarnations, when printed, will appear as strings with both generation and version.
--- @return cdata @ cdata incarnation
function swim_member_object:incarnation() end

---
--- Return member’s payload.
--- @return pointer, number @ pointer-to-cdata payload and size in bytes
function swim_member_object:payload_cdata() end

---
--- Since the swim module is a Lua module, a user is likely to use Lua objects as a payload – tables, numbers, strings etc.
--- And it is natural to expect that swim_member_object:payload() should return the same object which was passed into
--- swim_object:set_payload() by another instance. swim_member_object:payload() tries to interpret payload as MessagePack, and if that fails then it returns the payload as a string.
---
--- swim_member_object:payload() caches its result. Therefore only the first call actually decodes cdata payload.
--- All following calls return a pointer to the same result, unless payload is changed with a new incarnation.
--- If payload was not specified (its size is 0), then nil is returned.
--- @return pointer, number @ pointer-to-cdata payload and size in bytes
function swim_member_object:payload() end

---
--- Returns true if this member object is a stray reference to a member which has already been dropped from the member table.
--- @return boolean @ boolean true if member is dropped, otherwise false
function swim_member_object:is_dropped() end

---
--- Create an “on_member trigger”. The trigger-function will be executed when a member in the member table is updated.
--- @param trigger_function function @ this will become the trigger function
--- @param ctx table @ (optional) this will be passed to trigger-function
--- @return nil|function_ptr @ boolean true if member is dropped, otherwise false
function swim_member_object:on_member_event(trigger_function, ctx) end

---
--- Delete an on-member trigger.
---
--- The old-trigger value should be the value returned by on_member_event(trigger-function[, ctx]).
--- @param n nil @ nil
--- @param old_trigger function @ old-trigger
function swim_member_object:on_member_event(n, old_trigger) end

---
--- This is a variation of on_member_event(new-trigger, [, ctx]).
---
--- The additional parameter is old-trigger. Instead of adding the new-trigger at the end of a list of triggers, this function will replace the entry in the list of triggers that matches old-trigger. The position within a list may be important because triggers are activated sequentially starting with the first trigger in the list.
---
--- The old-trigger value should be the value returned by on_member_event(trigger-function[, ctx]).
function swim_member_object:on_member_event(new_trigger, old_trigger, ctx) end

---
--- Return the list of on-member triggers.
function swim_member_object:on_member_event() end
