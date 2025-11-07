# Helper Scripts

This directory contains helper scripts for working with Power Platform solutions.

## Available Scripts

### export-solution.sh

Exports a Power Platform solution from an environment in unpacked format.

**Usage:**
```bash
./scripts/export-solution.sh <solution-name> <environment-url>
```

**Example:**
```bash
./scripts/export-solution.sh MySolution https://mydev.crm.dynamics.com
```

**Prerequisites:**
- Power Platform CLI installed
- Authentication access to the environment

### Making Scripts Executable

On Linux/Mac:
```bash
chmod +x scripts/*.sh
```

On Windows, use Git Bash or WSL to run the scripts.

## Custom Scripts

You can add your own helper scripts to this directory for:
- Solution validation
- Bulk operations
- Custom deployment workflows
- Testing automation

## Notes

- These scripts are helpers for local development
- The GitLab CI/CD pipeline handles automated deployments
- Always test scripts in a development environment first
