#!/bin/bash

# Set up cleanup trap early in the script
cleanup() {
  [ -n "$DEVCONTAINER_DEVPOD_FILE" ] &&
    rm -f "$DEVCONTAINER_DEVPOD_FILE"
}

trap cleanup EXIT
show_help() {
    echo "Usage: $0 [OPTIONS] <command> [devpod-args]"
    echo
    echo "Runs devpod with Neovim configuration"
    echo
    echo "Options:"
    echo "  -h, --help                           Show this help message and exit"
    echo "  --devcontainer-path <path>           Path to devcontainer.json (optional)"
    echo "  --user <user>                        Override default user (default: node)"
    echo
    echo "Example:"
    echo "  $0 up"
    echo "  $0 --devcontainer-path custom/devcontainer.json up"
    echo "  $0 --user developer up"
}

# Parse arguments
DEVCONTAINER_PATH=".devcontainer/devcontainer.json"
USER_ARG=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --devcontainer-path)
            DEVCONTAINER_PATH="$2"
            shift 2
            ;;
        --user)
            USER_ARG="--user $2"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

# Get the first remaining argument as command
FIRST_ARG=$1
shift

# Build the nvim-devcontainer-json command
if [ -n "$DEVCONTAINER_PATH" ]; then
    DEVCONTAINER_CMD="nvim-devcontainer-json $USER_ARG $DEVCONTAINER_PATH"
else
    DEVCONTAINER_CMD="nvim-devcontainer-json $USER_ARG"
fi

# Create the new devcontainer.json file and save next to the original as devcontainer.devpod.json
FILE_LOCATION=$(dirname "$DEVCONTAINER_PATH")
DEVCONTAINER_DEVPOD_FILE="$FILE_LOCATION/devcontainer.nvim.json"
$DEVCONTAINER_CMD > "$DEVCONTAINER_DEVPOD_FILE"

# If the devcontainer path was provided, pass it to devpod, otherwise ignore it
DEVCONTAINER_PATH_ARG=$([ -n "$DEVCONTAINER_PATH" ] && echo "--devcontainer-path $DEVCONTAINER_DEVPOD_FILE")
# shellcheck disable=SC2086
devpod "$FIRST_ARG" --ide none $DEVCONTAINER_PATH_ARG "$@"
