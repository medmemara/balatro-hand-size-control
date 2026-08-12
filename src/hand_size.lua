local HandSize = {}

local VALID_MODES = {
    minimum = true,
    fixed = true,
}

HandSize.MIN_HAND_SIZE = 1
HandSize.MAX_HAND_SIZE = 50

function HandSize.normalize_mode(mode)
    return VALID_MODES[mode] and mode or "minimum"
end

function HandSize.normalize_value(hand_size)
    local value = math.floor(tonumber(hand_size) or 8)
    return math.max(HandSize.MIN_HAND_SIZE, math.min(HandSize.MAX_HAND_SIZE, value))
end

function HandSize.calculate(current_hand_size, config)
    config = config or {}
    local current = tonumber(current_hand_size) or 8
    local selected = HandSize.normalize_value(config.hand_size)

    if HandSize.normalize_mode(config.mode) == "fixed" then
        return selected
    end

    return math.max(current, selected)
end

return HandSize
