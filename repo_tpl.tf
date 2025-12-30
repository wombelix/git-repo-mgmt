# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "tpl" {
  source      = "./modules/repos"
  repo_name   = "tpl"
  description = "template repo with basic configs, LICENSE and README"
}
