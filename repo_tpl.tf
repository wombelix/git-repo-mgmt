# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "tpl" {
  source      = "./modules/repos"
  repo_name   = "tpl"
  description = "template repo with basic configs, LICENSE and README"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
