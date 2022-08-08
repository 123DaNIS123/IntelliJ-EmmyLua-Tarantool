---
--- utf8 is Tarantool’s module for handling UTF-8 strings. It includes some functions which are compatible with ones in
--- Lua 5.3 but Tarantool has much more. For example, because internally Tarantool contains a complete copy of the
--- “International Components For Unicode” library, there are comparison functions which understand the default ordering
--- for Cyrillic (Capital Letter Zhe Ж = Small Letter Zhe ж) and Japanese (Hiragana A = Katakana A).
--- @module utf8

---
--- Comparisons
---
--- Compare two strings with the Default Unicode Collation Element Table (DUCET) for the Unicode Collation Algorithm.
--- Thus ‘å’ is less than ‘B’, even though the code-point value of å (229) is greater than the code-point value of B (66),
--- because the algorithm depends on the values in the Collation Element Table, not the code-point values.
---
--- The comparison is done with primary weights. Therefore the elements which affect secondary or later weights
--- (such as “case” in Latin or Cyrillic alphabets, or “kana differentiation” in Japanese) are ignored. If asked “is
--- this like a Microsoft case-insensitive accent-insensitive collation” we tend to answer “yes”, though the Unicode
--- Collation Algorithm is far more sophisticated than those terms
--- @param UTF8_string string @ a string encoded with UTF-8
--- @param utf8_string string @ a string encoded with UTF-8
--- @return number @ -1 meaning “less”, 0 meaning “equal”, +1 meaning “greater”
function casecmp(UTF8_string, utf8_string) end

---
--- The code-point number is the value that corresponds to a character in the Unicode Character Database This is not the
--- same as the byte values of the encoded character, because the UTF-8 encoding scheme is more complex than a simple
--- copy of the code-point number.
---
--- Another way to construct a string with Unicode characters is with the \u{hex-digits} escape mechanism, for example
--- ‘\u{41}\u{42}’ and utf8.char(65,66) both produce the string ‘AB’.
--- @param code_point number @ a Unicode code point value, repeatable
--- @return string @ a UTF-8 string
function char(code_point) end

---
--- Compare two strings with the Default Unicode Collation Element Table (DUCET) for the Unicode Collation Algorithm.
--- Thus ‘å’ is less than ‘B’, even though the code-point value of å (229) is greater than the code-point value of B (66),
--- because the algorithm depends on the values in the Collation Element Table, not the code values.
---
--- The comparison is done with at least three weights. Therefore the elements which affect secondary or later weights
--- (such as “case” in Latin or Cyrillic alphabets, or “kana differentiation” in Japanese) are not ignored. and upper
--- case comes after lower case.
--- @param UTF8_string string @ a string encoded with UTF-8
--- @param utf8_string string @ a string encoded with UTF-8
--- @return number @ 1 meaning “less”, 0 meaning “equal”, +1 meaning “greater”
function char(UTF8_string, utf8_string) end

---
--- Return true if the input character is an “alphabetic-like” character, otherwise return false. Generally speaking a
--- character will be considered alphabetic-like provided it is typically used within a word, as opposed to a digit or
--- punctuation. It does not have to be a character in an alphabet.
--- @param UTF8_character string|number @ a single UTF8 character, expressed as a one-byte string or a code point value
function isalpha(UTF8_character) end

---
--- Return true if the input character is a digit, otherwise return false.
--- @param UTF8_character string|number @ a single UTF8 character, expressed as a one-byte string or a code point value
--- @return boolean @ true or false
function isalpha(UTF8_character) end

---
--- Return true if the input character is lower case, otherwise return false.
--- @param UTF8_character string|number @ a single UTF8 character, expressed as a one-byte string or a code point value
--- @return boolean @ true or false
function islower(UTF8_character) end

---
--- Return true if the input character is upper case, otherwise return false.
--- @param UTF8_character string|number @ a single UTF8 character, expressed as a one-byte string or a code point value
--- @return boolean @ true or false
function isupper(UTF8_character) end

---
--- Byte positions for start and end can be negative, which indicates “calculate from end of string” rather than
--- “calculate from start of string”.
---
--- If the string contains a byte sequence which is not valid in UTF-8, each byte in the invalid byte sequence will
--- be counted as one character.
---
--- UTF-8 is a variable-size encoding scheme. Typically a simple Latin letter takes one byte, a Cyrillic letter takes
--- two bytes, a Chinese/Japanese character takes three bytes, and the maximum is four
--- @param UTF8_string string @ a string encoded with UTF-8
--- @param start_byte integer @ byte position of the first character
--- @param end_byte integer @ byte position where to stop
--- @return number @ the number of characters in the string, or between start and end
function len(UTF8_string, start_byte, end_byte) end

---
--- @param UTF8_string string @ a string encoded with UTF-8
--- @return string @ the same string, lower case
function lower(UTF8_string) end

---
--- The next function is often used in a loop to get one character at a time from a UTF-8 string.
--- @param UTF8_string string @ a string encoded with UTF-8
--- @param start_byte integer @ byte position where to start within the string, default is 1
--- @return table @ byte position of the next character and the code point value of the next character
function next(UTF8_string, start_byte) end

---
--- Character positions for start and end can be negative, which indicates “calculate from end of string” rather than
--- “calculate from start of string”.
---
--- The default value for end-character is the length of the input string. Therefore, saying utf8.sub(1, 'abc') will
--- return ‘abc’, the same as the input string.
--- @param UTF8_string string @ a string encoded as UTF-8
--- @param start_character number @ the position of the first character
--- @param end_character number @ the position of the first character
--- @return string @ a UTF-8 string, the “substring” of the input value
function sub(UTF8_string, start_character, end_character) end

---
--- @param UTF8_string string @ a string encoded with UTF-8
--- @return string @ the same string, upper case
function upper(UTF8_string) end
