# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "params2env" {
  source      = "./modules/repos"
  repo_name   = "params2env"
  description = "CLI tool to set AWS SSM Parameter Store params as environment variables."

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
