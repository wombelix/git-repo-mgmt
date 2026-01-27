# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "geeko-xlii-cc" {
  source      = "./modules/repos"
  repo_name   = "geeko-xlii-cc"
  description = "Server config: geeko.xlii.cc"

  enable_aws_ssh_key          = true
  enable_aws_iam_role         = true
  enable_aws_opentofu_backend = true
  enable_aws_ssm_read         = true
}

moved {
  from = module.earth-xlii-cc
  to   = module.geeko-xlii-cc
}
