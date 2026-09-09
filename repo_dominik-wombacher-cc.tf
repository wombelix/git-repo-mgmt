# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "dominik-wombacher-cc" {
  source      = "./modules/repos"
  repo_name   = "dominik-wombacher-cc"
  description = "Website: dominik.wombacher.cc, The Wombelix Post"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
