# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

module "k8s-mgmt" {
  source      = "./modules/repos"
  repo_name   = "k8s-mgmt"
  description = "Bootstrap and Management of my k8s clusters"

  # Enable SSH key generation
  enable_aws_ssh_key    = true
  aws_ssh_key_algorithm = "ED25519"
  aws_ssh_key_version   = 1

  enable_aws_iam_role                = true
  enable_aws_ssm_read                = true
  enable_aws_ssm_read_git_deploy_key = true
}
