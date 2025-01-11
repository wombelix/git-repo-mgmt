# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "moinmoin-pypy2-container" {
  source      = "./modules/repos"
  repo_name   = "moinmoin-pypy2-container"
  description = "Ready to use MoinMoin Wiki Container Image powered by pypy2, uswgi, nginx and openSUSE Leap"
}
