# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "dotfiles" {
  source      = "./modules/repos"
  repo_name   = "dotfiles"
  description = "Configs and dotfiles for things like vim or tmux with some helper scripts"
}
