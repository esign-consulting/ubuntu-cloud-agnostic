# ubuntu-cloud-agnostic

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Create and destroy an Ubuntu 16.04 LTS instance in any Cloud provider.

Just run `$ ./terraform.sh aws|azure|google create|destroy`.

## Requirements

* [Terraform](https://www.terraform.io) installed.
* [AWS CLI](https://aws.amazon.com/cli) installed and credentials configured through the command `$ aws configure`.
* [Azure CLI](https://docs.microsoft.com/pt-br/cli/azure/overview) installed and credentials provided through the command `$ az login`.