# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "infra-automation" {
  source      = "./modules/repos"
  repo_name   = "infra-automation"
  description = "Infrastructure-as-Code (IaC) for 'Automation' Account / Project"
}
