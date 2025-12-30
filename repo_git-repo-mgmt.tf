# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "git-repo-mgmt" {
  source      = "./modules/repos"
  repo_name   = "git-repo-mgmt"
  description = "OpenTofu based management of my git repositories"
}
