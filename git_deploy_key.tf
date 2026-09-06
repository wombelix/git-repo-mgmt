# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

# Shared git deploy key mainly for repository mirroring.
# AWS resources only, no git actual repos are created.
# Interim solution, to be replaced by a ssh deploy key per repo later.

module "git-deploy-key" {
  source      = "./modules/repos"
  repo_name   = "_git-deploy-key"
  description = "Shared git deploy key for repository mirroring"

  enable_sourcehut = false
  enable_github    = false
  enable_gitlab    = false
  enable_codeberg  = false

  enable_aws_ssh_key = true
}
