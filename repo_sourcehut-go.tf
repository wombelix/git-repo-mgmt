# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "sourcehut-go" {
  source      = "./modules/repos"
  repo_name   = "sourcehut-go"
  description = "A Go SDK for accessing the sourcehut legacy REST API"
  archived    = true
}
