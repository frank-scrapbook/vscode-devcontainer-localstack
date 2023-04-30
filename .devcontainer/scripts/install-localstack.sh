#!/bin/bash
#
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# https://buildkite.com/docs/pipelines/writing-build-scripts 
#
# e = exit script immediately, if any command returns a non-zero exit status
# u = exit script immediately, if an undefined variable is used
# o pipefail = ensure bash pipelines (e.g. cmd | othercmd) returns a non-zero status, 
#               if any of the commands fail, rather than returning exit status of last command in pipeline
# x = expand and print each command before executing (for debugging)
# 
set -euo pipefail

function install_python_and_pip() {
    echo "Installing Python and pip..."
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
}

function install_virtualenv() {
    echo "Installing virtualenv..."
    pip3 install virtualenv
}

function create_virtual_environment() {
    echo "Creating virtual environment..."
    virtualenv -p python3 venv
    # python3 -m venv venv
}

function activate_virtual_environment() {
    echo "Activating virtual environment..."
    source venv/bin/activate
}

function install_awscli_v2() {
  echo "Installing AWS CLI v2..."
  sudo apt-get install -y unzip
  echo "Installing AWS CLI v2..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
}

function install_localstack_and_awslocal() {
    echo "Installing LocalStack and awslocal..."
    pip3 install localstack awscli-local
}

function add_alias_for_awslocal() {
  echo "Adding alias for awslocal..."
  echo "alias aws='awslocal'" >> ~/.bashrc
  source ~/.bashrc

  # echo "alias aws='awslocal'" >> /root/.bashrc
  # source /root/.bashrc
}

# function create_fake_aws_credentials() {
#     export AWS_ACCESS_KEY_ID=fake_access_key
#     export AWS_SECRET_ACCESS_KEY=fake_secret_key
#     export AWS_DEFAULT_REGION=ap-southeast-2
#     export AWS_DEFAULT_OUTPUT=json
# }

function set_up_aws_credentials() {
  echo "Setting up AWS credentials..."
  
  # echo '[default]' > ~/.aws/credentials
  # echo 'aws_access_key_id = test' >> ~/.aws/credentials
  # echo 'aws_secret_access_key = test' >> ~/.aws/credentials
  
  mkdir -p ~/.aws
  cat > ~/.aws/credentials << EOL
[default]
aws_access_key_id=fake_access_key
aws_secret_access_key=fake_secret_key
EOL

#   mkdir -p /root/.aws
#   cat > /root/.aws/credentials << EOL
# [default]
# aws_access_key_id=fake_access_key
# aws_secret_access_key=fake_secret_key
# EOL
}

function set_up_aws_config() {
  echo "Setting up AWS configuration..."

# echo '[default]' > ~/.aws/config
# echo 'region=ap-southeast-2' >> ~/.aws/config
# echo 'output=json' >> ~/.aws/config

  cat > ~/.aws/config << EOL
[default]
region=ap-southeast-2
output=json
EOL

#     cat > /root/.aws/config << EOL
# [default]
# region=us-east-1
# output=json
# EOL
}

function adjust_localstack_folder_permissions() {
  chmod -R 775 /usr/lib/localstack
  chmod -R 775 /var/lib/localstack
}

function run_localstack() {
    # localstack start --docker
    echo "Starting localstack..."
    localstack start
}

main() {
    install_python_and_pip
    install_virtualenv
    create_virtual_environment
    activate_virtual_environment
    install_awscli_v2
    install_localstack_and_awslocal
    add_alias_for_awslocal
    # create_fake_aws_credentials
    set_up_aws_credentials
    set_up_aws_config
    adjust_localstack_folder_permissions
    run_localstack

    echo "LocalStack started. Use 'deactivate' command to stop LocalStack."
    echo "Example: aws s3 mb s3://my-bucket"
}

main