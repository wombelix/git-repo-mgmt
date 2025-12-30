# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "hyperskill-go-game-of-life" {
  source      = "./modules/repos"
  repo_name   = "hyperskill-go-game-of-life"
  description = "My solution of Hyperskill Project Game of Life (Go)"
  archived    = true
}
