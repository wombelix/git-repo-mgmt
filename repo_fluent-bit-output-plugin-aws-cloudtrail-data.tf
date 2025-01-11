# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: MIT

module "fluent-bit-output-plugin-aws-cloudtrail-data" {
  source      = "./modules/repos"
  repo_name   = "fluent-bit-output-plugin-aws-cloudtrail-data"
  description = "Fluent Bit: Output Plugin for AWS CloudTrail Data Service to ingest events into AWS CloudTrail Lake"
}
