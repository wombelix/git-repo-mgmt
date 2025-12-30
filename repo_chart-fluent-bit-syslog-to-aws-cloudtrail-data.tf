# SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "chart-fluent-bit-syslog-to-aws-cloudtrail-data" {
  source      = "./modules/repos"
  repo_name   = "chart-fluent-bit-syslog-to-aws-cloudtrail-data"
  description = "Helm Chart to receive Syslog events and push to AWS Cloudtrail Data via Fluent Bit"
}
