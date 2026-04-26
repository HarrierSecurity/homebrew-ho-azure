# homebrew-ho-azure

Homebrew tap for HarrierOps Azure packaging work.

This tap has two lanes:

- stable formula: `ho-azure`
- preview formula: `ho-azure-preview`

The stable formula tracks tagged source releases published by
`https://github.com/HarrierSecurity/HarrierOps-Azure`. The preview formula tracks main-branch
merge velocity and stays tap-only. For now, use preview when you want the latest tap build after
main PRs merge.

The stable formula is intended to stay Homebrew/core-shaped: tagged source tarball, explicit
checksum, source build, safe offline tests, and `brew audit --new --formula` coverage in CI.

## Install

```bash
brew install harriersecurity/ho-azure/ho-azure
```

Preview channel:

```bash
brew install harriersecurity/ho-azure/ho-azure-preview
```

The stable and preview formulae both install the `ho-azure` binary. Install one channel at a time.

## Repository Layout

- `Formula/ho-azure.rb`
  stable formula that tracks tagged `HarrierOps-Azure` releases
- `Formula/ho-azure-preview.rb`
  preview formula that tracks main-branch merge snapshots
- `scripts/update_formula.py`
  updates the formula URL and SHA256 from release metadata
- `.github/workflows/validate-formula.yml`
  runs audit, source install, and formula test on pull requests
- `.github/workflows/update-stable-formula.yml`
  accepts tagged release metadata, updates the stable formula, opens a PR, and enables auto-merge
- `.github/workflows/update-preview-formula.yml`
  accepts release metadata, updates the formula, opens a PR, and enables
  auto-merge

## Automation Model

`HarrierOps-Azure` remains the source of truth for releases and tags.

When a new release is published in the main repo, the main repo dispatches the
version, source tarball URL, and SHA256 into this tap repo. The tap repo then:

1. updates `Formula/ho-azure.rb`
2. opens a PR
3. runs validation on that PR
4. enables auto-merge once required checks are green

When `main` changes in the main repo, the preview lane can dispatch a main snapshot into this tap.
The tap repo then updates `Formula/ho-azure-preview.rb` through the same PR and validation flow.

The formula build path should match the source archive it points at. The current `v1.2.0` stable
formula and pre-`v1.3` preview snapshots build from `./cmd/azurefox`. After the `v1.3` entrypoint
lands on `main`, preview should move to `./cmd/ho-azure`; after the `v1.3.x` tag exists, stable
should do the same and add the `exfil diagnostic-settings` formula test.

The preview and stable update workflows inspect the incoming source archive and update the formula
build path to match. Pre-`v1.3` sources continue to use `./cmd/azurefox`; sources that contain the
new entrypoint use `./cmd/ho-azure`.
