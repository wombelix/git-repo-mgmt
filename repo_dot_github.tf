# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "dot_github" {
  source           = "./modules/repos"
  repo_name        = ".github"
  description      = "wombelix"
  primary_platform = "github"
  enable_github    = true
  enable_sourcehut = false
  enable_gitlab    = false
  enable_codeberg  = false
}
