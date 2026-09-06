# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "git-repo-mgmt" {
  source      = "./modules/repos"
  repo_name   = "git-repo-mgmt"
  description = "OpenTofu based management of my git repositories"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
