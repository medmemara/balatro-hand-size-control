local HandSize = dofile("src/hand_size.lua")

local function assert_equal(actual, expected, message)
    if actual ~= expected then
        error(string.format("%s: expected %s, got %s", message, tostring(expected), tostring(actual)))
    end
end

assert_equal(HandSize.normalize_mode("minimum"), "minimum", "valid minimum mode")
assert_equal(HandSize.normalize_mode("fixed"), "fixed", "valid fixed mode")
assert_equal(HandSize.normalize_mode("unknown"), "minimum", "invalid mode fallback")

assert_equal(HandSize.normalize_value(-1), 1, "minimum value")
assert_equal(HandSize.normalize_value(51), 50, "maximum value")
assert_equal(HandSize.normalize_value("10"), 10, "string value")

assert_equal(HandSize.calculate(4, { mode = "minimum", hand_size = 8 }), 8, "minimum raises reduced hand")
assert_equal(HandSize.calculate(10, { mode = "minimum", hand_size = 8 }), 10, "minimum preserves larger hand")
assert_equal(HandSize.calculate(10, { mode = "fixed", hand_size = 8 }), 8, "fixed overrides larger hand")
assert_equal(HandSize.calculate(4, { mode = "fixed", hand_size = 12 }), 12, "fixed raises reduced hand")
assert_equal(HandSize.calculate(nil, { mode = "minimum", hand_size = 8 }), 8, "missing current hand fallback")
