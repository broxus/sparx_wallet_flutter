# SparX Wallet Flutter

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![app](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml/badge.svg)](https://github.com/broxus/ever_wallet_flutter_new/actions/workflows/main.yaml)

## Project Description

SparX Wallet is your universal tool for managing crypto assets across TVM networks such as TON and others. With the app, you can easily manage your seed phrases, private and public keys, as well as your wallets.

With the wallet you can:
⁃ Import existing keys or create new ones.
⁃ Create and use multisignature wallet.
⁃ Manage the permissions you provide to dApps (DEXes, bridges, etc.).
⁃ Protect your data with encrypted local key storage.

Contact us: <https://broxus.com/>

Telegram support chat: <https://t.me/broxus_chat>

## Project Architecture

The application uses a hybrid architecture:

- **Elementary MVVM** for new features (recommended approach)
- **BLoC pattern** for legacy code

For detailed architecture information, see our documentation:

### Core Architecture & Development

- **[Architecture](./docs/architecture.md)** - Clean architecture principles, Elementary MVVM pattern, data/domain/presentation layers, and component design patterns
- **[Project Structure](./docs/project_structure.md)** - High-level codebase organization, directory structure, feature patterns (Elementary vs. BLoC), and module hierarchy
- **[Type-safe Navigation](./docs/type_safe_navigation.md)** - Compass navigation system with route data classes, guards, and type-safe routing patterns
- **[Theme System](./docs/theme_system.md)** - Comprehensive theming system, design tokens, color palette, typography, component library, and styling best practices
- **[Testing Guide](./docs/testing.md)** - Testing strategies, unit/widget/integration tests, mocking patterns, and testing Elementary architecture

### Development Process & Workflow

- **[Localization](./docs/localization.md)** - Internationalization setup, adding new strings/languages, and translation workflow using easy_localization
- **[Secret Management](./docs/secret_management.md)** - Handling encrypted secrets, certificates, provisioning profiles, and CI/CD credential management

### Development Process Documentation

The `docs/process/` directory contains detailed workflow documentation:

- **[README](./docs/process/README.md)** - High-level overview of development workflow, branch strategy, and automated processes
- **[Git Workflow](./docs/process/git_workflow.md)** - Branching strategy, naming conventions, merge strategies, and Git best practices
- **[Task Workflow](./docs/process/task_workflow.md)** - YouTrack integration, status transitions, PR templates, and QA collaboration
- **[Release Process](./docs/process/release_process.md)** - Release preparation, deployment procedures, GitHub Actions usage, and store deployment
- **[Conventional Commits](./docs/process/conventional_commits.md)** - Commit message format and standards for semantic versioning

---

## Getting Started 🚀

Install melos:

```sh
dart pub global activate melos
```

Using [melos](https://melos.invertase.dev/) makes it very easy to work with the project, so enjoy.

Bootstrap packages recursively:

```sh
melos bs
```

## Codegen 🦾

This thing will run all code generators for all packages:

```
melos run codegen
```

## Codegen: localization 🌐

This thing will run localization code generator for all packages:

```
melos run codegen:locale
```

## Code format checking and analyzer 🦠

```
melos run check-format
melos run analyze
```

## Clean up 🧹

To clean up all packages just run:

```
melos clean
```

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
melos test
```

Also you can run dart, flutter and integration tests separately:

```sh
melos test:dart
melos test:flutter
melos test:integration
```

## Pre-commit preparation 🦠🧪🤏

To run code format check, analyzer and all tests use the following command:

```sh
melos check-all
```

## Build storybook 📚

To build storybook:

```sh
melos build:storybook
```

## Flavors 👃

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*App works on iOS and Android. It should run on macOS, Linux and Windows, but we have no tests nor UI kit for desktop platforms._

## Versioning the app 🔢

### App version #️⃣

App version is defined in `pubspec.yaml` file. To bump the version use the following command:

```sh
# For development releases:
$ melos version -a --yes --prerelease

# For production releases:
$ melos version -a --yes --graduate
```

You can use version workflow in GitHub actions to bump the version automatically. This workflow will create a new branch and PR (because push to main is prohibited) with the new version. Don't forget to merge the PR to main! Note: you should use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) to make it work.

### App build number #️⃣

App build number is defined in `pubspec.yaml` file. However, there is a `tools/get_build_number.dart` tool that generates the build number by incrementing it transactionally in Firebase Realtime Database. So, you don't need to worry about the build number, it's always unique and increases monotonously. Every time you build the app, the build number will be incremented.

## Deploy 🚀

We prefer to deploy the app using GitHub Actions, but you can also deploy it from your local machine.

All deployment scripts are gathering changelog from git commits and adding it to the release notes. Note: google play limits the release notes, so don't be surprised that it is simplified and shortened.

### Deploy using GitHub Actions

We already have a workflow for deploying main app to Firebase App Distribution, TestFlight and Google Play. It's called `Deploy app`.

Deployment to fab is triggered when the `test` branch is updated, or when manually launched from any branch except main.
Deployment to store is triggered when manually launched from the `main` branch.

Deployment to FAD is triggered when the `dev` branch is updated.  

Manually running the deploy `melos run deploy_fad` from any branch **except** `main`.  
Running `melos run deploy_ios` deploys iOS to FAD.
Running `melos run deploy_android` deploys Android to FAD.

Deployment to store is triggered when manually launched from the `main` branch.

#### Available options for deploying in workflow

- **ios_fad** - launches iOS deploy to FAD.
- **ios_store** - launches iOS deploy to Test Flight.  
- **android_fad** - launches Android deploy to FAD.  
- **android_store** - launches Android deploy to Google Play.
- **fad** - launches iOS and Android deploy to FAD.  
- **store** - launches iOS and Android deploy to Test Flight and Google Play.  

We also have a workflow for deploying storybook to GitHub Pages. It's called `storybook-gh-pages-deploy` and it's triggered by pushing to the main branch or manually from any branch.

### Deploy from local machine

For deployment from a local machine, melos is used.

- **build_android_store** - build Android `aab` from any branch
- **deploy_fad_ios** - build and send iOS `ipa` from any branch
- **deploy_fad_android** - build and send Android `apk` from any branch
- **deploy_fad** - build and send Android `apk` and iOS `ipa` from any branch
- **deploy_store** - build and send Android `aab` and iOS `ipa` from the main branch

The `melos deploy_store*` commands only work from the `main` branch, so as not to accidentally upload unnecessary code to production.  

The `melos build_*` commands work from any branch - in case of manual build.  
Unlike `deploy_store*` commands, randomly running `build_*` will only build aab and/or ipa locally and will not push anything extra or untested to the store.

```sh
# To deploy to Firebase App Distribution just run the following command:
$ melos build:deploy_fad

# To deploy to TestFlight and Google Play closed testing just run the following command:
$ melos build:deploy_store
```

Each of these commands will increment the build number before building the app.

**Warning: To use Sentry, don't forget to pass the dsn via dart-define.**

Example:

```markdown
melos build:deploy_fad -- --dart-define=SENTRY_DSN="your_dsn"
```

## Coverage 📊

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Crash analytics

[Sentry](https://sentry.io) is used to intercept global errors and crash analytics.

Sentry does not run in the development build type.

Dsn is passed through dart-define using the SENTRY_DSN environment variable.

Examples:

```markdown
melos build:deploy_fad -- --dart-define=SENTRY_DSN="your_dsn"
```

```markdown
flutter run --dart-define=SENTRY_DSN="your_sentry_dsn_value"
```

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
