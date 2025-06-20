# Development Workflow Instructions

You are working on the SparX Wallet Flutter project. Follow these critical workflow and process rules.

## Git and Branch Management

### Branch Creation and Naming

- **ALWAYS** create branches from `dev`, never from `main`
- **ALWAYS** include YouTrack ticket ID in branch names
- Use format: `{type}/EWM-{number}_{description}`
  - Features: `feature/EWM-511_typesafe_navigation`
  - Bugs: `fix/EWM-507_crash_on_startup`
  - Refactoring: `refactor/EWM-502_separated_column`
  - Releases: `release/EWM-492_1.5.0_update_screen`

### Commit Messages

- **MUST** follow conventional commits format: `<type>[optional scope]: <description>`
- **ALWAYS** include YouTrack ticket ID in scope: `feat(EWM-511): Add route navigation`
- Valid types: `feat`, `fix`, `BREAKING CHANGE`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`

### Merge Strategies

- **Regular task branches** (feature/, fix/, refactor/): Use "Squash and merge" into `dev`
- **Release branches**: Use regular "Merge" (not squash) into `main` to preserve commit history

## YouTrack Task Management

### Task Status Workflow

Follow this exact sequence:

1. **To Do** → **In Progress** (when starting work)
2. **In Progress** → **Review** (when creating PR)
3. **Review** → **Ready to Test** (after code review approval)
4. **Ready to Test** → **Testing** (QA starts testing)
5. **Testing** → **Verified** (QA completes testing)
6. **Verified** → **Released** (deployed to production)

### Task Development Process

1. Take YouTrack ticket, move to "In Progress", assign to yourself
2. Create branch from `dev` with proper naming
3. Implement changes with focused commits
4. Run `melos run check-all` before creating PR
5. Create PR with YouTrack ID in title and detailed description
6. Move task to "Review" status
7. Address review feedback, keep in "Review" until approved
8. Provide detailed testing instructions for QA
9. QA will handle testing and merge process

## Pull Request Requirements

### PR Title and Description

- Include YouTrack ticket ID in title
- Use the comprehensive PR template with all sections:
  - Description with bullet points
  - Solution with implementation details
  - Type of change checklist
  - Testing instructions
  - QA testing results section

## Testing Instructions for QA

When providing testing instructions, include:

- Step-by-step process to test functionality
- Test environment setup requirements
- Expected outcomes and success criteria
- Edge cases to verify
- Required test accounts or credentials
- For multi-branch tasks: information about all nested branches and PRs

## Critical Rules

- **NEVER** commit directly to `main` or `dev`
- **ALWAYS** update YouTrack status as work progresses
- **ALWAYS** ensure tests pass before creating PRs
- **ALWAYS** delete branches after merging
- **ALWAYS** sync regularly with `dev` to minimize conflicts
- **ALWAYS** provide comprehensive testing instructions

## Error Handling

If CI checks fail:

- Fix issues and push new commits
- Do not create new PRs - update existing ones
- GitHub Actions will automatically re-run checks

