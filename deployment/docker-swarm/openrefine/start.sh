#!/bin/bash

if [ -z "$REFINE_MEMORY" ] ; then
    TOTAL_MEMORY=`free -b | grep Mem | awk '{print $2}'`
    MIN_REFINE_MEMORY=$(( $TOTAL_MEMORY - 3 * 1024 * 1024 * 1024 ))
    REFINE_MEMORY=$(( $TOTAL_MEMORY * 6 / 10 ))

    if [ "$REFINE_MEMORY" -lt "$MIN_REFINE_MEMORY" ]; then
        REFINE_MEMORY="$MIN_REFINE_MEMORY"
    fi
fi

exec ./refine -i HOST -p PORT -d /mnt/refine -m $REFINE_MEMORY