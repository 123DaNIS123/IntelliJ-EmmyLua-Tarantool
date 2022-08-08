---@module fiber
local fiber = {}

--- @class FiberObject
local fiberObject = {}

--- @class FiberMemoryInfo
--- @field total number
--- @field used number
local fiberMemoryInfo = {}

--- @class FiberInfo
--- @field csw number
--- @field backtrace table
--- @field fid number
--- @field memory FiberMemoryInfo
--- @field name string
local fiberinfo = {}

--- @param func fun
--- @param ... any @argument list
--- @return FiberObject
function fiber.create(func, ...) end

--- @return FiberObject
function fiber.self() end

--- @param id number
--- @return FiberObject
function fiber.fund(id) end

--- @param time number
function fiber.sleep(time) end

function fiber.yield() end

--- @return string
function fiber.status() end

--- @return FiberInfo @array of FiberInfo objects
function fiber.info() end

--- @param id number
function fiber.kill(id) end

function fiber.testcancel() end

--- @return number
function fiberObject:id() end

--- @return string
function fiberObject:name() end

--- @param newName string
function fiberObject:name(newName) end

--- @return string
function fiberObject:status() end

function fiberObject:cancel() end

--- Special Fiber-bound storage. Removed after fiber cancellation or ending
--- @type table
fiberObject.storage = {}

--- Returns current event loop's Epoch time in Lua number (seconds.millis)
--- @return number
function fiber.time() end

--- @return number
function fiber.time64() end

--- @class FiberChannel
local fiberChannel = {}

--- Creates a new synchronous (fiber-yielding I guess) communication channel
--- @param capacity number
--- @return FiberChannel
function fiber.channel(capacity) end

--- @param message any
--- @param timeout number
--- @return boolean
function fiberChannel:put(message, timeout) end

function fiberChannel:close() end

--- @param timeout number
--- @return any
function fiberChannel:get(timeout) end

--- @return boolean
function fiberChannel:is_empty() end

--- @return number
function fiberChannel:count() end

--- @return boolean
function fiberChannel:is_full() end

--- The channel has someone, who's called 'get' and yielded cause the channel is empty
--- @return boolean
function fiberChannel:has_readers() end

--- The channel has someone, who's called 'put' and yielded cause the channel is full
--- @return boolean
function fiberChannel:has_writers() end

--- @return boolean
function fiberChannel:is_full() end

--- @class FiberCondition
local fiberCondition = {}

--- @return FiberCondition
function fiber.cond() end

--- Wait for signals or broadcasts
--- @param timeout number
--- @return boolean @TRUE if signal was received in a specified timeout, otherwise FALSE
function fiberCondition:wait(timeout) end

--- Wake someone
function fiberCondition:signal() end

--- Wake everyone
function fiberCondition:broadcast() end

return fiber;
