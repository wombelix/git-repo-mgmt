# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "jDeepL" {
  source      = "./modules/repos"
  repo_name   = "jDeepL"
  description = "Unofficial DeepL App for Linux based on JavaFX"
}
