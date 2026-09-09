# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "infra-automation" {
  source      = "./modules/repos"
  repo_name   = "infra-automation"
  description = "Infrastructure-as-Code (IaC) for 'Automation' Account / Project"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
