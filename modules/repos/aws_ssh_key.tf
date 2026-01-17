# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

# Ephemeral SSH Key Generation
#
# Generates an SSH key pair using OpenTofu ephemeral resources.
# The keys are stored in SSM Parameter Store in both primary and replica regions
# using write-only attributes, ensuring they are never visible in plans or state files.
#
# Supported algorithms:
# - ED25519 (default, recommended)
# - RSA (4096 bits, for legacy compatibility)

ephemeral "tls_private_key" "ssh" {
  count = var.enable_aws_ssh_key ? 1 : 0

  algorithm = var.aws_ssh_key_algorithm
  rsa_bits  = var.aws_ssh_key_algorithm == "RSA" ? 4096 : null
}

# =============================================================================
# Primary Region
# =============================================================================

# Public Key - Primary Region
# Even though public keys are not sensitive, ephemeral values can only be
# referenced by write-only attributes, so we must use value_wo here.
resource "aws_ssm_parameter" "ssh_public_key" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_key_public_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_openssh)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Private Key - Primary Region
resource "aws_ssm_parameter" "ssh_private_key" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_key_private_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_openssh
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# =============================================================================
# Replica Region
# =============================================================================

# Public Key - Replica Region
resource "aws_ssm_parameter" "ssh_public_key_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_key_public_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_openssh)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Private Key - Replica Region
resource "aws_ssm_parameter" "ssh_private_key_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_key_private_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_openssh
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
