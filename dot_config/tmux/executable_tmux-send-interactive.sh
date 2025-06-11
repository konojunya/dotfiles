#!/bin/bash

set -e
trap 'echo "Error on line $LINENO"' ERR

echo "Starting tmux-send-interactive..."

# fzfの存在確認
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed"
    exit 1
fi

# 1. ペイン一覧取得（セッション:ウィンドウ.ペイン）
echo "Getting pane list..."
panes=$(tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} [#{pane_width}x#{pane_height}] #{pane_current_command}")

if [ -z "$panes" ]; then
    echo "No panes found"
    exit 1
fi

# ペイン選択
pane=$(echo "$panes" | fzf --prompt="Select pane: " --height=50% --layout=reverse)
target=$(echo "$pane" | awk '{print $1}')

# 2. キャンセルしたら終了
if [ -z "$target" ]; then
    echo "Cancelled pane selection."
    exit 0
fi

echo "Selected pane: $target"

# 3. コマンド入力
# 履歴から選択するか、新規入力
history_file="$HOME/.config/tmux/command_history.txt"
touch "$history_file"

cmd=$(cat "$history_file" | fzf --print-query --prompt="Enter command for $target: " --height=50% --layout=reverse | tail -n1)

# 4. キャンセルしたら終了
if [ -z "$cmd" ]; then
    echo "Cancelled command input."
    exit 0
fi

# 5. 履歴に追加（重複を避ける）
grep -Fxq "$cmd" "$history_file" || echo "$cmd" >> "$history_file"

# 6. 送信
echo "Sending command: $cmd"
tmux send-keys -t "$target" "$cmd" C-m

echo "Successfully sent '$cmd' to $target"
sleep 0.5 