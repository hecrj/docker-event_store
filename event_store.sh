#!/bin/sh

# Enable $by_category projection
(
    xargs wget localhost:2113 --retry-connrefused --tries=5 -q --wait=2 --spider;
    curl \
        -X POST \
        --user admin:changeit \
        -H "Content-Length: 0" \
        'http://127.0.0.1:2113/projection/$by_category/command/enable'
) &

# Run EventStore
cd EventStore
exec ./run-node.sh $@
