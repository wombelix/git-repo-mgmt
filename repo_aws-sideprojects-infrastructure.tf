# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "aws-sideprojects-infrastructure" {
  source      = "./modules/repos"
  repo_name   = "aws-sideprojects-infrastructure"
  description = "Infrastructure-as-Code (IaC) for my sideprojects at AWS"
}
