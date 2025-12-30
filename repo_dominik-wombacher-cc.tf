# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "dominik-wombacher-cc" {
  source      = "./modules/repos"
  repo_name   = "dominik-wombacher-cc"
  description = "Website: dominik.wombacher.cc, The Wombelix Post"
}
