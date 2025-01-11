# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "cfn-custom-resource-aws-ssm-securestring" {
  source      = "./modules/repos"
  repo_name   = "cfn-custom-resource-aws-ssm-securestring"
  description = "A custom resource for CloudFormation to interact with SecureString values from AWS SSM Parameter Store"
}
