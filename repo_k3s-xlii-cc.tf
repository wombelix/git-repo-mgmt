# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "k3s-xlii-cc" {
  source      = "./modules/repos"
  repo_name   = "k3s-xlii-cc"
  description = "Server config: k3s.xlii.cc"
  archived    = true

  enable_aws_ssh_key          = false
  enable_aws_iam_role         = false
  enable_aws_opentofu_backend = false
  enable_aws_ssm_read         = false
}

moved {
  from = module.geeko-xlii-cc
  to   = module.k3s-xlii-cc
}
