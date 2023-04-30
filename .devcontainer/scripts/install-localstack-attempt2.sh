#!/bin/bash
set -euo pipefail

function pre-checks() {
    echo "pre-requisite checks..."

    # os_arch=`uname -a`
    os_arch=`uname -sm`
    echo "Using OS: $os_arch"

    python_location=`which python`
    python_version=`python --version`
    echo "Using Python Version: $python_version, located at: $python_location"

    pip_location=`which pip`
    pip_version=`pip --version`
    echo "Using Pip Version: $pip_version, located at: $pip_location"

    aws_location=`which aws`
    aws_version=`aws --version`
    echo "Using AWS Version: $aws_version, located at: $aws_location"

    docker_location=`which docker`
    docker_version=`docker --version`
    echo "Using docker(dind) Version: $docker_version, located at: $docker_location"
    docker_info=`docker info`
    echo "Docker Info: $docker_info"
}

function install_localstack_and_awslocal() {
  echo "Installing LocalStack and awslocal..."
  python3 -m pip install localstack awscli-local
}

function add_alias_for_awslocal() {
  echo "Adding alias for awslocal..."
  echo "alias aws='awslocal'" >> ~/.bashrc
  # source ~/.bashrc

  # echo "alias aws='awslocal'" >> /root/.bashrc
  # source /root/.bashrc
}

function start_localstack() {
    # chmod +x "./.devcontainer/scripts/start-localstack.sh"
    echo "Starting up localstack..."
    ./.devcontainer/scripts/start-localstack.sh
}

main() {
    pre-checks
    install_localstack_and_awslocal
    add_alias_for_awslocal
    start_localstack
}

main