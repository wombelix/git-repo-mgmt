# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "flappy-mascot" {
  source      = "./modules/repos"
  repo_name   = "flappy-mascot"
  description = "A customizable Flappy Bird clone. Flap around ANYthing you want"
}
