#!/bin/bash

# Author: Yusuf Kaya
# Crated date: 19/09/2023
# Modified date: 19/09/2023

# Description
# This script reads a file. If the file exists, it prints the content of the file.
# If the file does not exist, it creates the file and writes the content to it.
# after that, it asks the user if they want to create copies of the file. If the user
# wants to create copies, it asks how many copies they want to create. Then it creates
# These copy files will include the time, date, and file name.

# Usage
# ./read_file.sh

#!/bin/bash

read -p "Enter a file name: "

if [ -e "$file_name" ] || [ -e "$file_name"* ]; then
    matched_files=("$file_name"*)
    matched_count="${#matched_files[@]}"

    if [ "$matched_count" -gt 0 ]; then
        PS3="Multiple files with similar names and different extensions found. Please choose one of the following options: "
        select option in "${matched_files[@]}"; do
            if [ -n "$option" ]; then
                echo "You have selected: $option"
                echo "Your file is found, the file contents are being printed on the screen."
                sleep 2
                cat "$option"
                break
            else
                echo "Invalid selection. Please choose a valid option."
            fi
        done
    else
        echo "Your file is found, the file contents are being printed on the screen."
        sleep 2
        cat "$file_name"
    fi
else
    echo "No matching files found for the entered name."
    echo "Creating the file..."
    sleep 2
    touch "$file_name"
    read -p  "Enter the content for the file and press Enter when done: " file_content
    echo "$file_content" > "$file_name"
    echo "File created and content written."
    sleep 1
    read -p  "Are you want to create copies of the file? (y/n) : " response
    if [ "$response" != "n" ]; then
        read -p  "How many copies do you want to create? (1-9) : " copy_count
        for i in $(seq 1 "$copy_count"); do
            cp "$file_name" "${file_name}_copy${i}_$(date +"%Y-%m-%d:%H-%M")"
            sleep 1
            echo "Copy $i created."
        done
    else
        echo "Exiting..."
        exit 0 
    fi
fi
