# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "tools" {
  source      = "./modules/repos"
  repo_name   = "tools"
  description = "scripts and small tools to automate the boring stuff"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
