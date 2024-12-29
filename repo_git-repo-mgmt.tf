# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "git-repo-mgmt" {
  source      = "./modules/repos"
  repo_name   = "git-repo-mgmt"
  description = "OpenTofu based management of my git repositories"
}
