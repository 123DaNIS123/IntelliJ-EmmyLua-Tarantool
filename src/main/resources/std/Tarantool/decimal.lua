---
--- The decimal module has functions for working with exact numbers. This is important when numbers are large or even
--- the slightest inaccuracy is unacceptable. For example Lua calculates 0.16666666666667 * 6 with floating-point so the
--- result is 1. But with the decimal module (using decimal.new to convert the number to decimal type)
--- decimal.new('0.16666666666667') * 6 is 1.00000000000002.
--- @module decimal

---
--- Returns absolute value of a decimal number. For example if a is -1 then decimal.abs(a) returns 1.
function abs(string_or_number_or_decimal_number) end

---
--- Returns e raised to the power of a decimal number. For example if a is 1 then decimal.exp(a) returns
--- 2.7182818284590452353602874713526624978. Compare math.exp(1) from the Lua math library, which returns 2.718281828459..
function exp(string_or_number_or_decimal_number) end

---
--- Returns true if the specified value is a decimal, and false otherwise. For example if a is 123 then
--- decimal.is_decimal(a) returns false. if a is decimal.new(123) then decimal.is_decimal(a) returns true.
function is_decimal(string_or_number_or_decimal_number) end

---
--- Returns natural logarithm of a decimal number. For example if a is 1 then decimal.ln(a) returns 0..
function ln(string_or_number_or_decimal_number) end

---
--- Returns base-10 logarithm of a decimal number. For example if a is 100 then decimal.log10(a) returns 2.
function log10(string_or_number_or_decimal_number) end

---
--- Returns the value of the input as a decimal number. For example if a is 1E-1 then decimal.new(a) returns 0.1.
function new(string_or_number_or_decimal_number) end

---
--- Returns the number of digits in a decimal number. For example if a is 123.4560 then decimal.precision(a) returns 7.
function precision(string_or_number_or_decimal_number) end

---
--- Returns the number after possible rounding or padding. If the number of post-decimal digits is greater than
--- new-scale, then rounding occurs. The rounding rule is: round half away from zero. If the number of post-decimal
--- digits is less than new-scale, then padding of zeros occurs. For example if a is -123.4550 then decimal.rescale(a, 2)
--- returns -123.46, and decimal.rescale(a, 5) returns -123.45500.
function rescale(string_or_number_or_decimal_number) end

---
--- Returns the number of post-decimal digits in a decimal number. For example if a is 123.4560 then decimal.scale(a) returns 4.
function scale(string_or_number_or_decimal_number) end

---
--- Returns the square root of a decimal number. For example if a is 2 then decimal.sqrt(a) returns 1.4142135623730950488016887242096980786.
function sqrt(string_or_number_or_decimal_number) end

---
--- Returns a decimal number after possible removing of trailing post-decimal zeros. For example if a is 2.20200 then decimal.trim(a) returns 2.202.
function trim(string_or_number_or_decimal_number) end