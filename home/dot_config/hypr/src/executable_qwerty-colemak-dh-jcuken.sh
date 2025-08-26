#!/usr/bin/env sh

layout=$(hyprctl getoption input:kb_layout -j | jq .str)

if [ "$layout" = '"colemak-dh, jcuken"' ]; then
  hyprctl keyword input:kb_layout "qwerty, jcuken"
else
  hyprctl keyword input:kb_layout "colemak-dh, jcuken"
fi
