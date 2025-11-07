#!/bin/bash
# Script to export a Power Platform solution
# Usage: ./export-solution.sh <solution-name> <environment-url>

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <solution-name> <environment-url>"
    echo "Example: $0 MySolution https://myorg.crm.dynamics.com"
    exit 1
fi

SOLUTION_NAME=$1
ENVIRONMENT_URL=$2
OUTPUT_PATH="Solutions/$SOLUTION_NAME"

echo "=========================================="
echo "Power Platform Solution Export"
echo "=========================================="
echo "Solution Name: $SOLUTION_NAME"
echo "Environment: $ENVIRONMENT_URL"
echo "Output Path: $OUTPUT_PATH"
echo "=========================================="

# Check if pac CLI is installed
if ! command -v pac &> /dev/null; then
    echo "Error: Power Platform CLI (pac) is not installed"
    echo "Install from: https://aka.ms/PowerPlatformCLI"
    exit 1
fi

# Authenticate to environment
echo "Authenticating to environment..."
pac auth create --url "$ENVIRONMENT_URL"

# Export solution in unpacked format
echo "Exporting solution..."

# Check if directory exists and prompt user
if [ -d "$OUTPUT_PATH" ]; then
    echo "Warning: Directory $OUTPUT_PATH already exists."
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Export cancelled."
        exit 0
    fi
    pac solution export --path "$OUTPUT_PATH" --name "$SOLUTION_NAME" --managed false --overwrite
else
    pac solution export --path "$OUTPUT_PATH" --name "$SOLUTION_NAME" --managed false
fi

echo "=========================================="
echo "Export completed successfully!"
echo "Solution exported to: $OUTPUT_PATH"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Review the exported files"
echo "2. Commit changes: git add $OUTPUT_PATH"
echo "3. Push to repository: git commit -m 'Update $SOLUTION_NAME' && git push"
