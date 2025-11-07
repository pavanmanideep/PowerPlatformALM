# Deployment Guide

This guide explains how solutions are deployed using the GitLab CI/CD pipeline.

## Overview

The deployment pipeline follows a multi-stage approach:

```
Code Push → Validate → Build → Deploy DEV → Deploy TEST → Deploy PROD
```

## Pipeline Stages

### 1. Validate

**Triggered:** On every push to any branch (except main)

**Purpose:** Validates solution structure and format

**Actions:**
- Checks that Solutions directory exists
- Validates solution structure
- Verifies file formats

### 2. Build

**Triggered:** On every push to any branch

**Purpose:** Packages solutions for deployment

**Actions:**
- Packs solutions into ZIP format
- Creates deployment artifacts
- Stores artifacts for 1 week

### 3. Deploy to Development

**Triggered:** Manual trigger on develop or feature branches

**Purpose:** Deploy to development environment for testing

**Actions:**
- Authenticates to DEV environment
- Imports solution as unmanaged
- Publishes customizations

**When to use:** After making changes and wanting to test in DEV

### 4. Deploy to Test

**Triggered:** Manual trigger on main branch only

**Purpose:** Deploy to test/QA environment

**Actions:**
- Authenticates to TEST environment
- Imports solution
- Runs post-deployment validation

**When to use:** After merging to main, before production

### 5. Deploy to Production

**Triggered:** Manual trigger on main branch only, after TEST deployment

**Purpose:** Deploy to production environment

**Actions:**
- Authenticates to PROD environment
- Imports solution as managed (typically)
- Publishes customizations
- Creates deployment record

**When to use:** After successful testing in TEST environment

## Deployment Workflows

### Workflow 1: Feature Development

1. **Create feature branch:**
   ```bash
   git checkout -b feature/my-feature
   ```

2. **Make changes and commit:**
   ```bash
   # Export solution
   pac solution export --path Solutions/MySolution --name MySolution
   
   # Commit changes
   git add Solutions/MySolution
   git commit -m "Add new feature to MySolution"
   git push origin feature/my-feature
   ```

3. **Pipeline runs:**
   - Validate stage runs automatically
   - Build stage runs automatically

4. **Deploy to DEV (optional):**
   - Go to GitLab > CI/CD > Pipelines
   - Find your pipeline
   - Click "Play" button on "deploy-dev" job

5. **Test in DEV environment**

6. **Create Merge Request to develop branch**

7. **After merge, deploy to DEV from develop branch**

### Workflow 2: Release to Production

1. **Merge develop to main:**
   ```bash
   git checkout main
   git pull origin main
   git merge develop
   git push origin main
   ```

2. **Pipeline runs on main:**
   - Validate stage runs
   - Build stage runs

3. **Deploy to TEST:**
   - Go to GitLab > CI/CD > Pipelines
   - Find your pipeline on main branch
   - Click "Play" on "deploy-test" job

4. **Verify in TEST environment**

5. **Deploy to PROD:**
   - If TEST is successful
   - Click "Play" on "deploy-prod" job
   - Confirm deployment in modal

6. **Verify in PROD environment**

### Workflow 3: Hotfix

1. **Create hotfix branch from main:**
   ```bash
   git checkout main
   git checkout -b hotfix/critical-fix
   ```

2. **Make fix and commit:**
   ```bash
   # Make your changes
   git add .
   git commit -m "Fix critical issue"
   git push origin hotfix/critical-fix
   ```

3. **Create MR to main**

4. **After merge, follow Workflow 2 for deployment**

## Manual Deployment

If you need to deploy manually (outside pipeline):

### Using Power Platform CLI

```bash
# Authenticate (interactive authentication - will prompt for credentials)
pac auth create --url https://yourenv.crm.dynamics.com

# For automated/CI scenarios, use Service Principal:
# pac auth create --url https://yourenv.crm.dynamics.com --applicationId $CLIENT_ID --clientSecret $CLIENT_SECRET --tenant $TENANT_ID

# Import solution
pac solution import --path Solutions/MySolution.zip

# Or pack and import
pac solution pack --zipfile MySolution.zip --folder Solutions/MySolution
pac solution import --path MySolution.zip
```

### Using Power Platform Portal

1. Go to Power Platform Admin Center
2. Select environment
3. Solutions
4. Import
5. Choose solution file
6. Follow wizard

## Deployment Best Practices

### 1. Always Test in Lower Environments First

Never deploy directly to production without testing:
- DEV → TEST → PROD

### 2. Use Manual Triggers for Production

Production deployments should always be manual and reviewed

### 3. Verify After Each Deployment

- Check solution imported successfully
- Test key functionality
- Verify no breaking changes

### 4. Deploy During Maintenance Windows

For production deployments:
- Schedule during low-usage periods
- Notify users in advance
- Have rollback plan ready

### 5. Document Each Deployment

- Note what was deployed
- Record any issues
- Track solution versions

## Rollback Procedure

If a deployment causes issues:

### Immediate Actions

1. **For Development/Test:**
   - Re-deploy previous version
   - Or delete solution and re-import

2. **For Production:**
   - If managed solution: Remove and re-import previous version
   - If unmanaged: More complex, may need to revert specific components

### Prevention

- Always deploy as managed solution to production
- Keep backups of previous versions
- Test thoroughly in lower environments

## Monitoring Deployments

### Check Pipeline Status

- GitLab > CI/CD > Pipelines
- View logs for each job
- Check for errors or warnings

### Verify in Environment

After deployment:
1. Open Power Platform portal
2. Go to Solutions
3. Verify solution is listed with correct version
4. Test affected functionality

## Troubleshooting

### Pipeline Fails at Authentication

- Check GitLab CI/CD variables
- Verify Service Principal credentials
- Ensure Application User has access

### Solution Import Fails

- Check for missing dependencies
- Verify solution format is correct
- Review error messages in pipeline logs
- Check environment capacity

### Import Succeeds but Functionality Broken

- Review solution components
- Check for missing connections/credentials
- Verify environment configuration
- Test dependencies

## Support

For deployment issues:
1. Check pipeline logs in GitLab
2. Review this deployment guide
3. Consult Power Platform documentation
4. Contact repository administrators
