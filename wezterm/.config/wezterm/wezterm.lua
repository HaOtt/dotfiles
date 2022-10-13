local wezterm = require 'wezterm'

return {
  font = wezterm.font {
    family = 'FiraCode Nerd Font Mono',
    stretch = 'Normal',
    weight = 'Regular',
  },
  font_size = 12,
  color_scheme = "nightfox",
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  }
}

