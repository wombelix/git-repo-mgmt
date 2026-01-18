# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

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

# Private Keys - Primary Region
resource "aws_ssm_parameter" "ssh_private_key_openssh" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_private_key_openssh_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key (OpenSSH format) for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_openssh
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_private_key_pem" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_private_key_pem_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key (PEM format) for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_pem
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Public Keys - Primary Region
resource "aws_ssm_parameter" "ssh_public_key_openssh" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_public_key_openssh_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key (OpenSSH format) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_openssh)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_public_key_pem" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_public_key_pem_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key (PEM format) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_pem)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Fingerprints - Primary Region
resource "aws_ssm_parameter" "ssh_fingerprint_md5" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_fingerprint_md5_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key fingerprint (MD5) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = ephemeral.tls_private_key.ssh[0].public_key_fingerprint_md5
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_fingerprint_sha256" {
  count = var.enable_aws_ssh_key ? 1 : 0

  name             = local.ssh_fingerprint_sha256_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key fingerprint (SHA256) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = ephemeral.tls_private_key.ssh[0].public_key_fingerprint_sha256
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Private Keys - Replica Region
resource "aws_ssm_parameter" "ssh_private_key_openssh_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_private_key_openssh_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key (OpenSSH format) for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_openssh
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_private_key_pem_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_private_key_pem_path
  description      = "SSH ${var.aws_ssh_key_algorithm} private key (PEM format) for ${var.username}/${var.repo_name}"
  type             = "SecureString"
  key_id           = var.aws_kms_key_id
  value_wo         = ephemeral.tls_private_key.ssh[0].private_key_pem
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Public Keys - Replica Region
resource "aws_ssm_parameter" "ssh_public_key_openssh_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_public_key_openssh_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key (OpenSSH format) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_openssh)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_public_key_pem_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_public_key_pem_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key (PEM format) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = trimspace(ephemeral.tls_private_key.ssh[0].public_key_pem)
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}

# Fingerprints - Replica Region
resource "aws_ssm_parameter" "ssh_fingerprint_md5_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_fingerprint_md5_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key fingerprint (MD5) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = ephemeral.tls_private_key.ssh[0].public_key_fingerprint_md5
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
resource "aws_ssm_parameter" "ssh_fingerprint_sha256_replica" {
  count    = var.enable_aws_ssh_key ? 1 : 0
  provider = aws.replica

  name             = local.ssh_fingerprint_sha256_path
  description      = "SSH ${var.aws_ssh_key_algorithm} public key fingerprint (SHA256) for ${var.username}/${var.repo_name}"
  type             = "String"
  value_wo         = ephemeral.tls_private_key.ssh[0].public_key_fingerprint_sha256
  value_wo_version = var.aws_ssh_key_version

  tags = local.aws_tags
}
