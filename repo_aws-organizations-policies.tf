# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "aws-organizations-policies" {
  source      = "./modules/repos"
  repo_name   = "aws-organizations-policies"
  description = "Copy of applied SCP and settings in my AWS Organization"
}
