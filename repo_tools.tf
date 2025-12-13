# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "tools" {
  source      = "./modules/repos"
  repo_name   = "tools"
  description = "scripts and small tools to automate the boring stuff"
}
