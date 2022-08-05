---
--- The tap module streamlines the testing of other modules. It allows writing of tests in the TAP protocol. The
--- results from the tests can be parsed by standard TAP-analyzers so they can be passed to utilities such as prove.
--- Thus one can run tests and then use the results for statistics, decision-making, and so on.
--- @module tap

---
--- Initialize.
---
--- The result of tap.test is an object, which will be called taptest in the rest of this discussion,
--- which is necessary for taptest:plan() and all the other methods.
--- @param test_name table @ taptest
function tap.test(test_name) end

---
--- @class Taptest
--- @field strict @ Set taptest.strict=true if taptest:is() and taptest:isnt() and taptest:is_deeply() must be compared strictly with nil. Set taptest.strict=false if nil and box.NULL both have the same effect. The default is false. For example, if and only if taptest.strict=true has happened, then taptest:is_deeply({a = box.NULL}, {}) will return false.
local taptest = {}

---
--- Create a subtest (if no func argument specified), or (if all arguments are specified) create a subtest,
--- run the test function and print the result.
--- @param test_name string @ an arbitrary name to give for the test outputs.
--- @param func function @ the test logic to run.
--- @return userdata|string @ taptest
function taptest:test(test_name, func) end

---
--- Indicate how many tests will be performed.
--- @param count number
--- @return nil
function taptest:plan(count) end

---
--- Checks the number of tests performed.
---
--- The result will be a display saying # bad plan: ... if the number of completed tests is not equal to the number of
--- tests specified by taptest:plan(...). (This is a purely Tarantool feature: “bad plan” messages are out of the TAP13 standard.)
---
--- This check should only be done after all planned tests are complete, so ordinarily taptest:check() will only appear
--- at the end of a script. However, as a Tarantool extension, taptest:check() may appear at the end of any subtest.
--- Therefore there are three ways to cause the check:
---
--- by calling taptest:check() at the end of a script,
--- by calling a function which ends with a call to taptest:check(),
--- or by calling taptest:test(‘…’, subtest-function-name) where subtest-function-name does not need to end with
--- taptest:check() because it can be called after the subtest is complete.
--- @return boolean @ true or false
function taptest:check() end

---
--- Display a diagnostic message.
--- @param message string @ the message to be displayed.
--- @return nil
function taptest:diag(message) end

---
--- Display a diagnostic message.
--- @param condition boolean @ an expression which is true or false
--- @param test_name string @ name of the test
--- @return boolean @ true or false
function taptest:ok(condition, test_name) end

---
--- taptest:fail('x') is equivalent to taptest:ok(false, 'x'). Displays the message.
--- @param test_name string @ name of the test
--- @return boolean @ true or false
function taptest:fail(test_name) end

---
--- taptest:skip('x') is equivalent to taptest:ok(true, 'x' .. '# skip'). Displays the message.
--- @param test_name string @ name of the test
--- @return nil
function taptest:skip(test_name) end

---
--- Check whether the first argument equals the second argument. Displays extensive message if the result is false.
--- @param got number @ actual result
--- @param expected number @ expected result
--- @param test_name string @ name of the test
--- @return boolean @ true or false.
function taptest:is(got, expected, test_name) end

---
--- This is the negation of taptest:is().
--- @param got number @ actual result
--- @param expected number @ expected result
--- @param test_name string @ name of the test
--- @return boolean @ true or false.
function taptest:isnt(got, expected, test_name) end

---
--- Recursive version of taptest:is(...), which can be be used to compare tables as well as scalar values.
--- @param got number @ actual result
--- @param expected number @ expected result
--- @param test_name string @ name of the test
--- @return boolean @ true or false.
function taptest:is_deeply(got, expected, test_name) end

---
--- Verify a string against a pattern. Ok if match is found.
--- @param got number @ actual result
--- @param expected number @ pattern
--- @param test_name string @ name of the test
--- @return boolean @ true or false.
function taptest:like(got, expected, test_name) end

---
--- This is the negation of taptest:like().
--- @param got number @ actual result
--- @param expected number @ pattern
--- @param test_name string @ name of the test
--- @return boolean @ true or false.
function taptest:unlike(got, expected, test_name) end

---
function taptest:isnil(value, message, extra) end

---
function taptest:isstring(value, message, extra) end

---
function taptest:isnumber(value, message, extra) end

---
function taptest:istable(value, message, extra) end

---
function taptest:isboolean(value, message, extra) end

---
function taptest:isudata(value, message, extra) end

---
--- Test whether a value has a particular type. Displays a long message if the value is not of the specified type.
--- @param value lua_value @ value the type of which is to be checked
--- @param utype string @ type of data that a passed value should have
--- @param ctype string @ type of data that a passed value should have
--- @param message string @ text that will be shown to the user in case of failure
--- @return boolean @ true or false
function taptest:iscdata(value, message, extra) end
