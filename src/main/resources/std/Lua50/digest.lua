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

return digest;
