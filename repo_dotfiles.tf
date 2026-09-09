# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "dotfiles" {
  source      = "./modules/repos"
  repo_name   = "dotfiles"
  description = "Configs and dotfiles for things like vim or tmux with some helper scripts"

  enable_aws_iam_role                = true
  enable_aws_ssm_read_git_deploy_key = true
}
