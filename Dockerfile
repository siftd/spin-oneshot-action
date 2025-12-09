# GitHub Action Dockerfile for SPIN Oneshot Execution
# This references the published spin-runtime image

#FROM ghcr.io/siftd/spin-runtime:latest
FROM ghcr.io/siftd/spin-runtime:rc-e0488aac37a9853d65de4302360098735247ac53

# Set oneshot mode by default
ENV RUNTIME_MODE=oneshot

# Call the existing script with GitHub Action flag
ENTRYPOINT ["/opt/spin/start-spin-runtime.sh", "--github-action"]
