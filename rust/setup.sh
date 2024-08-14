#!/usr/bin/env sh

cargo build --release
cp target/release/hypr-toggle-special-workspace ~/.config/hypr/bin/toggle-special-workspace
