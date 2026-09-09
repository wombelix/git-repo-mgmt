# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "terraform-provider-sourcehut" {
  source      = "./modules/repos"
  repo_name   = "terraform-provider-sourcehut"
  description = "OpenTofu / Terraform plugin to provision and manage sourcehut (sr.ht) resources"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
