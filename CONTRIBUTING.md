# Contributing to Power Platform ALM

Thank you for contributing to this Power Platform ALM repository! This guide will help you understand how to work with this repository.

## Prerequisites

Before contributing, ensure you have:

1. **Power Platform CLI** installed
   - Download from: https://aka.ms/PowerPlatformCLI
   - Or install via: `dotnet tool install --global Microsoft.PowerApps.CLI.Tool`

2. **Git** installed and configured

3. **Access** to the Power Platform environments

4. **Service Principal** or user credentials for authentication

## Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Add or Update Solutions

Export your solution from Power Platform:

```bash
# Authenticate to your environment (interactive - will prompt for credentials)
pac auth create --url https://your-env.crm.dynamics.com

# Export solution in unpacked format
pac solution export --path Solutions/YourSolution --name YourSolutionName --managed false
```

### 3. Commit Your Changes

```bash
git add Solutions/YourSolution
git commit -m "Add/Update YourSolution: Brief description of changes"
```

### 4. Push and Create Merge Request

```bash
git push origin feature/your-feature-name
```

Then create a Merge Request in GitLab.

## Branch Strategy

- **main**: Production-ready code, deploys to PROD
- **develop**: Development code, deploys to DEV
- **feature/**: Feature branches for new development
- **hotfix/**: Emergency fixes for production issues

## Commit Message Guidelines

Use clear, descriptive commit messages:

- `Add [SolutionName]: Description`
- `Update [SolutionName]: Description`
- `Fix [SolutionName]: Description`
- `Remove [SolutionName]: Description`

## Solution Guidelines

### Naming Conventions

- Use a consistent prefix for all custom components (e.g., `myorg_`)
- Follow Power Platform naming best practices
- Use meaningful names for all components

### Solution Structure

- Store solutions in **unpacked format** (not ZIP files)
- Each solution should have its own directory under `Solutions/`
- Include a README.md in each solution directory

### Testing

- Test all changes in a development environment before committing
- Ensure no breaking changes to existing functionality
- Document any dependencies or prerequisites

## CI/CD Pipeline

The GitLab CI/CD pipeline will:

1. **Validate** the solution structure
2. **Build** the solution package
3. **Deploy** to appropriate environments based on branch

### Environment Variables

Configure these in GitLab CI/CD Settings:

- `DEV_ENVIRONMENT_URL`: Development environment URL
- `TEST_ENVIRONMENT_URL`: Test environment URL
- `PROD_ENVIRONMENT_URL`: Production environment URL
- `CLIENT_ID`: Service Principal Application ID
- `CLIENT_SECRET`: Service Principal Secret
- `TENANT_ID`: Azure AD Tenant ID

## Getting Help

If you have questions or need help:

1. Check the [Solutions README](Solutions/README.md)
2. Review the [main README](README.md)
3. Contact the repository maintainers

## Code Review

All changes must be reviewed before merging:

- Ensure code follows guidelines
- Check for potential breaking changes
- Verify documentation is updated
- Confirm tests pass in CI/CD pipeline
