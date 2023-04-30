#!/bin/bash
set -euo pipefail

function run_localstack() {
    localstack start
}

main() {
    run_localstack
}

main