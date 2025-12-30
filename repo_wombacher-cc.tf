# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "wombacher-cc" {
  source      = "./modules/repos"
  repo_name   = "wombacher-cc"
  description = "Website: wombacher.cc"
}
