# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "hyperskill-go-flashcards" {
  source      = "./modules/repos"
  repo_name   = "hyperskill-go-flashcards"
  description = "My solution of Hyperskill Project Flashcards (Go)"
  archived    = true
}
