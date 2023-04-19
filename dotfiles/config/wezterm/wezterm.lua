local wezterm = require 'wezterm'

local config= {

}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

--config.color_scheme = 'Gruvbox dark, medium (base16)'
config.color_scheme = 'Everforest Dark (Gogh)'
config.font = wezterm.font('MesloLGS Nerd Font Mono')
--config.freetype_load_target = "Light"
--config.freetype_load_flags = 'FORCE_AUTOHINT'
config.font_size = 11
config.enable_tab_bar = false

return config
