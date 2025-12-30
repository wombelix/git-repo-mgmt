# SPDX-FileCopyrightText: 2025 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "aws-neuron-driver" {
  source      = "./modules/repos"
  repo_name   = "aws-neuron-driver"
  description = "GPL-2.0 source code of the AWS Neuron Driver, a Linux kernel device driver supporting the AWS Neuron SDK"
}
