
--- @module log
local log = {}

--- @param message string
function log.error(message) end

--- @param message string
function log.warn(message) end

--- @param message string
function log.verbose(message) end

--- @param message string
function log.debug(message) end

--- @param message string
function log.info(message) end

--- @return number
function log.logger_pid() end

function log.rotate() end

return log;

