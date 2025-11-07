#!/usr/bin/env sh

case "$1" in
"interactive")
  grim -t ppm -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" - |
    satty --filename=-
  ;;
"file")
  mkdir --parents ~/Pictures/Screenshots/
  filename=~/Pictures/Screenshots/"$(date +%Y-%m-%d_%H-%M-%S)".png
  grim -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" "$filename"
  notify-send "Screenshot" "File saved to '$filename'."
  ;;
"clipboard")
  filename=~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png
  grim -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" - | wl-copy
  notify-send "Screenshot" "Copied to clipboard."
  ;;
"window")
  wayfreeze &
  freeze_pid=$!
  geometry=$(hyprctl -j clients | jq --argjson active "$(hyprctl monitors -j | jq -c '[.[].activeWorkspace.id]')" '.[] | select((.hidden | not) and (.workspace.id as $id | $active | contains([$id]))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' --raw-output | slurp -b "#000000b0" -c "#00000000")
  kill "$freeze_pid"
  grim -g "$geometry" -t ppm - | satty --filename=-
  ;;
"pixel")
  color=$(hyprpicker)
  wl-copy "$color"
  notify-send "Color pick" "Copied to clipboard: '$color'."
  ;;
esac
