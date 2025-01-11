# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "sourcehut-go" {
  source      = "./modules/repos"
  repo_name   = "sourcehut-go"
  description = "A Go SDK for accessing the sourcehut legacy REST API"
}
