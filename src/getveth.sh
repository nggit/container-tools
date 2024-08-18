#!/usr/bin/env sh
# Copyright (c) 2024 nggit

if [ $# -gt 1 ]; then
    echo "expected at most 1 argument" 1>&2
    exit 1
fi

usage() {
    cat << EOF
getveth.sh - https://github.com/nggit/container-tools

Usage:
  ${0##*/} [CONTAINER]
  sh getveth.sh [CONTAINER]
EOF
}

lookup() {
    iflink=

    if [ "$(id -u)" -eq 0 ]; then
        pid=$(docker inspect --format "{{.State.Pid}}" "$1") && \
        iflink=$(nsenter -t "$pid" -m cat /sys/class/net/eth0/iflink)
    else
        iflink=$(docker exec "$1" cat /sys/class/net/eth0/iflink | xargs)
    fi

    if [ -z "$iflink" ] || \
            ! veth=$(grep -l "^$iflink\$" /sys/class/net/*/ifindex | cut -d/ -f5); then
        exit 1
    fi

    printf "  %d: %s: %s\n" "$iflink" "$veth" "$1"
}

if [ $# -eq 1 ]; then
    case $1 in
        -h|--help)
            usage
            ;;
        *)
            lookup "$1"
            ;;
    esac
else
    for container in $(docker ps --format "{{.Names}}"); do
        lookup "$container"
    done
fi
