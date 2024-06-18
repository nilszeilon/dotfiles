function fast
    # Check if we're in a git repository
    if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
        echo "Not in a git repository. Aborting."
        return 1
    end

    # Add all changes, including untracked files
    git add -u

    # Check if additional arguments are provided
    if set -q argv[1]
        git commit -m (string join " " $argv)
    else
        git commit -m "fast commit"
    end
end
