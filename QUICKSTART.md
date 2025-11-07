# Quick Start Guide

Get started with Power Platform ALM in 5 minutes!

## Step 1: Prerequisites ✅

Install these tools:
- [Power Platform CLI](https://aka.ms/PowerPlatformCLI)
- [Git](https://git-scm.com/downloads)

## Step 2: Clone Repository 📥

```bash
git clone <your-repo-url>
cd PowerPlatformALM
```

## Step 3: Configure GitLab CI/CD Variables 🔧

Go to: **Settings > CI/CD > Variables**

Add these variables:

| Variable | Example Value | Protected | Masked |
|----------|--------------|-----------|--------|
| `CLIENT_ID` | 12345678-1234-... | ✓ | ✓ |
| `CLIENT_SECRET` | abc123... | ✓ | ✓ |
| `TENANT_ID` | 87654321-4321-... | ✓ | ✓ |
| `DEV_ENVIRONMENT_URL` | https://yourdev.crm.dynamics.com | ✓ | ✗ |
| `TEST_ENVIRONMENT_URL` | https://yourtest.crm.dynamics.com | ✓ | ✗ |
| `PROD_ENVIRONMENT_URL` | https://yourprod.crm.dynamics.com | ✓ | ✗ |

> **Need Service Principal?** See [SETUP.md](docs/SETUP.md) for instructions.

## Step 4: Add Your First Solution 🎯

### Option A: Using the Export Script (Recommended)

```bash
# Make script executable (Linux/Mac)
chmod +x scripts/export-solution.sh

# Export your solution
./scripts/export-solution.sh YourSolutionName https://yourdev.crm.dynamics.com
```

### Option B: Using Power Platform CLI

```bash
# Authenticate (interactive - will prompt for credentials)
pac auth create --url https://yourdev.crm.dynamics.com

# Export solution
pac solution export --path Solutions/YourSolution --name YourSolutionName --managed false
```

### Option C: Manual Export

1. Export solution from Power Platform portal
2. Extract files to `Solutions/YourSolution/`

## Step 5: Commit and Push 🚀

```bash
git add Solutions/YourSolution
git commit -m "Add YourSolution"
git push origin main
```

## Step 6: Deploy 🎉

1. Go to **GitLab > CI/CD > Pipelines**
2. Find your pipeline
3. Click **Play ▶️** on `deploy-dev` to deploy to development

**That's it!** Your solution is now under version control and deployed via CI/CD!

## Next Steps 📚

- Read the [full README](README.md)
- Review [Setup Guide](docs/SETUP.md) for detailed configuration
- Check [Deployment Guide](docs/DEPLOYMENT.md) for workflows
- See [Contributing Guide](CONTRIBUTING.md) for best practices

## Common Commands 💡

```bash
# Export a solution
pac solution export --path Solutions/MySolution --name MySolution

# Check pipeline status
git push && # watch GitLab pipeline

# Create feature branch
git checkout -b feature/my-feature

# View repository structure
tree -L 2 -I '.git'
```

## Need Help? 🆘

- [Setup Guide](docs/SETUP.md) - Detailed setup instructions
- [Deployment Guide](docs/DEPLOYMENT.md) - Deployment workflows
- [Solutions README](Solutions/README.md) - Working with solutions
- [Contributing Guide](CONTRIBUTING.md) - Contribution guidelines

## Quick Tips 💭

✅ **DO:**
- Store solutions in unpacked format
- Test in DEV before production
- Use meaningful commit messages
- Follow branch naming conventions

❌ **DON'T:**
- Commit solution ZIP files
- Deploy directly to production
- Hardcode credentials
- Skip testing in lower environments

---

**Ready to dive deeper?** Check out the [full documentation](README.md)!
