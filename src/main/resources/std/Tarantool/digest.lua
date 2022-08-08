--- @module digest
--- @field aes256cbc DAES
local digest = {}

--- @class DAES
local aes = {}

--- @param message string
--- @param key string
--- @param iv string
--- @return string
function aes.encrypt(message, key, iv) end
--- @param message string
--- @param key string
--- @param iv string
--- @return string
function aes.decrypt(message, key, iv) end

--- @param message string
--- @return string
function digest.md4(message) end
--- @param message string
--- @return string
function digest.md4_hex(message) end

--- @param message string
--- @return string
function digest.md5(message) end
--- @param message string
--- @return string
function digest.md5_hex(message) end

--- @param message string
--- @return string
function digest.pbkdf2(message) end
--- @param message string
--- @return string
function digest.pbkdf2_hex(message) end

--- @param message string
--- @return string
function digest.sha(message) end
--- @param message string
--- @return string
function digest.sha_hex(message) end

--- @param message string
--- @return string
function digest.sha1(message) end
--- @param message string
--- @return string
function digest.sha1_hex(message) end

--- @param message string
--- @return string
function digest.sha224(message) end
--- @param message string
--- @return string
function digest.sha224_hex(message) end

--- @param message string
--- @return string
function digest.sha256(message) end
--- @param message string
--- @return string
function digest.sha256_hex(message) end

--- @param message string
--- @return string
function digest.sha512(message) end
--- @param message string
--- @return string
function digest.sha512_hex(message) end

--- @param message string
--- @return string
function digest.sha384(message) end
--- @param message string
--- @return string
function digest.sha384_hex(message) end

--- @class Base64Options
--- @field nopad boolean
--- @field nowrap boolean
--- @field urlsafe boolean
local bopts = {}

--- @param message string
--- @return string
function digest.base64_encode(message) end

--- @param message string
--- @param options Base64Options
--- @return string
function digest.base64_encode(message, options) end

--- @param message string
--- @return string
function digest.base64_decode(message) end

--- @param size number
--- @return string
function digest.urandom(size) end

--

---
--- Returns 32-bit checksum made with CRC32.
---
--- The crc32 and crc32_update functions use the Cyclic Redundancy Check polynomial value: 0x1EDC6F41 / 4812730177.
--- (Other settings are: input = reflected, output = reflected, initial value = 0xFFFFFFFF, final xor value = 0x0.)
--- If it is necessary to be compatible with other checksum functions in other programming languages, ensure that the
--- other functions use the same polynomial value.
--- @param string
--- @return string
function digest.crc32(string) end

---
--- Initiates incremental crc32. See incremental methods notes.
function digest.crc32.new() end

---
--- Returns a number made with consistent hash.
---
--- The guava function uses the Consistent Hashing algorithm of the Google guava library. The first parameter should
--- be a hash code; the second parameter should be the number of buckets; the returned value will be an integer between
--- 0 and the number of buckets. For example,
--- @param state
--- @param bucket
--- @return string
function digest.guava(state, bucket) end


---
--- Returns 32-bit binary string = digest made with MurmurHash.
--- @param string
--- @return string
function digest.murmur(string) end

---
--- Initiates incremental MurmurHash. See incremental methods notes. For example:
--- @param opts
--- @return string
function murmur.new(opts) end


return digest;

