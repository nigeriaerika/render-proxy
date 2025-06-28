# Dockerfile
# This is the blueprint for our TCP proxy service.

# 1. Start with a lightweight, official Node.js image.
# This image already has 'npm' installed.
FROM node:18-slim

# 2. Install the node-tcp-proxy package globally inside the container.
# The '--no-update-notifier' flag speeds up the install slightly.
RUN npm install -g node-tcp-proxy --no-update-notifier

# 3. Define the command that will be run when the container starts.
# This command starts the TCP proxy in a resilient loop.
# - It listens on all interfaces (0.0.0.0) on port 443.
# - It forwards traffic to rvn.kryptex.network:7031.
# - It enables TLS for both incoming and outgoing connections.
# - The 'while true; do ...; sleep 3; done' loop ensures it restarts if it ever crashes.
CMD ["sh", "-c", "while true; do tcpproxy --hostname 0.0.0.0 --proxyPort 443 --serviceHost rvn.kryptex.network --servicePort 7031 --tls both -q; sleep 3; done"]
