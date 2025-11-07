#!/usr/bin/env sh

case "$1" in
"interactive")
  grim -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" - |
    satty --filename=-
  ;;
"file")
  mkdir --parents ~/Pictures/Screenshots/
  filename=~/Pictures/Screenshots/"$(date +%Y-%m-%d_%H-%M-%S)".png
  grim -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" "$filename"
  notify-send "File saved to '$filename'."
  ;;
"clipboard")
  filename=~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png
  grim -o "$(hyprctl -j activeworkspace | jq --raw-output .monitor)" - | wl-copy
  notify-send "Copied to clipboard" Screenshot
  ;;
"window")
  grim -g "$(hyprctl -j clients | jq --argjson active "$(hyprctl monitors -j | jq -c '[.[].activeWorkspace.id]')" '.[] | select((.hidden | not) and (.workspace.id as $id | $active | contains([$id]))) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' --raw-output | slurp -b "#000000b0" -c "#00000000")" - |
    satty --filename=-
  ;;
"pixel")
  color=$(hyprpicker)
  wl-copy "$color"
  notify-send "Copied to clipboard" "$color"
  ;;
esac
