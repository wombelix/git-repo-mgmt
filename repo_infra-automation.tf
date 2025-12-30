# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "infra-automation" {
  source      = "./modules/repos"
  repo_name   = "infra-automation"
  description = "Infrastructure-as-Code (IaC) for 'Automation' Account / Project"
}
