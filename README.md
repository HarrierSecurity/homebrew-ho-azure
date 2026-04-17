# homebrew-ho-azure

Homebrew tap for HarrierOps Azure packaging work.

This tap is the preview proving ground for the eventual stable Homebrew lane:

- preview formula: `ho-azure-preview`
- eventual stable/core target: `ho-azure`

The formula builds from tagged source releases published by
`https://github.com/HarrierSecurity/HarrierOps-Azure`.

## Install

```bash
brew install harriersecurity/ho-azure/ho-azure-preview
```

## Repository Layout

- `Formula/ho-azure-preview.rb`
  preview formula that tracks tagged `HarrierOps-Azure` releases
- `scripts/update_formula.py`
  updates the formula URL and SHA256 from release metadata
- `.github/workflows/validate-formula.yml`
  runs audit, source install, and formula test on pull requests
- `.github/workflows/update-preview-formula.yml`
  accepts release metadata, updates the formula, opens a PR, and enables
  auto-merge

## Automation Model

`HarrierOps-Azure` remains the source of truth for releases and tags.

When a new release is published in the main repo, the main repo dispatches the
version, source tarball URL, and SHA256 into this tap repo. The tap repo then:

1. updates `Formula/ho-azure-preview.rb`
2. opens a PR
3. runs validation on that PR
4. enables auto-merge once required checks are green

## Required Setup

Before cross-repo automation will work:

1. create the GitHub repo `HarrierSecurity/homebrew-ho-azure`
2. push this repo there
3. enable auto-merge for the repo
4. add branch protection on `main` so the validation workflow is required
5. add secret `HOMEBREW_TAP_REPO_TOKEN` to the main `HarrierOps-Azure` repo
   with permission to dispatch workflows in `HarrierSecurity/homebrew-ho-azure`

