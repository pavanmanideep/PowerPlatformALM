# Setup Guide

This guide walks you through setting up the Power Platform ALM repository for the first time.

## Prerequisites

### 1. Install Required Tools

- **Power Platform CLI**: [Download here](https://aka.ms/PowerPlatformCLI)
- **Git**: [Download here](https://git-scm.com/downloads)
- **GitLab Account**: With appropriate access

### 2. Power Platform Requirements

- Access to Power Platform environments (Dev, Test, Prod)
- Permissions to export/import solutions
- System Administrator or System Customizer role

## Initial Setup Steps

### Step 1: Create Service Principal

1. **Register an Application in Azure AD:**
   - Go to Azure Portal > Azure Active Directory > App Registrations
   - Click "New registration"
   - Name: "PowerPlatformALM-ServicePrincipal"
   - Click "Register"

2. **Create Client Secret:**
   - Go to Certificates & secrets
   - Click "New client secret"
   - Add description and expiry
   - **Copy the secret value** (you won't see it again!)

3. **Note the Application Details:**
   - Application (client) ID
   - Directory (tenant) ID
   - Client secret value

### Step 2: Grant Power Platform Access

1. **Add Application User to Each Environment:**
   - Go to Power Platform Admin Center
   - Select environment
   - Settings > Users + permissions > Application users
   - New app user
   - Select your registered app
   - Assign Security Role (e.g., System Administrator)
   - Repeat for all environments

### Step 3: Configure GitLab CI/CD Variables

1. **Navigate to GitLab Repository:**
   - Go to Settings > CI/CD > Variables
   - Click "Expand" on Variables section

2. **Add the Following Variables:**

   | Variable Name | Value | Protected | Masked |
   |--------------|-------|-----------|--------|
   | `CLIENT_ID` | Your Application ID | ✓ | ✓ |
   | `CLIENT_SECRET` | Your Client Secret | ✓ | ✓ |
   | `TENANT_ID` | Your Tenant ID | ✓ | ✓ |
   | `DEV_ENVIRONMENT_URL` | https://yourdev.crm.dynamics.com | ✓ | ✗ |
   | `TEST_ENVIRONMENT_URL` | https://yourtest.crm.dynamics.com | ✓ | ✗ |
   | `PROD_ENVIRONMENT_URL` | https://yourprod.crm.dynamics.com | ✓ | ✗ |

   **Note:** Mark as "Protected" to limit to protected branches only

### Step 4: Configure Local Environment (Optional)

For local development:

1. Copy environment template:
   ```bash
   cp config/environments.template.json config/environments.json
   ```

2. Edit `config/environments.json` with your environment details

3. **Never commit** `config/environments.json` (it's in .gitignore)

### Step 5: Test the Pipeline

1. Make a small change to trigger pipeline:
   ```bash
   echo "# Test" >> Solutions/README.md
   git add Solutions/README.md
   git commit -m "Test pipeline setup"
   git push
   ```

2. Check GitLab CI/CD > Pipelines to verify it runs

## Troubleshooting

### Authentication Issues

**Problem:** Pipeline fails at authentication step

**Solutions:**
- Verify Service Principal credentials in GitLab variables
- Check that Application User is added to all environments
- Ensure Security Roles are assigned
- Verify tenant ID is correct

### Permission Errors

**Problem:** "Insufficient privileges" errors

**Solutions:**
- Check Application User security roles
- Ensure System Administrator or System Customizer role
- Verify environment access permissions

### CLI Not Found

**Problem:** `pac: command not found`

**Solutions:**
- Install Power Platform CLI
- Ensure PATH is configured correctly
- Restart terminal after installation

### Solution Export Fails

**Problem:** Cannot export solution

**Solutions:**
- Verify solution name is correct
- Check solution exists in environment
- Ensure you have export permissions
- Try exporting from Power Platform portal first

## Next Steps

After setup is complete:

1. Read the [Contributing Guide](../CONTRIBUTING.md)
2. Review [Deployment Guide](DEPLOYMENT.md)
3. Export your first solution
4. Test the deployment pipeline

## Support

If you encounter issues:
1. Check troubleshooting section above
2. Review GitLab pipeline logs
3. Consult Power Platform documentation
4. Contact repository administrators
