#!/usr/bin/env sh
# Copyright (c) 2024 nggit

if [ $# -ne 1 ]; then
    printf "expected 1 argument, got %d\n" "$#" 1>&2
    exit 1
fi

usage() {
    cat << EOF
getcontainer.sh - https://github.com/nggit/container-tools

Usage:
  ${0##*/} [PID]
  sh getcontainer.sh [PID]
EOF
}

lookup() {
    if ! container=$(grep ":/docker/" "/proc/$1/cgroup"); then
        exit 1
    fi

    docker ps --filter "id=${container##*/}" --format "{{.Names}}"
}

case $1 in
    -h|--help)
        usage
        ;;
    *)
        lookup "$1"
        ;;
esac
