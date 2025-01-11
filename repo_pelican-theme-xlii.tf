# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "pelican-theme-xlii" {
  source      = "./modules/repos"
  repo_name   = "pelican-theme-xlii"
  description = "Custom Pelican Theme, used for example at https://dominik.wombacher.cc, with some retro charm from back in the CRT terminal days"
}
