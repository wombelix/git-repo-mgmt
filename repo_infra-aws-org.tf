# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "infra-aws-org" {
  source      = "./modules/repos"
  repo_name   = "infra-aws-org"
  description = "AWS Organizations Policies, RCP, SCP and StackSets"
}
