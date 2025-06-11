#!/bin/bash

# 現在のセッション名
session=$(tmux display-message -p '#S')

# list windows with index and name (fallback to command if name is empty)
window=$(tmux list-windows -F "#{window_index}: #{?window_name,#{window_name},#{pane_current_command}}" | fzf --prompt="Select tab: " --height=50% --layout=reverse)

[ -z "$window" ] && exit

# 抽出した index に移動
index=$(echo "$window" | cut -d: -f1)

tmux select-window -t "$session:$index"
