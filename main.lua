HandSizeControl = HandSizeControl or {}

local HSC = HandSizeControl
local mod = SMODS.current_mod

HSC.mod = mod
HSC.config = mod.config
HSC.HandSize = assert(SMODS.load_file("src/hand_size.lua"))()

local MODE_VALUES = { "minimum", "fixed" }
local HAND_SIZE_VALUES = {}

for hand_size = HSC.HandSize.MIN_HAND_SIZE, HSC.HandSize.MAX_HAND_SIZE do
    HAND_SIZE_VALUES[#HAND_SIZE_VALUES + 1] = hand_size
end

local function index_of(values, selected)
    for index, value in ipairs(values) do
        if value == selected then
            return index
        end
    end
    return 1
end

local function save_setting(args)
    local cycle = args and args.cycle_config
    local values = cycle and cycle.hsc_values
    local key = cycle and cycle.hsc_key
    local value = values and values[args.to_key]

    if key and value ~= nil then
        HSC.config[key] = value
        SMODS.save_mod_config(HSC.mod)
    end
end

G.FUNCS.hsc_save_setting = save_setting

function HSC.apply_starting_hand_size()
    local starting_params = G.GAME and G.GAME.starting_params
    if not starting_params then
        return
    end

    starting_params.hand_size = HSC.HandSize.calculate(starting_params.hand_size, HSC.config)
end

function HSC.config_tab()
    local mode_labels = {
        localize("k_hsc_minimum"),
        localize("k_hsc_fixed"),
    }
    local size_labels = {}

    for _, hand_size in ipairs(HAND_SIZE_VALUES) do
        size_labels[#size_labels + 1] = hand_size .. " " .. localize("k_hsc_cards")
    end

    return {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.BLACK, minw = 8, minh = 5, padding = 0.2, r = 0.1 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.08 },
                nodes = {
                    create_option_cycle({
                        label = localize("b_hsc_mode"),
                        options = mode_labels,
                        current_option = index_of(MODE_VALUES, HSC.HandSize.normalize_mode(HSC.config.mode)),
                        opt_callback = "hsc_save_setting",
                        hsc_key = "mode",
                        hsc_values = MODE_VALUES,
                        colour = G.C.BLUE,
                        w = 4.5,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.08 },
                nodes = {
                    create_option_cycle({
                        label = localize("b_hsc_hand_size"),
                        options = size_labels,
                        current_option = index_of(HAND_SIZE_VALUES, HSC.HandSize.normalize_value(HSC.config.hand_size)),
                        opt_callback = "hsc_save_setting",
                        hsc_key = "hand_size",
                        hsc_values = HAND_SIZE_VALUES,
                        colour = G.C.ORANGE,
                        w = 4.5,
                        no_pips = true,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.15 },
                nodes = {
                    {
                        n = G.UIT.T,
                        config = { text = localize("k_hsc_new_run_only"), colour = G.C.UI.TEXT_LIGHT, scale = 0.38 },
                    },
                },
            },
        },
    }
end

mod.config_tab = HSC.config_tab

local original_apply_to_run = Back.apply_to_run
function Back:apply_to_run(...)
    original_apply_to_run(self, ...)
    HSC.apply_starting_hand_size()
end
