--- @module clock
local clock = {}

--- @return number
function clock.time() end

--- @return number
function clock.time64() end

--- @return number
function clock.realtime() end

--- @return number
function clock.realtime64() end

--- @return number
function clock.monotonic() end

--- @return number
function clock.monotonic64() end

--- @return number
function clock.proc() end

--- @return number
function clock.proc64() end

--- @return number
function clock.thread() end

--- @return number
function clock.thread64() end

--- @param func fun(...):void
--- @param ... any
--- @return number @proctime taken to evaluate this function
function clock.bench(func, ...) end

return clock;
