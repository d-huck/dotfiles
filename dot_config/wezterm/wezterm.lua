-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.window_padding = {
	left = 25,
	right = 25,
	top = 5,
	bottom = 5,
}

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12
config.color_scheme = "Catppuccin Mocha"

config.tab_bar_at_bottom = false

-- Finally, return the configuration to wezterm:
return config
