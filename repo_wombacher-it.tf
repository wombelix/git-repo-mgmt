# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "wombacher-it" {
  source      = "./modules/repos"
  repo_name   = "wombacher-it"
  description = "Website: wombacher.it"
}
