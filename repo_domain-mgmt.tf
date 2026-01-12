# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "domain-mgmt" {
  source      = "./modules/repos"
  repo_name   = "domain-mgmt"
  description = "OpenTofu based management of my domain names"

  enable_aws_iam_role         = true
  enable_aws_opentofu_backend = true
  enable_aws_ssm_read         = true
}
