#!/bin/bash

# Set $DOCKER to installed docker runtime binary, preferring podman
DOCKER=$(which podman || which docker || echo "not found")
if [ "$DOCKER" = "not found" ]; then
    echo "Error: Either Podman or Docker must be installed."
    exit 1
fi

function help_msg() {
    echo "Usage:"
    echo "    helper.sh build"
    echo "        Build the quadletron container. Must cd into the repo first."
    echo "    helper.sh run <quadletron-dir>"
    echo "        Create iso file from a given config. Output goes to ./out/"
    echo "    helper.sh -h/--help"
    echo "        Show this message."
}

case $1 in
    'build') sudo podman build -t quadletron . || echo "Note: Must cd to the root of the repo first.";;
    'run') mkdir -p ./out;
        # Run mkarchiso
        sudo podman run \
            --privileged \
            -v "$(realpath $2):/config" \
            -v ./out:/out \
            localhost/quadletron:latest;
        # Find the newest iso in ./out
        iso_file=$(ls -t out/ | head -1)
        # Change owner to the current user
        if [ -n "./out/$iso_file" ]; then
            sudo chown -R $USER out/$iso_file
        fi
    ;;
    '-h'|'--help'|'help') help_msg;;
esac

