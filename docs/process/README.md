# Development Workflow Overview

This document provides a high-level overview of the development workflow used in the SparX Wallet Flutter project. It serves as an entry point to more detailed documentation for specific aspects of the development process.

## Quick Reference

For detailed information on specific aspects of the development workflow, refer to these documents:

- **[Git Workflow](./git_workflow.md)** - Branching strategy, Git operations, and best practices
- **[Task Workflow](./task_workflow.md)** - YouTrack integration and development process
- **[Release Process](./release_process.md)** - Release preparation and deployment procedures
- **[Conventional Commits](./conventional_commits.md)** - Commit message format and standards

## Development Process Summary

### 1. Task Management

All development work is tracked through YouTrack tickets with defined status transitions:
**To Do** → **In Progress** → **Review** → **Ready to Test** → **Testing** → **Verified** → **Released**

### 2. Branch Strategy

The project uses a modified GitFlow model:

- **`main`** - Production releases
- **`dev`** - Integration branch for ongoing development
- **`feature/EWM-XXX`** - Feature development branches
- **`fix/EWM-XXX`** - Bug fix branches
- **`release/EWM-XXX`** - Release preparation branches

### 3. Development Cycle

1. **Start**: Take YouTrack ticket, create branch from `dev`
2. **Develop**: Implement changes with focused commits
3. **Review**: Create PR, pass CI checks, get code review
4. **Test**: QA testing and verification
5. **Deploy**: Merge to `dev`, include in releases

### 4. Release Cycle

1. **Prepare**: Create release branch from `dev`
2. **Test**: Deploy to Firebase App Distribution for QA testing
3. **Release**: Merge to `main`, tag release, deploy to stores
4. **Sync**: Merge changes back to `dev`

## Automated Workflows

### GitHub Actions

- **Semantic PR Check**: Validates conventional commit format
- **Build and Test**: Runs full test suite and quality checks
- **Deploy App**: Automated deployment to Firebase App Distribution and app stores

### Quality Gates

- All tests must pass before merging
- Code review approval required
- QA verification before release
- Automated CI/CD pipeline validation

## Getting Started

1. **Set up your environment** following the project README
2. **Take a YouTrack ticket** and move it to "In Progress"
3. **Create a feature branch** from `dev`
4. **Follow the development workflow** outlined in [Task Workflow](./task_workflow.md)
5. **Use proper Git practices** as described in [Git Workflow](./git_workflow.md)

For detailed step-by-step instructions, refer to the specific workflow documents linked above.
