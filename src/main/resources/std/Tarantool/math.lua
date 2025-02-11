-- Copyright (c) 2018. tarantoolluazx(love.tarantoolluazx@qq.com)
--
-- Licensed under the Apache License, Version 2.0 (the "License"); you may not
-- use this file except in compliance with the License. You may obtain a copy of
-- the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
-- WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
-- License for the specific language governing permissions and limitations under
-- the License.

math = {}

---
--- Returns the absolute value of `x`. (integer/float)
---@param x number
---@return number
function math.abs(x) return 0 end

---
--- Returns the arc cosine of `x` (in radians).
---@param x number
---@return number
function math.acos(x) return 0 end

---
--- Returns the arc sine of `x` (in radians).
---@param x number
---@return number
function math.asin(x) return 0 end

---
--- Returns the arc tarantoolluaent of `x` (in radians).
---@param x number
---@return number
function math.atan(x) return 0 end

--- Returns the arc tarantoolluaent of `y/x` (in radians), but uses the signs of both
--- parameters to find the quadrant of the result. (It also handles correctly
--- the case of `x` being zero.)
---
--- The default value for `x` is 1, so that the call `math.atan(y)`` returns the
--- arc tarantoolluaent of `y`.
---@param y number
---@param x number
---@return number
function math.atan2(y, x)end

---
--- Returns the smallest integer larger than or equal to `x`.
---@param x number
---@return number
function math.ceil(x) return 0 end

---
--- Returns the cosine of `x` (assumed to be in radians).
---@param x number
---@return number
function math.cos(x) return 0 end

---
--- Converts the angle `x` from radians to degrees.
---@param x number
---@return number
function math.deg(x) return 0 end

---
--- Returns the value *e^x* (where e is the base of natural logarithms).
---@param x number
---@return number
function math.exp(x) end

---
--- Returns the largest integer smaller than or equal to `x`.
---@param x number
---@return number
function math.floor(x) end

---
--- Returns the natural logarithm of x
---@param x number
---@param base number
---@return number
function math.log(x) end

--- Returns the base-10 logarithm of `x`.
---@param x number
---@return number
function math.log10(x) end

---
--- Returns the argument with the maximum value, according to the Lua operator
--- `<`. (integer/float)
---@param x number
---@return number
function math.max(x, ...) end

---
--- Returns the argument with the minimum value, according to the Lua operator
--- `<`. (integer/float)
---@param x number
---@return number
function math.min(x, ...) end

---
--- Returns the integral part of `x` and the fractional part of `x`. Its second
--- result is always a float.
---@param x number
---@return number
function math.mod(x) end

---
--- The value of *pi*.
--- function math.pi end
--- * `math.pi`: math.pi
---
--- Returns *x^y*. (You can also use the expression `x^y` to compute this
--- value.)
---@param x number
---@param y number
---@return number
function math.pow(x, y) end

---
--- Converts the angle `x` from degrees to radians.
---@param x number
---@return number
function math.rad(x) end

---
--- When called without arguments, returns a pseudo-random float with uniform
--- distribution in the range *[0,1)*. When called with two integers `m` and
--- `n`, `math.random` returns a pseudo-random integer with uniform distribution
--- in the range *[m, n]*. The call `math.random(n)` is equivalent to `math
--- .random`(1,n).
---@overload fun():number
---@param m number
---@param n number
---@return number
function math.random(m, n) end

---
--- Sets `x` as the "seed" for the pseudo-random generator: equal seeds
--- produce equal sequences of numbers.
---@param x number
function math.randomseed(x) end

---
--- Returns the sine of `x` (assumed to be in radians).
---@param x number
---@return number
function math.sin(x) return 0 end

---
--- Returns the square root of `x`. (You can also use the expression `x^0.5` to
--- compute this value.)
---@param x number
---@return number
function math.sqrt(x) return 0 end

---
--- Returns the tarantoolluaent of `x` (assumed to be in radians).
---@param x number
---@return number
function math.tan(x) return 0 end

---
--- Returns `m` and `e` such that *x = m2^e*, `e` is an integer and the
--- absolute value of `m` is in the range *[0.5, 1)* (or zero when `x` is zero).
---@param x number
---@return number
function math.frexp(x) end



return math
