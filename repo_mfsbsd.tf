# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "mfsbsd" {
  source      = "./modules/repos"
  repo_name   = "mfsbsd"
  description = "Friendly fork of https://github.com/mmatuska/mfsbsd to add fixes, features and automate image builds"
}
