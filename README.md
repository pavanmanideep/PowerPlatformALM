# Power Platform ALM Repository

This repository is set up for managing Power Platform solutions with Application Lifecycle Management (ALM) using GitLab CI/CD.

## Overview

This repository provides a structured approach to:
- Version control Power Platform solutions
- Automate deployment across environments
- Enable collaborative development
- Track changes and maintain history

## Repository Structure

```
PowerPlatformALM/
├── .gitlab-ci.yml          # GitLab CI/CD pipeline configuration
├── .gitignore              # Git ignore patterns
├── README.md               # This file
├── CONTRIBUTING.md         # Contribution guidelines
└── Solutions/              # Power Platform solutions directory
    ├── README.md           # Solutions documentation
    └── ExampleSolution/    # Example solution placeholder
```

## Getting Started

### Prerequisites

1. **Power Platform CLI**: Download and install from [Microsoft Docs](https://aka.ms/PowerPlatformCLI)
2. **Git**: For version control
3. **Power Platform Access**: Appropriate permissions in your environments
4. **GitLab Account**: With access to this repository

### Initial Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd PowerPlatformALM
   ```

2. Configure GitLab CI/CD variables:
   - Navigate to Settings > CI/CD > Variables
   - Add the following variables:
     - `DEV_ENVIRONMENT_URL`: Your development environment URL
     - `TEST_ENVIRONMENT_URL`: Your test environment URL
     - `PROD_ENVIRONMENT_URL`: Your production environment URL
     - `CLIENT_ID`: Service Principal Application ID
     - `CLIENT_SECRET`: Service Principal Secret (mark as protected)
     - `TENANT_ID`: Azure AD Tenant ID

### Adding Solutions

#### Method 1: Export from Power Platform

1. Authenticate to your environment:
   ```bash
   pac auth create --url https://your-env.crm.dynamics.com
   ```

2. Export your solution:
   ```bash
   pac solution export --path Solutions/MySolution --name MySolutionName --managed false
   ```

3. Commit and push:
   ```bash
   git add Solutions/MySolution
   git commit -m "Add MySolution"
   git push
   ```

#### Method 2: Manual Export

1. Export solution from Power Platform portal as unmanaged
2. Unpack using Power Platform CLI or extract files
3. Place in `Solutions/` directory
4. Commit and push to repository

## CI/CD Pipeline

The GitLab CI/CD pipeline automates solution deployment:

### Pipeline Stages

1. **Validate**: Checks solution structure and format
2. **Build**: Packages solutions for deployment
3. **Deploy-Dev**: Deploys to development environment (manual trigger)
4. **Deploy-Test**: Deploys to test environment (manual trigger, main branch only)
5. **Deploy-Prod**: Deploys to production environment (manual trigger, main branch only)

### Triggering Deployments

- Push to `develop` branch: Enables DEV deployment
- Push to `main` branch: Enables TEST and PROD deployments
- All deployments require manual approval via GitLab UI

### Pipeline Configuration

The pipeline is defined in `.gitlab-ci.yml`. Customize it based on your:
- Environment setup
- Solution naming conventions
- Deployment requirements
- Approval workflows

## Branching Strategy

- **main**: Production-ready code
- **develop**: Development and integration branch
- **feature/**: Feature development branches
- **hotfix/**: Emergency production fixes

## Best Practices

1. **Always use unpacked solution format** for better version control
2. **Test in development environment** before merging to main
3. **Use meaningful commit messages** describing changes
4. **Review changes** before deployment to production
5. **Document dependencies** between solutions
6. **Follow naming conventions** for all Power Platform components

## Environment Setup

### Service Principal Configuration

For automated deployments, create a Service Principal (App Registration) in Azure AD:

1. Register an app in Azure AD
2. Grant Power Platform access permissions
3. Add as an Application User in Power Platform environments
4. Store credentials in GitLab CI/CD variables

### Power Platform CLI Authentication

The pipeline uses the following authentication approach:

```bash
pac auth create --environment $ENVIRONMENT_URL \
  --applicationId $CLIENT_ID \
  --clientSecret $CLIENT_SECRET \
  --tenant $TENANT_ID
```

## Troubleshooting

### Common Issues

**Pipeline fails at authentication**
- Verify Service Principal credentials in GitLab variables
- Check that Service Principal has access to environments

**Solution import fails**
- Ensure solution dependencies are met
- Check environment has required connectors/features
- Verify solution version compatibility

**Merge conflicts**
- Use Power Platform CLI to re-export fresh version
- Resolve conflicts in solution XML files carefully

## Documentation

- [Solutions Documentation](Solutions/README.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Power Platform CLI Documentation](https://docs.microsoft.com/power-platform/developer/cli/introduction)
- [GitLab CI/CD Documentation](https://docs.gitlab.com/ee/ci/)

## Support

For questions or issues:
1. Check documentation in this repository
2. Review Power Platform documentation
3. Contact repository administrators

## License

[Specify your license here]

## Contributors

[List contributors or link to CONTRIBUTORS.md]