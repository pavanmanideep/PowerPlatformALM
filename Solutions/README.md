# Power Platform Solutions

This directory contains Power Platform solutions that will be deployed via GitLab CI/CD.

## Directory Structure

Each solution should be placed in its own subdirectory within the `Solutions` folder:

```
Solutions/
├── SolutionName1/
│   ├── Other/
│   ├── PluginAssemblies/
│   ├── WebResources/
│   ├── Workflows/
│   └── Solution.xml
├── SolutionName2/
│   └── ...
└── README.md (this file)
```

## Adding a New Solution

### Option 1: Export Unpacked Solution (Recommended)

1. Use the Power Platform CLI to export your solution in unpacked format:
   ```bash
   pac solution export --path Solutions/YourSolutionName --name YourSolutionName --managed false
   ```

2. Commit the exported files to the repository:
   ```bash
   git add Solutions/YourSolutionName
   git commit -m "Add YourSolutionName solution"
   git push
   ```

### Option 2: Manual Export

1. Export your solution from Power Platform as an unmanaged solution
2. Extract the solution files to a directory under `Solutions/`
3. Commit the files to the repository

## Solution Format

Solutions should be stored in **unpacked/source control format** rather than as ZIP files. This allows for:
- Better version control and change tracking
- Easier code reviews
- Merge conflict resolution
- Component-level visibility

## Deploying Solutions

Solutions are automatically deployed via GitLab CI/CD pipeline when:
- Code is pushed to the `develop` branch (deploys to DEV)
- Code is merged to the `main` branch (deploys to TEST/PROD)

See the root README.md for more details on the deployment process.

## Best Practices

1. **Use solution layers**: Organize solutions by functionality
2. **Follow naming conventions**: Use consistent prefixes for all components
3. **Document dependencies**: Note any dependencies between solutions
4. **Version control**: Update solution version numbers appropriately
5. **Test locally**: Always test solutions in a development environment first
