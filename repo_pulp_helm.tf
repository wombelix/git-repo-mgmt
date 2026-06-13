# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "pulp_helm" {
  source      = "./modules/repos"
  repo_name   = "pulp_helm"
  description = "Pulp 3 plugin to host helm chart repositories. IMPORTANT: Under Development"
  archived    = true
}
