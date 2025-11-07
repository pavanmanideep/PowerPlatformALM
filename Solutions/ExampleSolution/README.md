# Example Solution

This is a placeholder directory for a Power Platform solution.

## Getting Started

Replace this directory with your actual Power Platform solution files.

To export your solution here:

```bash
pac solution export --path Solutions/ExampleSolution --name YourSolutionName --managed false
```

Or manually place your unpacked solution files in this directory.

## Solution Components

Your solution directory should contain:
- `Solution.xml` - Solution manifest
- `Other/` - Solution metadata
- `PluginAssemblies/` - Custom plugins (if any)
- `WebResources/` - Web resources (HTML, CSS, JS, images)
- `Workflows/` - Workflow definitions
- And other component folders as needed

## Deployment

This solution will be deployed automatically through the GitLab CI/CD pipeline when changes are pushed to the repository.
