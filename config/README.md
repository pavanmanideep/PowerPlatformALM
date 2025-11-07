# Configuration Files

This directory contains configuration templates and files for managing Power Platform deployments.

## Files

### environments.template.json

Template for environment configuration. Copy this file to `environments.json` (which is gitignored) and fill in your environment details.

**DO NOT** commit `environments.json` with actual credentials to the repository. Use GitLab CI/CD variables for sensitive information.

## Usage

1. Copy the template:
   ```bash
   cp config/environments.template.json config/environments.json
   ```

2. Update with your environment URLs and information

3. Use for local development and testing

4. For CI/CD, configure variables in GitLab instead

## Security Notes

- Never commit credentials to version control
- Use GitLab CI/CD Variables for all sensitive data
- Mark sensitive variables as "Protected" and "Masked"
- Rotate credentials regularly
