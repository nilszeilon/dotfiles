function todo
    set documents_dir "$HOME/Documents"
    set folder_name "Todo"
    set file_name (date "+%Y-%m-%d").txt
    set todo_file "$documents_dir/$folder_name/$file_name"

    # Store the current working directory
    set current_dir (pwd)

    # Create the "Todo" folder if it doesn't exist
    if not test -d "$documents_dir/$folder_name"
        mkdir -p "$documents_dir/$folder_name"
    end

    # Check if the file exists; if not, create it
    if not test -f "$todo_file"
        touch "$todo_file"
    end

    # Open Vim with the full path to the file
    vim "$todo_file"

    # Return to the original working directory
    cd "$current_dir"
end

