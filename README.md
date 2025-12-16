# SPIN Oneshot GitHub Action

Execute SPIN notebooks in GitHub Actions workflows. This action runs a SPIN notebook in oneshot mode and captures the execution results.

## Usage

This GitHub Action is used to run a SPIN Notebook in oneshot mode.

### Example

See [.github/workflows/oneshot.yml](.github/workflows/oneshot.yml) for a complete example.

To use this action, copy the example workflow and ensure:
- Ensure `ONESHOT_SPIN_TOKEN` secret exists for your repo
  - To create a oneshot spin token, click on `Runtimes -> Oneshot Token -> Add Oneshot Token`
  - Store this as a actions secret in github `Settings -> Secrets and Variables -> Actions -> Repository Secrets`
- Set the Notebook URL appropriately when you kick off the workflow
  - In SPIN UI, click on the notebook you want and you can copy URL from your browser address bar
  - Looks like: `https://spin.siftd.ai/myorg/myworkspace/notebooks/mynotebookid2342sdFa`

