#!/bin/bash

TODO_FILE="$HOME/.todo_list_data"
TODO_COMMAND="$1"
TODO_ARGUMENT="$2"
TODO_REMINDER="$3"

case "$TODO_COMMAND" in

    "add")
        if [ ! -z "$TODO_ARGUMENT" ]; then
            echo "[ ] $TODO_ARGUMENT" >>"$TODO_FILE"
        fi
        ;;

    "list")
        cat --number "$TODO_FILE"
        ;;

    "done")
        if [ ! -z "$TODO_ARGUMENT" ]; then
            sed -i "${TODO_ARGUMENT}s/\[ \]/\[x\]/" "$TODO_FILE"
        fi
        ;;

    "remove")
        if [ ! -z "$TODO_ARGUMENT" ]; then
            read -p "Are you sure? (y/n) " CONFIRM_VALUE

            if [ ! -z "$CONFIRM_VALUE" ]; then
                if [ "$CONFIRM_VALUE" = "y" ]; then
                    sed -i "${TODO_ARGUMENT}d" "$TODO_FILE"
                elif [ "$CONFIRM_VALUE" = "n" ]; then
                    echo "Stopping action. This time..."
                else
                    echo "Aborting!"
                fi
            fi
        fi
        ;;

    "clear")
            read -p "Remove all todo's? (y/n) " CLEAR_CONFIRM_VALUE

            if [ ! -z "$CLEAR_CONFIRM_VALUE" ]; then
                if [ "$CLEAR_CONFIRM_VALUE" = "y" ]; then
                    > "$TODO_FILE"
                elif [ "$CLEAR_CONFIRM_VALUE" = "n" ]; then
                    echo "Regretting.."
                else
                    echo "Aborting!"
                fi
            fi
        ;;
    "remind")
        if [ -z "$TODO_ARGUMENT" ] || [ -z "$TODO_REMINDER" ]; then
            echo "Use me: todo remind <line_number> <reminder_timer_in_minutes>"
            exit 1
        fi
        TASK_TEXT=$(sed -n "${TODO_ARGUMENT}p" "$TODO_FILE" | sed 's/^\[.\] //')

        (crontab -l 2>/dev/null; echo "*/$TODO_REMINDER * * * * export DISPLAY=:0; export DBUS_SESSION_BUS_ADDRESS=\"unix:path=/run/user/\$(id -u)/bus\"; notify-send -u critical 'TODO REMINDER' '$TASK_TEXT'") | crontab -
        ;;

    *)
        echo "You suck"
        ;;

esac
