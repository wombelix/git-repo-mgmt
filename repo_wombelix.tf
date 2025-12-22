# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "wombelix" {
  source           = "./modules/repos"
  repo_name        = "wombelix"
  description      = "Profile repository"
  primary_platform = "github"
  enable_github    = true
  enable_sourcehut = false
  enable_gitlab    = false
  enable_codeberg  = false
}
