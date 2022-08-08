---
--- The buffer module returns a dynamically resizable buffer which is solely for optional use by methods of the
--- net.box module or the msgpack module.
---
--- Ordinarily the net.box methods return a Lua table. If a buffer option is used, then the net.box methods return a raw MsgPack
--- string. This saves time on the server, if the client application has its own routine for decoding raw MsgPack strings.
---
--- The buffer uses four pointers to manage its capacity:
---
--- buf – a pointer to the beginning of the buffer
--- rpos – a pointer to the beginning of the range; available for reading data (“read position”)
--- wpos – a pointer to the end of the range; available for reading data, and to the beginning of the range for writing new data (“write position”)
--- epos – a pointer to the end of the range; available for writing new data (“end position”)
--- @module buffer

---
--- Create a new buffer.
function ibuf() end

---
--- @class Buffer
local bufferObject = {}

---
--- @class wpos

---
--- Allocate size bytes for buffer_object.
--- @field size number @ memory in bytes to allocate
--- @return wpos
function bufferObject:alloc(size) end

---
--- @class epos_buf

---
--- Return the capacity of the buffer_object.
--- @return epos_buf
function bufferObject:capacity() end

---
--- @class rpos

---
--- Check if size bytes are available for reading in buffer_object.
--- @field size number @memory in bytes to check
--- @return rpos
function bufferObject:checksize(size) end

---
--- @class rpos_buf

---
--- Return the size of the range occupied by data.
--- @return rpos_buf
function bufferObject:pos() end

---
--- Read size bytes from buffer.
--- @param size number
function bufferObject:read(size) end

---
--- Clear the memory slots allocated by buffer_object.
function bufferObject:recycle() end

---
--- Clear the memory slots used by buffer_object. This method allows to keep the buffer but remove data from it.
--- It is useful when you want to use the buffer further.
function bufferObject:reset() end

---
--- Reserve memory for buffer_object. Check if there is enough memory to write size bytes after wpos.
--- If not, epos shifts until size bytes will be available.
--- @param size number
function bufferObject:reserve(size) end

---
--- @class wpos_rpos

---
--- Return a range, available for reading data.
--- @return wpos_rpos
function bufferObject:size() end

---
--- @class epos_wpos

---
--- Return a range for writing data.
--- @return epos_wpos
function bufferObject:size() end
