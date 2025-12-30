# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "flappy-mascot" {
  source      = "./modules/repos"
  repo_name   = "flappy-mascot"
  description = "A customizable Flappy Bird clone. Flap around ANYthing you want"
}
