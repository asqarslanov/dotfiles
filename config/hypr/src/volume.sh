#!/usr/bin/env sh

if [[ $1 = up ]]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
elif [[ $1 = down ]]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
elif [[ $1 = mute ]]; then
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
elif [[ $1 = microphone ]]; then
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
fi

wpctl get-volume @DEFAULT_AUDIO_SOURCE@ |
  while read OUTPUT; do
    notify-send -t 400 Microphone "$OUTPUT"
  done

wpctl get-volume @DEFAULT_AUDIO_SINK@ |
  while read OUTPUT; do
    notify-send -t 400 Audio "$OUTPUT"
  done