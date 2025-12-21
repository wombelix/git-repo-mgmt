# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "geeko-xlii-cc" {
  source      = "./modules/repos"
  repo_name   = "geeko-xlii-cc"
  description = "Server config: geeko.xlii.cc"
}

moved {
  from = module.earth-xlii-cc
  to   = module.geeko-xlii-cc
}
