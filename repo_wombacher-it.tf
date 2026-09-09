# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "wombacher-it" {
  source      = "./modules/repos"
  repo_name   = "wombacher-it"
  description = "Website: wombacher.it"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
