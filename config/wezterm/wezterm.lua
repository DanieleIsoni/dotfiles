local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Gruvbox Dark (Gogh)"

config.keys = {
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

config.font = wezterm.font "JetBrainsMono Nerd Font"

-- config.font_size = 13
-- use_fancy_tab_bar = false,

config.tab_max_width = 100
config.scrollback_lines = 10000
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.front_end = "WebGpu"

-- local function tab_title(tab_info)
--   local title = tab_info.tab_title
--   -- if the tab title is explicitly set, take that
--   if title and #title > 0 then
--     return title
--   end
--   -- Otherwise, use the title from the active pane
--   -- in that tab
--   return tab_info.active_pane.title
-- end
--
-- wezterm.on(
--   'format-tab-title',
--   function(tab, tabs, panes, config, hover, max_width)
--     local title = tab_title(tab)
--     if tab.is_active then
--       return {
--         { Text = ' ' .. title .. ' ' },
--       }
--     end
--     return title
--   end
-- )

return config
