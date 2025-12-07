# SPIN Oneshot GitHub Action

Execute SPIN notebooks in GitHub Actions workflows. This action runs a SPIN notebook in oneshot mode and captures the execution results.

## Usage

### Basic Example

```yaml
name: Run SPIN Notebook
on: [push]

jobs:
  execute-notebook:
    runs-on: ubuntu-latest
    steps:
      - uses: siftd/suqe/.github/actions/spin-oneshot@main
        with:
          notebook-url: 'https://spin.siftd.ai/api/v1/orgs/myorg/workspaces/myworkspace/notebooks/my-notebook/export'
          spin-token: ${{ secrets.SPIN_TOKEN }}
```

### With Custom Saturn Server

```yaml
- uses: siftd/suqe/.github/actions/spin-oneshot@main
  with:
    notebook-url: 'https://example.com/notebook-export'
    spin-token: ${{ secrets.SPIN_TOKEN }}
    saturn-url: 'https://my-saturn-server.example.com'
    max-duration: '15m'
```

### Using Outputs

```yaml
- name: Execute SPIN Notebook
  id: spin
  uses: siftd/suqe/.github/actions/spin-oneshot@main
  with:
    notebook-url: ${{ vars.NOTEBOOK_URL }}
    spin-token: ${{ secrets.SPIN_TOKEN }}

- name: Display Results
  run: |
    echo "Execution completed in ${{ steps.spin.outputs.execution-duration }} seconds"
    echo "Session URLs: ${{ steps.spin.outputs.session-urls }}"
```

### Running on Schedule

```yaml
name: Scheduled Notebook Execution
on:
  schedule:
    - cron: '0 */6 * * *'  # Every 6 hours

jobs:
  scheduled-run:
    runs-on: ubuntu-latest
    steps:
      - uses: siftd/suqe/.github/actions/spin-oneshot@main
        with:
          notebook-url: ${{ vars.MONITORING_NOTEBOOK_URL }}
          spin-token: ${{ secrets.SPIN_TOKEN }}
          max-duration: '30m'
```

## Inputs

| Input | Required | Default | Description |
|-------|----------|---------|-------------|
| `notebook-url` | ✅ Yes | - | URL to the SPIN notebook to execute |
| `spin-token` | ✅ Yes | - | Authentication token for SPIN runtime (store in secrets) |
| `saturn-url` | No | - | URL to Saturn s-server instance (uses notebook's default if not specified) |
| `max-duration` | No | `10m` | Maximum execution duration (e.g., `10m`, `1h`, `30s`) |
| `output-format` | No | `urls` | Output format: `urls`, `json`, or `logs` |

## Outputs

| Output | Description |
|--------|-------------|
| `session-urls` | JSON array of viewable session URLs |
| `exit-code` | Notebook execution exit code (0 = success) |
| `execution-duration` | Execution duration in seconds |

## Getting a SPIN Token

To get a SPIN token for GitHub Actions:

1. Generate a token from your SPIN organization settings
2. Add it as a GitHub repository secret:
   - Go to your repository Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `SPIN_TOKEN`
   - Value: Your SPIN token

## Advanced Examples

### Matrix Strategy (Multiple Notebooks)

```yaml
jobs:
  multi-notebook:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        notebook:
          - name: 'Production Health Check'
            url: 'https://spin.siftd.ai/.../prod-health-check/export'
          - name: 'Staging Validation'
            url: 'https://spin.siftd.ai/.../staging-validation/export'
    steps:
      - name: Execute ${{ matrix.notebook.name }}
        uses: siftd/suqe/.github/actions/spin-oneshot@main
        with:
          notebook-url: ${{ matrix.notebook.url }}
          spin-token: ${{ secrets.SPIN_TOKEN }}
```

### With Notifications on Failure

```yaml
- name: Execute Notebook
  id: spin
  uses: siftd/suqe/.github/actions/spin-oneshot@main
  with:
    notebook-url: ${{ vars.NOTEBOOK_URL }}
    spin-token: ${{ secrets.SPIN_TOKEN }}
  continue-on-error: true

- name: Notify on Failure
  if: steps.spin.outputs.exit-code != '0'
  uses: actions/github-script@v7
  with:
    script: |
      github.rest.issues.createComment({
        issue_number: context.issue.number,
        owner: context.repo.owner,
        repo: context.repo.repo,
        body: '⚠️ SPIN notebook execution failed!'
      })
```

### Conditional Execution Based on Changes

```yaml
on:
  pull_request:
    paths:
      - 'infrastructure/**'

jobs:
  validate-infra:
    runs-on: ubuntu-latest
    steps:
      - uses: siftd/suqe/.github/actions/spin-oneshot@main
        with:
          notebook-url: ${{ vars.INFRA_VALIDATION_NOTEBOOK }}
          spin-token: ${{ secrets.SPIN_TOKEN }}
```

## Troubleshooting

### Action Times Out

Increase the `max-duration` input:

```yaml
with:
  max-duration: '30m'
```

### Authentication Errors

Ensure your `SPIN_TOKEN` secret is:
- Set correctly in repository secrets
- Not expired
- Has permissions to access the notebook

### View Full Logs

Use `output-format: logs` to see detailed execution logs:

```yaml
with:
  output-format: logs
```

## Local Testing

To test the action locally using `make oneshot`:

```bash
export NOTEBOOK_URL="https://your-notebook-url/export"
export SPIN_TOKEN="your-token"
make oneshot
```

## Image Variants

The action uses the full `spin-runtime` image which includes:
- AWS CLI
- Google Cloud SDK
- kubectl
- GitHub CLI
- Playwright (Chromium & Firefox)

For a minimal image, see the planned variants in the roadmap.

## Support

For issues or questions:
- GitHub Issues: https://github.com/siftd/suqe/issues
- Documentation: https://docs.spin.siftd.ai
