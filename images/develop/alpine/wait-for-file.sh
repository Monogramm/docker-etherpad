#!/bin/sh
set -e

###########################################################
# Functions


log() {
    MESSAGE=$1

    echo "[$0] [$(date +%Y-%m-%dT%H:%M:%S)] ${MESSAGE}"
}

# wait for file/directory to exists
wait_for_file() {
    WAIT_FOR_FILE=${1}
    if [ -z "${WAIT_FOR_FILE}" ]; then
        log "Missing file path to wait for!"
        exit 1
    fi

    WAIT_TIME=0
    WAIT_STEP=${2:-10}
    WAIT_TIMEOUT=${3:--1}

    while [ ! -d "${WAIT_FOR_FILE}" ] ; do
        if [ "${WAIT_TIMEOUT}" -gt 0 ] && [ "${WAIT_TIME}" -gt "${WAIT_TIMEOUT}" ]; then
            log "File '${WAIT_FOR_FILE}' was not available on time!"
            exit 1
        fi

        log "Waiting file '${WAIT_FOR_FILE}'..."
        sleep "${WAIT_STEP}"
        WAIT_TIME=$(( WAIT_TIME + WAIT_STEP ))
    done
    log "File '${WAIT_FOR_FILE}' exists."
}

wait_for_files() {
    if [ -z "${WAIT_FOR_FILES}" ]; then
        log "Missing env var 'WAIT_FOR_FILES' defining files to wait for!"
        exit 1
    fi

    for H in ${WAIT_FOR_FILES}; do
        wait_for_file "${H}" "${WAIT_STEP}" "${WAIT_TIMEOUT}"
    done

}

###########################################################
# Runtime

wait_for_files

exec "$@"
