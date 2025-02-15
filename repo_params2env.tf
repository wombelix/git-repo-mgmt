# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "params2env" {
  source      = "./modules/repos"
  repo_name   = "params2env"
  description = "CLI tool to set AWS SSM Parameter Store params as environment variables."
}
