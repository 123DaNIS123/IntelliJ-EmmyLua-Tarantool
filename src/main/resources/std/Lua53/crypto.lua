--- @module crypto
local crypto = {}

--- @class CipherStorage
--- @field aes128 Cipher
--- @field aes192 Cipher
--- @field aes256 Cipher
--- @field des Cipher
local cipher = {}

crypto.cipher = cipher;

--- @class Cipher
--- @field cbc CipherInterface
--- @field cfb CipherInterface
--- @field ecb CipherInterface
--- @field ofb CipherInterface
local cipherAlgo = {}

--- @class CipherInterface
local cipherInterface = {}

--- @param message string
--- @param key string
--- @param vector string
--- @return string
function cipherInterface.encrypt(message, key, vector) end

--- @param message string
--- @param key string
--- @param vector string
--- @return string
function cipherInterface.decrypt(message, key, vector) end

--- @return CipherInterface
function cipherInterface.new() end

function cipherInterface:init() end
--- @param messagePart string
function cipherInterface:update(messagePart) end
--- @return string
function cipherInterface:result() end

--- @class Digest
--- @field dss DigestInterface
--- @field dss1 DigestInterface
--- @field md4 DigestInterface
--- @field md5 DigestInterface
--- @field mdc2 DigestInterface
--- @field ripemd160 DigestInterface
--- @field sha DigestInterface
--- @field sha1 DigestInterface
--- @field sha224 DigestInterface
--- @field sha256 DigestInterface
--- @field sha384 DigestInterface
--- @field sha512 DigestInterface
local digestAlgo = {}

crypto.digest = digestAlgo;

--- @class DigestInterface
local digestInterface = {}

--- @return DigestInterface
function digestInterface.new() end

--- @param message string
--- @return string
function digestAlgo.dss(message) end
--- @param message string
--- @return string
function digestAlgo.dss1(message) end
--- @param message string
--- @return string
function digestAlgo.md4(message) end
--- @param message string
--- @return string
function digestAlgo.md5(message) end
--- @param message string
--- @return string
function digestAlgo.mdc2(message) end
--- @param message string
--- @return string
function digestAlgo.ripemd160(message) end
--- @param message string
--- @return string
function digestAlgo.sha(message) end
--- @param message string
--- @return string
function digestAlgo.sha1(message) end
--- @param message string
--- @return string
function digestAlgo.sha224(message) end
--- @param message string
--- @return string
function digestAlgo.sha256(message) end
--- @param message string
--- @return string
function digestAlgo.sha512(message) end

function digestInterface:init() end
--- @param messagePart string
function digestInterface:update(messagePart) end

--- @return string
function digestInterface:result() end

---
function digestInterface:free() end

--- @class Hmac
--- @field md4 DigestInterface
--- @field md5 DigestInterface
--- @field ripemd160 DigestInterface
--- @field sha1 DigestInterface
--- @field sha224 DigestInterface
--- @field sha256 DigestInterface
--- @field sha384 DigestInterface
--- @field sha512 DigestInterface
local hmacAlgo = {}

crypto.hmac = hmacAlgo;

--return crypto;
