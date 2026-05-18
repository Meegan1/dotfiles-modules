#!/bin/bash

# Show help text
show_help() {
    echo "Usage: $0 [options] <path-to-devcontainer.json>"
    echo
    echo "Merges a devcontainer.json file with Neovim configuration settings"
    echo
    echo "Options:"
    echo "  --user USER    Override default user (default: node)"
    echo "  -h, --help     Show this help message"
    echo
    echo "Arguments:"
    echo "  path-to-devcontainer.json    Path to the devcontainer.json file to modify"
    echo
    echo "Example:"
    echo "  $0 --user myuser .devcontainer/devcontainer.json"
}

# Default user
USER_NAME="node"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --user)
            USER_NAME="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            INPUT_FILE="$1"
            shift
            ;;
    esac
done

# Set default input file if not specified
INPUT_FILE="${INPUT_FILE:-.devcontainer/devcontainer.json}"

# Check if file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

# Merge JSON files
jq -s '.[0] * .[1]' \
    <(sed 's/^ *\/\/.*//' "$INPUT_FILE") \
    <(cat << EOF
{
    "features": {
        "ghcr.io/motion-12/devcontainer-features/neovim:1.6.0": {},
        "ghcr.io/devcontainers/features/github-cli:1": {}
    },
    "mounts": [
        {
            "source": "~/.config/github-copilot",
            "target": "/home/$USER_NAME/.config/github-copilot",
            "type": "bind"
        },
        {
            "source": "~/.config/gh",
            "target": "/home/$USER_NAME/.config/gh",
            "type": "bind"
        },
        {
          "source": "neovim-cache",
          "target": "/home/$USER_NAME/.cache/nvim",
          "type": "volume"
        },
        {
          "source": "neovim-data",
          "target": "/home/$USER_NAME/.local/share/nvim",
          "type": "volume"
        }
    ],
    "postCreateCommand": {
        "cache-ownership": "sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.cache",
        "local-ownership": "sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.local",
        "bun-ownership": "if [ -d /home/$USER_NAME/.bun ]; then sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.bun; fi"
    }
}
EOF
) || {
    echo "Error: Failed to merge JSON files"
    exit 1
}
