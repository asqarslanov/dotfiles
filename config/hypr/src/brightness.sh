#!/usr/bin/env sh

if [[ $1 == up ]]; then
  pkexec $(which brillo) -q -u 100000 -A 10

elif [[ $1 == down ]]; then
  pkexec $(which brillo) -q -u 100000 -U 10

fi

notify-send -t 400 $(pkexec $(which brillo) -G)%