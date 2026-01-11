# GitHub Action Dockerfile for SPIN Oneshot Execution
# This references the published spin-runtime image

FROM ghcr.io/siftd/spin-runtime:latest

# Set oneshot mode by default
ENV RUNTIME_MODE=oneshot

# Call the existing script with GitHub Action flag
ENTRYPOINT ["/opt/spin/start-spin-runtime.sh", "--github-action"]
