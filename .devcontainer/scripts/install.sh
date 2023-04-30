#!/bin/bash

set -euo pipefail  # Enable error checking

# Define an array of scripts to call
scripts=(
  "install-localstack.sh"
)

# Loop over the array of scripts and call each one
for script in "${scripts[@]}"; do
  echo "chmod +x for execute permissions..."
  chmod +x "./.devcontainer/scripts/${script}"
  echo "Running ${script}..."
  # if "./${script}"; then
  if "./.devcontainer/scripts/${script}"; then
    echo "${script} succeeded"
  else
    echo "${script} failed"
    exit 1  # Exit with error code
  fi
done

echo "All scripts completed successfully"
