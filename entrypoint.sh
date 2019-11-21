#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /application/tmp/pids/server.pid

#sidekiq -q default -q mailers & disown

WORKERS=CreatedPromotionsWorker,UpdatedPromotionsWorker,UserInvitedWorker rake sneakers:run



# Then exec the container's main process (what's set as CMD in the Dockerfile).
#exec "$@"