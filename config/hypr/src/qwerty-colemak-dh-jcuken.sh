#!/usr/bin/env sh

layout=$(hyprctl getoption input:kb_layout -j | jq .str)

if [ "$layout" = '"colemak-dhw-antiwide, jcuken-w-antiwide"' ]; then
  hyprctl keyword input:kb_layout "qwerty-antiwide, jcuken-antiwide"
else
  hyprctl keyword input:kb_layout "colemak-dhw-antiwide, jcuken-w-antiwide"
fi
