#!/bin/bash

# Path to the todo file in the user's home directory
TODO_FILE="$HOME/todo.txt"

# Ensure the todo file exists
touch "$TODO_FILE"

while true; do

    echo "   MY TO-DO LIST MANAGER - Stage 2 Task"

    echo "1. View all tasks"
    echo "2. Add a new task"
    echo "3. Delete a task"
    echo "4. Exit"
    echo "====================="
    read -p "Choose an option (1-4): " choice

    case $choice in
        1)
            echo ""
            echo "--- Current Tasks ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "Your to-do list is empty!"
            else
                # nl command numbers the lines for easy deletion
                nl -w2 -s'. ' "$TODO_FILE"
            fi
            echo ""
            ;;
        2)
            echo ""
            read -p "Enter the new task: " new_task
            if [ -z "$new_task" ]; then
                echo "Task cannot be empty!"
            else
                # Append task to the file
                echo "$new_task" >> "$TODO_FILE"
                echo "Task added successfully!"
            fi
            echo ""
            ;;
        3)
            echo ""
            echo "--- Current Tasks ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "No tasks available to delete."
            else
                nl -w2 -s'. ' "$TODO_FILE"
                echo ""
                read -p "Enter the task number to delete: " task_num
                
                # Check if input is a valid number and line exists
                total_lines=$(wc -l < "$TODO_FILE")
                if [[ "$task_num" =~ ^[0-9]+$ ]] && [ "$task_num" -le "$total_lines" ] && [ "$task_num" -gt 0 ]; then
                    # Use sed to delete the specific line
                    sed -i "${task_num}d" "$TODO_FILE"
                    echo "Task #$task_num deleted successfully!"
                else
                    echo "Invalid task number!"
                fi
            fi
            echo ""
            ;;
        4)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done

