# SPIN Oneshot GitHub Action

Execute SPIN notebooks in GitHub Actions workflows. This action runs a SPIN notebook in oneshot mode and captures the execution results.

## Usage

This GitHub Action is used to run a SPIN Notebook in oneshot mode.

### Example

See [.github/workflows/oneshot.yml](.github/workflows/oneshot.yml) for a complete example.

To use this action, copy the example workflow and ensure:
- The `SPIN_TOKEN` secret is configured in your repository
- The notebook URL is set appropriately (you can copy this directly from your browser when the notebook is loaded)
