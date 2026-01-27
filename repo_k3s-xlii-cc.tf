# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "k3s-xlii-cc" {
  source      = "./modules/repos"
  repo_name   = "k3s-xlii-cc"
  description = "Server config: k3s.xlii.cc"

  enable_aws_ssh_key          = true
  enable_aws_iam_role         = true
  enable_aws_opentofu_backend = true
  enable_aws_ssm_read         = true
}

moved {
  from = module.geeko-xlii-cc
  to   = module.k3s-xlii-cc
}
