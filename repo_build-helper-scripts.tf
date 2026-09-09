# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "build-helper-scripts" {
  source      = "./modules/repos"
  repo_name   = "build-helper-scripts"
  description = "Helper scripts and functions for usage in pipelines"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
