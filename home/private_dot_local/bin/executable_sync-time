#!/usr/bin/env sh

sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"
