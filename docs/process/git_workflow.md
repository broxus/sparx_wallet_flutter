# Git Workflow and Branching Strategy

This document outlines the Git branching strategy and workflow conventions used in the SparX Wallet Flutter project.

## Branch Types

The project follows a modified GitFlow model with the following branch types:

### Main Branches

1. **`main`** - Production code that has been released to users
   - Always in a deployable state
   - Protected from direct pushes
   - Changes come only through release branches via pull requests

2. **`dev`** - Integration branch for ongoing development
   - Features and fixes are merged here
   - Represents the current state of development
   - Should always be in a buildable state

### Supporting Branches

3. **`feature/`** - Feature development branches
   - Created from `dev`
   - Merged back to `dev` when feature is complete
   - Naming: `feature/EWM-XXX_feature-name` (e.g., `feature/EWM-511_typesafe_navigation`)

4. **`fix/`** - Bug fix branches
   - Created from `dev`
   - Merged back to `dev` when fix is complete
   - Naming: `fix/EWM-XXX_bug-description` (e.g., `fix/EWM-507`)

5. **`refactor/`** - Code refactoring branches
   - For code improvements without changing functionality
   - Naming: `refactor/EWM-XXX_component-name` (e.g., `refactor/EWM-502_separated-column`)

6. **`release/`** - Release preparation branches
   - Created from `dev` when preparing a new release
   - Merged to `main` when release is ready
   - Naming: `release/EWM-XXX_version_feature` (e.g., `release/EWM-492_1.4.1_update_screen`)

## Branch Naming Conventions

Every branch should be associated with one or more YouTrack tickets:

1. **Include ticket ID in branch name** - Always prefix branch names with the YouTrack ticket ID
   - Example: `feature/EWM-511_typesafe_navigation`

2. **Multi-task branches** - For branches that contain multiple features or fixes, include all relevant IDs
   - Example: `feature/EWM_511_510_428_502_449_420_450_448_447_380_515_test_branch`

3. **Include ticket ID in commit messages** - Reference the YouTrack ticket in all commits
   - Example: `feat(EWM-511): Add route data type checking`

## Git Operations

### Creating a New Branch

1. **Start from `dev`**

   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/EWM-511_typesafe_navigation
   ```

### Multi-Task Branches

For related tasks that need to be worked on together:

1. **Create a multi-task branch** with IDs of all tasks

   ```bash
   git checkout -b feature/EWM_511_510_428_502_449_420_multi_task_branch
   ```

2. **Merge individual task branches** into the multi-task branch

   ```bash
   git checkout feature/EWM_511_510_428_502_449_420_multi_task_branch
   git merge feature/EWM-511_typesafe_navigation
   ```

## Best Practices

1. **Keep branches short-lived** - Aim to complete and merge features within a few days

2. **Make small, focused commits** - Each commit should represent a logical unit of work

3. **Write descriptive commit messages** - Follow [conventional commits](./conventional_commits.md) format

4. **Update your branch regularly** - Merge or rebase from `dev` frequently

5. **Don't commit directly to `main` or `dev`** - Always use feature branches and PRs

6. **Delete branches after merging** - Keep the repository clean

7. **Ensure CI passes before merging** - All tests must pass before a PR can be merged

## Merge Strategies

### Regular Task Branches (feature/, fix/, refactor/)
- **Use "Squash and merge"** when merging into `dev`
- This maintains a clean, linear history in the `dev` branch
- Each feature/fix appears as a single commit with a descriptive message

### Release Branches
- **Use regular "Merge" (not squash)** when merging release branches into `main`
- This preserves the complete commit history from the release branch
- Maintains traceability of all changes included in the release

## Example Workflows

### Starting a New Feature

```bash
git checkout dev
git pull
git checkout -b feature/EWM-511_typesafe_navigation
# Make changes...
git commit -m "feat(EWM-511): Add route data type checking"
git push origin feature/EWM-511_typesafe_navigation
# Create PR to dev
```

### Fixing a Bug

```bash
git checkout dev
git pull
git checkout -b fix/EWM-507_crash_on_startup
# Fix the bug...
git commit -m "fix(EWM-507): Resolve crash on startup due to null pointer"
git push origin fix/EWM-507_crash_on_startup
# Create PR to dev
```

### Syncing with Latest Changes

```bash
git checkout feature/your-branch
git fetch origin
git merge origin/dev
# Resolve any conflicts
git commit -m "merge: Sync with latest dev changes"
git push origin feature/your-branch
```

