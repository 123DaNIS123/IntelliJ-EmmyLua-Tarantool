
--- @module log
local log = {}

---
--- Output a user-generated message to the log file, given log_level_function_name = error or warn or info or verbose or debug.
---
--- As explained in the description of the configuration setting for log_level, there are seven levels of detail:
---
--- 1 – SYSERROR
---
--- 2 – ERROR – this corresponds to log.error(...)
---
--- 3 – CRITICAL
---
--- 4 – WARNING – this corresponds to log.warn(...)
---
--- 5 – INFO – this corresponds to log.info(...)
---
--- 6 – VERBOSE – this corresponds to log.verbose(...)
---
--- 7 – DEBUG – this corresponds to log.debug(...)
---
--- For example, if box.cfg.log_level is currently 5 (the default value), then log.error(...), log.warn(...) and
--- log.info(...) messages will go to the log file. However, log.verbose(...) and log.debug(...) messages will not go
--- to the log file, because they correspond to higher levels of detail.
--- @param message any @ Usually a string. Messages may contain C-style format specifiers %d or %s, so log.error('...%d...%s', x, y) will work if x is a number and y is a string. Less commonly, messages may be other scalar data types, or even tables. So log.error({'x',18.7,true}) will work.
--- @return nil
function log.error(message) end

---
--- Output a user-generated message to the log file, given log_level_function_name = error or warn or info or verbose or debug.
---
--- As explained in the description of the configuration setting for log_level, there are seven levels of detail:
---
--- 1 – SYSERROR
---
--- 2 – ERROR – this corresponds to log.error(...)
---
--- 3 – CRITICAL
---
--- 4 – WARNING – this corresponds to log.warn(...)
---
--- 5 – INFO – this corresponds to log.info(...)
---
--- 6 – VERBOSE – this corresponds to log.verbose(...)
---
--- 7 – DEBUG – this corresponds to log.debug(...)
---
--- For example, if box.cfg.log_level is currently 5 (the default value), then log.error(...), log.warn(...) and
--- log.info(...) messages will go to the log file. However, log.verbose(...) and log.debug(...) messages will not go
--- to the log file, because they correspond to higher levels of detail.
--- @param message any @ Usually a string. Messages may contain C-style format specifiers %d or %s, so log.error('...%d...%s', x, y) will work if x is a number and y is a string. Less commonly, messages may be other scalar data types, or even tables. So log.error({'x',18.7,true}) will work.
--- @return nil
function log.warn(message) end

---
--- Output a user-generated message to the log file, given log_level_function_name = error or warn or info or verbose or debug.
---
--- As explained in the description of the configuration setting for log_level, there are seven levels of detail:
---
--- 1 – SYSERROR
---
--- 2 – ERROR – this corresponds to log.error(...)
---
--- 3 – CRITICAL
---
--- 4 – WARNING – this corresponds to log.warn(...)
---
--- 5 – INFO – this corresponds to log.info(...)
---
--- 6 – VERBOSE – this corresponds to log.verbose(...)
---
--- 7 – DEBUG – this corresponds to log.debug(...)
---
--- For example, if box.cfg.log_level is currently 5 (the default value), then log.error(...), log.warn(...) and
--- log.info(...) messages will go to the log file. However, log.verbose(...) and log.debug(...) messages will not go
--- to the log file, because they correspond to higher levels of detail.
--- @param message any @ Usually a string. Messages may contain C-style format specifiers %d or %s, so log.error('...%d...%s', x, y) will work if x is a number and y is a string. Less commonly, messages may be other scalar data types, or even tables. So log.error({'x',18.7,true}) will work.
--- @return nil
function log.verbose(message) end

---
--- Output a user-generated message to the log file, given log_level_function_name = error or warn or info or verbose or debug.
---
--- As explained in the description of the configuration setting for log_level, there are seven levels of detail:
---
--- 1 – SYSERROR
---
--- 2 – ERROR – this corresponds to log.error(...)
---
--- 3 – CRITICAL
---
--- 4 – WARNING – this corresponds to log.warn(...)
---
--- 5 – INFO – this corresponds to log.info(...)
---
--- 6 – VERBOSE – this corresponds to log.verbose(...)
---
--- 7 – DEBUG – this corresponds to log.debug(...)
---
--- For example, if box.cfg.log_level is currently 5 (the default value), then log.error(...), log.warn(...) and
--- log.info(...) messages will go to the log file. However, log.verbose(...) and log.debug(...) messages will not go
--- to the log file, because they correspond to higher levels of detail.
--- @param message any @ Usually a string. Messages may contain C-style format specifiers %d or %s, so log.error('...%d...%s', x, y) will work if x is a number and y is a string. Less commonly, messages may be other scalar data types, or even tables. So log.error({'x',18.7,true}) will work.
--- @return nil
function log.debug(message) end

---
--- Output a user-generated message to the log file, given log_level_function_name = error or warn or info or verbose or debug.
---
--- As explained in the description of the configuration setting for log_level, there are seven levels of detail:
---
--- 1 – SYSERROR
---
--- 2 – ERROR – this corresponds to log.error(...)
---
--- 3 – CRITICAL
---
--- 4 – WARNING – this corresponds to log.warn(...)
---
--- 5 – INFO – this corresponds to log.info(...)
---
--- 6 – VERBOSE – this corresponds to log.verbose(...)
---
--- 7 – DEBUG – this corresponds to log.debug(...)
---
--- For example, if box.cfg.log_level is currently 5 (the default value), then log.error(...), log.warn(...) and
--- log.info(...) messages will go to the log file. However, log.verbose(...) and log.debug(...) messages will not go
--- to the log file, because they correspond to higher levels of detail.
--- @param message any @ Usually a string. Messages may contain C-style format specifiers %d or %s, so log.error('...%d...%s', x, y) will work if x is a number and y is a string. Less commonly, messages may be other scalar data types, or even tables. So log.error({'x',18.7,true}) will work.
--- @return nil
function log.info(message) end

---
--- @return number @ PID of a logger
function log.logger_pid() end

---
--- Rotate the log.
--- @return nil
function log.rotate() end

return log;

