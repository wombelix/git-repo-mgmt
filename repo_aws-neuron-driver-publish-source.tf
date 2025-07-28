# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "aws-neuron-driver-publish-source" {
  source      = "./modules/repos"
  repo_name   = "aws-neuron-driver-publish-source"
  description = "CLI tool to publish the source code of new AWS Neuron Driver releases"
}
