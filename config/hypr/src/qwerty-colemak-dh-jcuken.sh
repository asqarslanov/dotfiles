#!/usr/bin/env sh

layout=$(hyprctl getoption input:kb_layout -j | jq .str)

if [ "$layout" = '"qwerty, jcuken"' ]; then
  hyprctl keyword input:kb_layout "colemak-dh, jcuken"
else
  hyprctl keyword input:kb_layout "qwerty, jcuken"
fi
