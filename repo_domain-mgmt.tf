# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "domain-mgmt" {
  source      = "./modules/repos"
  repo_name   = "domain-mgmt"
  description = "OpenTofu based management of my domain names"
}
