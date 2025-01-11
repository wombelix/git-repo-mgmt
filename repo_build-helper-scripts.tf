# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "build-helper-scripts" {
  source      = "./modules/repos"
  repo_name   = "build-helper-scripts"
  description = "Helper scripts and functions for usage in pipelines"
}
