#!/bin/bash

TODO_FILE="${HOME}/.todo_list_data"

usage() {
cat <<'EOF'
TodoMe - a tiny CLI todo list

Usage:
todo add <task...>
todo list
todo done <line_number>
todo remove <line_number>
todo clear
todo remind <line_number> <minutes>

Notes:
- Uses ~/.todo_list_data to store tasks
- "remind" schedules a one-shot desktop notification using notify-send
EOF
}

ensure_file_exists() {
if [[ ! -f "$TODO_FILE" ]]; then
: >"$TODO_FILE"
fi
}

is_positive_int() {
[[ "${1:-}" =~ ^[0-9]+$ ]] && [[ "${1:-0}" -gt 0 ]]
}

max_line_number() {
ensure_file_exists
wc -l <"$TODO_FILE" | tr -d '[:space:]'
}

require_valid_line_number() {
local line="${1:-}"
if ! is_positive_int "$line"; then
echo "Error: line_number must be a positive integer." >&2
exit 1
fi

local max
max="$(max_line_number)"
if [[ "$max" -lt 1 || "$line" -gt "$max" ]]; then
echo "Error: line_number $line does not exist (valid: 1-$max)." >&2
exit 1
fi
}

confirm() {
local prompt="${1:-Are you sure? (y/n) }"
local reply
read -r -p "$prompt" reply || true
case "$reply" in
[Yy]|[Yy][Ee][Ss]) return 0 ;;
[Nn]|[Nn][Oo]|"") return 1 ;;
*) echo "Aborting!" >&2; return 1 ;;
esac
}

TODO_COMMAND="${1:-}"
shift || true

case "$TODO_COMMAND" in
add)
ensure_file_exists
if [[ "$#" -lt 1 ]]; then
    echo "Error: missing task text." >&2
    usage
    exit 1
fi
echo "[ ] $*" >>"$TODO_FILE"
;;

list)
ensure_file_exists
if [[ ! -s "$TODO_FILE" ]]; then
    echo "No todos yet. Add one with: todo add <task...>"
    exit 0
fi
cat --number "$TODO_FILE"
;;

done)
ensure_file_exists
require_valid_line_number "${1:-}"
sed -i "${1}s/\[ \]/[x]/" "$TODO_FILE"
;;

remove)
ensure_file_exists
require_valid_line_number "${1:-}"
if confirm "Remove todo #${1}? (y/n) "; then
    sed -i "${1}d" "$TODO_FILE"
fi
;;

clear)
ensure_file_exists
if confirm "Remove all todos? (y/n) "; then
    : >"$TODO_FILE"
fi
;;

remind)
ensure_file_exists
require_valid_line_number "${1:-}"
if ! is_positive_int "${2:-}"; then
    echo "Error: minutes must be a positive integer." >&2
    echo "Usage: todo remind <line_number> <minutes>" >&2
    exit 1
fi

TASK_TEXT="$(sed -n "${1}p" "$TODO_FILE" | sed 's/^\[[^]]\][[:space:]]\+//')"
if [[ -z "${TASK_TEXT// }" ]]; then
    echo "Error: todo #${1} is empty; not scheduling a reminder." >&2
    exit 1
fi

if ! command -v notify-send >/dev/null 2>&1; then
    echo "Error: notify-send not found. Install libnotify and try again." >&2
    exit 1
fi

seconds="$(( 60 * ${2} ))"
nohup bash -c 'sleep "$1"; notify-send -u critical "TODO REMINDER" "$2"' _ "$seconds" "$TASK_TEXT" \
    >/dev/null 2>&1 &
echo "Reminder set for ${2} minute(s) from now for todo #${1}."
;;

""|-h|--help|help)
usage
;;

*)
echo "Error: unknown command: $TODO_COMMAND" >&2
usage
exit 1
;;
esac
