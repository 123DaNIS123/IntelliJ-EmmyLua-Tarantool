---
--- @class Datetime
local datetimeObject = {}

---
--- Convert the information from the datetime object into the table format. Resulting table has the following fields:
---
--- Field name | Description
---
--- nsec | Nanosecods
---
--- sec | Seconds
---
--- min | Minutes
---
--- hour | Hours
---
--- day | Day number
---
--- month | Month number
---
--- year | Year
---
--- wday | Days since the beginning of the week
---
--- yday | Days since the beginning of the year
---
--- isdst | Is the DST (Daylight saving time) applicable for the date. Boolean.
---
--- tzoffset | Time zone offset from UTC
--- @return table @ table with the date and time parameters
function datetimeObject:totable() end

---
--- Convert the standard datetime object presentation into a formatted string. The formatting convension specifications
--- are the same as in the strftime library. Additional convension for nanoseconds is %f which also allows a modifier to
--- control the output precision of fractional part: %5f (see the example below). If no arguments are set for the method,
--- the default convensions are used: '%FT%T.%f%z' (see the example below).
--- @param convensions string @ string consisting of zero or more conversion specifications and ordinary characters
--- @return string @ string with the formatted date and time information
function datetimeObject:format(convensions) end

---@class cdata

--- the default convensions are used: '%FT%T.%f%z' (see the example below).
--- @param units table @ Table of time units. The time units are the same as for the datetime.new() function
--- @return cdata @ updated datetime_object
function datetimeObject:set(units) end

---
--- Convert an input string with the date and time information into a datetime object. The input string should be
--- formatted according to one of the following standards:
---
--- ISO 8601
---
--- RFC 3339
---
--- extended strftime – see description of the format() for details.
--- @param input_string string @ string with the date and time information.
--- @param format string @ indicator of the input_sting format. Possible values: ‘iso8601’, ‘rfc3339’, or strptime-like format string. If no value is set, the default formating is used.
--- @param tzoffset number @ time zone offset from UTC, in minutes.
--- @return cdata @ a datetime_object
function datetimeObject:parse(input_string, format, tzoffset) end
