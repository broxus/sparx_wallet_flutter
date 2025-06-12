# Task Workflow and YouTrack Integration

This document outlines the task management workflow using YouTrack and the development process for individual tasks.

## YouTrack Task Status Workflow

Tasks in YouTrack follow a defined workflow with the following statuses:

1. **To Do** - Task is created but work has not yet begun
   - Initial status for all new tasks
   - Tasks should be properly described with acceptance criteria

2. **In Progress** - Developer is actively working on the task
   - Move to this status when starting development
   - The task should be assigned to the developer

3. **Review** - Code changes are complete and waiting for code review
   - PR has been created and submitted for review
   - Reviewers have been assigned

4. **Ready to Test** - Code has been reviewed and approved
   - All review feedback has been addressed
   - Testing instructions have been provided
   - Waiting for QA to begin testing

5. **Testing** - QA is actively testing the changes
   - QA has started the verification process
   - Developer should be available to answer questions

6. **Verified** - QA has verified the changes, but they are not yet deployed
   - Changes have passed all test cases
   - Ready to be included in a release

7. **Released** - Changes have been deployed to production
   - Part of a released version
   - Available to users

8. **Reopened** - Issues found after verification or release
   - Task needs additional work
   - Should be moved back to In Progress when work resumes

## Status Transitions During Development

During a typical development cycle, a task will progress through statuses as follows:

1. Developer takes a task and moves it from **To Do** → **In Progress**
2. When the PR is created, developer moves it from **In Progress** → **Review**
3. After addressing review feedback, developer moves it from **Review** → **Ready to Test**
4. QA takes the task and moves it from **Ready to Test** → **Testing**
5. After successful testing, QA moves it from **Testing** → **Verified**
6. When the changes are included in a release, the task moves from **Verified** → **Released**

If issues are found during any stage, the task may be moved to **Reopened** and then back to **In Progress** to address the issues.

## Task Development Workflow

### Starting a New Task

1. **Take YouTrack ticket** - All work should be associated with a task in YouTrack
   - Get the ticket ID (e.g., EWM-511)
   - Ensure the task is in "To Do" status with clear requirements

2. **Move task to "In Progress"** and assign it to yourself

3. **Create a branch** from `dev` (see [Git Workflow](./git_workflow.md) for details)

4. **Implement your changes**, making small, focused commits
   - Follow [conventional commits](./conventional_commits.md) format
   - Example: `feat(EWM-511): Add typesafe route navigation`

### Completing a Task

1. **Ensure tests pass** and code meets quality standards

   ```bash
   melos run check-all
   ```

2. **Push your branch** and create a pull request
   - Include the YouTrack ticket ID in the PR title
   - Create a detailed PR description (see PR Description Template below)
   - Request reviews from appropriate team members
   - Move the YouTrack task status to "Review"

3. **GitHub Actions will automatically run CI checks**
   - **Semantic PR Check**: Validates that PR title follows conventional commits format
   - **Build and Test**: Runs `melos run check-all` (format check, lint, tests, code generation)
   - All checks must pass before the PR can be merged
   - If any checks fail, developer should fix issues and push new commits

4. **Provide testing instructions for QA**
   - Add a "Testing Instructions" comment in the YouTrack task
   - For multi-branch tasks, include information about all nested branches and PR's
   - Document the following to simplify QA work:
     - Steps to reproduce/test the feature or fix
     - Test environment setup requirements
     - Any specific edge cases that should be tested

5. **Address review feedback** with additional commits or changes
   - Keep the task in "Review" status until all feedback is addressed
   - Push new commits to automatically re-trigger GitHub Actions checks

6. **Pass PR to QA specialists** after code review approval for manual testing
   - Move the YouTrack task status to "Ready to Test"
   - QA will move the task to "Testing" when they begin testing

7. **QA testing and issue resolution**
   - QA will conduct manual testing and may find bugs or conflicts
   - If bugs are found, developer should fix them with additional commits
   - If conflicts arise after testing, developer should resolve them promptly

8. **QA initiates deployment for testing** (if needed)
   - QA can manually trigger the **Deploy app** GitHub Action workflow from the Actions tab
   - **Deploy target** parameter options:
     - `fad` - Deploy to Firebase App Distribution for both iOS and Android
     - `ios_fad` - Deploy only iOS build to Firebase App Distribution
     - `android_fad` - Deploy only Android build to Firebase App Distribution
     - `store`, `ios_store`, `android_store` - Production store deployment (restricted to `main` branch only)
   - **Build mode** parameter options:
     - `release` - Optimized production build (recommended for testing)
     - `debug` - Development build with debugging enabled (recommended if to debug traffic or use devtools)
   - **Flavor** parameter options:
     - `development` - Development environment configuration
     - `staging` - Staging environment configuration  
     - `production` - Production environment configuration (required for store deployments)
   - Workflow will automatically validate parameter combinations and branch restrictions

9. **Final merge by QA**
   - QA will merge the branch to `dev` after successful testing
   - QA moves the YouTrack task to "Verified" status
   - Use "Squash and merge" to maintain a clean history

## Pull Request Description Template

A good PR description helps reviewers understand the context, implementation details, and reasoning behind your changes. Use the following template for your PR descriptions:

```markdown
feat(EWM-XXX): Short Description of Feature

## Description
* Brief overview of what this PR implements or fixes
* Bullet points for key functionality changes
* Context or background information if needed

copilot:all

## Solution:
* Detailed explanation of implementation approach
* Key components/files created or modified
* Architecture decisions and their rationale
* Any technical challenges and how they were addressed
* Dependencies added or modified

## Type of Change
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 🛠️ Bug fix (non-breaking change which fixes an issue)
- [ ] ❌ Breaking change (fix or feature that would cause existing functionality to change)
- [ ] 🧹 Code refactor
- [ ] ✅ Build configuration change
- [ ] 📝 Documentation
- [ ] 🗑️ Chore
```

### Example PR Description

```markdown
feat(EWM-492): App Version Update System

## Description
* Implement version update notification system to prompt users when new app versions are available
* Support blocking updates (users must update) and warning updates (users can dismiss)
* Display release notes for new versions

copilot:all

## Solution:
* Created presets config reader service for fetching configuration from remote/cache/local sources
* Added two key JSON config files:
  * `update_rules.json` - Defines blocking version, warning version, and warning display behavior
  * `release_notes.json` - Contains version-specific release notes and availability status
* Developed version comparison logic with semantic versioning support
* Enhanced app storage service with update statistics tracking (warning count, last shown time)
* Added update notification screen with blur effect
* Integrated with platform stores via URL launcher and in-app update for Android

## Type of Change
- [x] ✨ New feature (non-breaking change which adds functionality)
- [ ] 🛠️ Bug fix (non-breaking change which fixes an issue)
- [ ] ❌ Breaking change (fix or feature that would cause existing functionality to change)
- [ ] 🧹 Code refactor
- [x] ✅ Build configuration change
- [x] 📝 Documentation
- [ ] 🗑️ Chore
```

## Branch Association with Tasks

1. **Link branches in YouTrack** - Update the YouTrack ticket with links to the corresponding branch/PR

2. **Reference tasks in commits** - Always include the YouTrack ticket ID in commit messages

3. **Multi-task coordination** - For multi-task branches, ensure all related tickets are properly linked and updated
