# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "ansible-molecule-container" {
  source      = "./modules/repos"
  repo_name   = "ansible-molecule-container"
  description = "Collection of Dockerfiles for Container to test Ansible Roles with Molecule"
}
