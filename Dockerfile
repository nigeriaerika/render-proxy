# Dockerfile
# This is the blueprint for our TCP proxy service.

# 1. Start with a lightweight, official Node.js image.
# This image already has 'npm' installed.
FROM node:18-slim

# 2. Install the node-tcp-proxy package globally inside the container.
# The '--no-update-notifier' flag speeds up the install slightly.
RUN npm install -g node-tcp-proxy --no-update-notifier

# 3. Define the command that will be run when the container starts.
#    - It listens on the port Render provides via the $PORT environment variable.
#    - It forwards raw TCP traffic to rvn.kryptex.network:7031.
#    - The 'while true; do ...; sleep 3; done' loop ensures it restarts if it ever crashes.
CMD ["sh", "-c", "while true; do tcpproxy --hostname 0.0.0.0 --proxyPort ${PORT:-10000} --serviceHost rvn.kryptex.network --servicePort 7031 -q; sleep 3; done"]
