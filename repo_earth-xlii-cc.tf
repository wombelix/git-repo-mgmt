# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "earth-xlii-cc" {
  source      = "./modules/repos"
  repo_name   = "earth-xlii-cc"
  description = "Server configuration: earth.xlii.cc"
}
