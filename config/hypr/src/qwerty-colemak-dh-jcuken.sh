#!/usr/bin/env sh

layout=$(hyprctl getoption input:kb_layout -j | jq .str)

if [ "$layout" = '"colemak-dhw, jcuken-w"' ]; then
  hyprctl keyword input:kb_layout "qwerty, jcuken-w"
else
  hyprctl keyword input:kb_layout "colemak-dhw, jcuken-w"
fi
