#!/bin/bash
set -euo pipefail

function pre-checks() {
    echo "pre-requisite checks..."

    current_user=`whoami`
    echo "Using User: $current_user"

    current_user_settings=`cat /etc/passwd | grep $current_user`
    echo "Using user settings: $current_user_settings"

    current_group_settings=`cat /etc/group | grep $current_user`
    echo "Using group settings: $current_group_settings"

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
  # python3 -m pip install --user localstack awscli-local
}

function add_alias_for_awslocal() {
  echo "Adding alias for awslocal..."
  echo "alias aws='awslocal'" >> /home/vscode/.bashrc
  source /home/vscode/.bashrc

  # echo "alias aws='awslocal'" >> ~/.bashrc
  # source ~/.bashrc

  # echo "alias aws='awslocal'" >> /root/.bashrc
  # source /root/.bashrc
}

function setup_localstack() {
  echo "Setting up localstack..."
  sudo mkdir -p /var/lib/localstack
  # sudo chmod -R 775 /var/lib/localstack
  sudo chmod -R 777 /var/lib/localstack

  # chmod +x "./.devcontainer/scripts/start-localstack.sh"
}

function start_localstack() {
    echo "Starting up localstack..."
    ./.devcontainer/scripts/start-localstack.sh
    # echo "Localstack available on https://0.0.0.0:4566 or localhost:4566"
}

main() {
    pre-checks
    install_localstack_and_awslocal
    add_alias_for_awslocal
    setup_localstack
    start_localstack
}

main