# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "terraform-provider-sourcehut" {
  source      = "./modules/repos"
  repo_name   = "terraform-provider-sourcehut"
  description = "OpenTofu / Terraform plugin to provision and manage sourcehut (sr.ht) resources"
}
