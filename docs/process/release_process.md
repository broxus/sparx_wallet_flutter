# Release Process and Deployment

This document outlines the release preparation and deployment procedures for the SparX Wallet Flutter project.

## Release Process Overview

The release process involves creating a release branch, testing, and deploying to production stores through a series of automated and manual steps.

## Release Workflow

### 1. Create Release Branch

Create a release branch from `dev` when ready to prepare a new release:

```bash
git checkout dev
git pull origin dev
git checkout -b release/EWM-XXX_version_feature
```

**Naming Convention:** `release/EWM_{task}_{version}_{desc}`

- Example: `release/EWM-492_1.5.0_update_screen`

### 2. Perform Release-Specific Tasks

**Version Management:**

- Update version numbers in `pubspec.yaml`
- Make any necessary release-specific fixes
- Verify that all "Verified" tasks included in the release are properly documented

**Quality Assurance:**

- Ensure all included features have been thoroughly tested
- Verify that all YouTrack tasks are in "Verified" status
- Review and update release notes

### 3. Create Release Pull Request

Create a pull request to merge the release branch into `main`:

- Include version information
- Add a concise description of changes (can use git diff with LLM to summarize)
- Ensure that only intended changes are included in the PR
- Request reviews from appropriate team members

### 4. Pre-Production Testing with Firebase App Distribution

**Deploy to FAD using GitHub Actions:**

- QA manually triggers the **Deploy app** GitHub Action workflow from the Actions tab
- **Deploy target** parameter: `fad`, `ios_fad`, or `android_fad` for testing builds
- **Build mode** parameter: `release` (recommended for production-like testing)
- **Flavor** parameter: `staging` or `production` depending on testing requirements
- Workflow will validate that all parameters are compatible with release testing

**Regression Testing by QA:**

- QA team performs comprehensive regression testing on the FAD build
- Test all critical user flows and new features
- Verify compatibility across target devices and OS versions
- Execute full test suite to ensure no regressions were introduced

**Issue Resolution (if needed):**

- If issues are found during regression testing:
  - Fix them directly in the release branch
  - Create additional commits for fixes
  - Update the PR with fix details
  - Re-trigger the **Deploy app** GitHub Action workflow to rebuild and redeploy to FAD
  - Repeat regression testing until all issues are resolved

### 5. Finalize Release

**Merge to Main:**

- Once QA regression testing is complete and approved, merge the release PR to `main`
- Ensure all QA checks have passed
- Use regular "Merge" (not squash) to preserve the complete commit history from the release branch
- Delete the release branch after merging

**Tag the Release:**

```bash
git checkout main
git pull
git tag -a v1.5.0 -m "Release v1.5.0"
git push origin v1.5.0
```

### 6. Production Deployment

**Deploy to App Stores using GitHub Actions:**

- Deploy to App Store and Google Play from the `main` branch only
- QA team manually triggers the **Deploy app** GitHub Action workflow from the `main` branch
- Select deploy target: `store` for both platforms or `ios_store`/`android_store` for specific platforms
- Must use `production` flavor and `release` build mode (enforced by GitHub Actions)
- GitHub Actions will validate branch and flavor restrictions before deployment

**Store Build Smoke Testing:**

- QA performs final smoke testing on the store build after deployment
- Verify that the production build functions correctly in the store environment
- Test core functionality to ensure the deployment was successful
- Confirm app store metadata and descriptions are correct

**Post-Deployment Tasks:**

- Once smoke testing on store build is complete, move all included tasks from "Verified" to "Released" status in YouTrack
- Monitor app store review process and user feedback
- Prepare hotfix procedures if critical issues are discovered

## GitHub Actions Deployment Parameters

### Deploy Target Options

- `fad` - Deploy to Firebase App Distribution for both iOS and Android
- `ios_fad` - Deploy only iOS build to Firebase App Distribution
- `android_fad` - Deploy only Android build to Firebase App Distribution
- `store` - Deploy to both App Store and Google Play Store
- `ios_store` - Deploy only to App Store
- `android_store` - Deploy only to Google Play Store

### Build Mode Options

- `release` - Optimized production build (recommended for all deployments)
- `debug` - Development build with debugging enabled (for testing only)

### Flavor Options

- `development` - Development environment configuration
- `staging` - Staging environment configuration
- `production` - Production environment configuration (required for store deployments)

### Restrictions and Validations

- Store deployments (`store`, `ios_store`, `android_store`) are restricted to `main` branch only
- Store deployments must use `production` flavor and `release` build mode
- GitHub Actions automatically validates parameter combinations before deployment
- Branch protection rules prevent unauthorized deployments
