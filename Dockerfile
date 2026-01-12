# GitHub Action Dockerfile for SPIN Oneshot Execution
# This references the published spin-runtime image

#FROM ghcr.io/siftd/spin-runtime:latest
FROM ghcr.io/siftd/spin-runtime:rc-eb3aff6a12a1d4529d15f3af950b91d8855b84a9

# Set oneshot mode by default
ENV RUNTIME_MODE=oneshot

# Call the existing script with GitHub Action flag
ENTRYPOINT ["/opt/spin/start-spin-runtime.sh", "--github-action"]
