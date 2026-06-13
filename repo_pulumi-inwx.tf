# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "pulumi-inwx" {
  source      = "./modules/repos"
  repo_name   = "pulumi-inwx"
  description = "Pulumi provider for INWX that allows registration and management of domains and their domain contacts"
  archived    = true
  github_template = {
    owner      = "pulumi"
    repository = "pulumi-tf-provider-boilerplate"
  }
}
