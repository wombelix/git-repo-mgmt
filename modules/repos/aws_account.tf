# SPDX-FileCopyrightText: 2026 Dominik Wombacher <dominik@wombacher.cc>
#
# SPDX-License-Identifier: Apache-2.0

# Creates a project AWS account in the Projects OU and deploys {repo_name}-ProjectRole
# through the ProjectRole StackSet in the management account (infra-aws-org).
#
# Parking moves the account to the Suspended OU, OpenTofu deletes the stack instance before the move.
# Removing the account closes it (close_on_deletion), the stack instance is deleted first.
# The email can't be changed here, the provider would replace and close the account.
# Change it manually from the management account with
# aws account start-primary-email-update and accept-primary-email-update.

resource "aws_organizations_account" "project" {
  count    = var.enable_aws_account ? 1 : 0
  provider = aws.vending

  name              = var.repo_name
  email             = local.aws_account_email
  parent_id         = local.aws_account_parent_id
  close_on_deletion = true

  # ManagedBy is required by the AccountVendingRole policy
  tags = merge(local.aws_tags, { ManagedBy = "git-repo-mgmt" })

  lifecycle {
    ignore_changes = [email]
  }
}

resource "aws_cloudformation_stack_set_instance" "project_role" {
  count    = var.enable_aws_account && !var.aws_account_parked ? 1 : 0
  provider = aws.vending

  stack_set_name            = "ProjectRole"
  stack_set_instance_region = var.aws_region
  call_as                   = "SELF"

  deployment_targets {
    organizational_unit_ids = [var.aws_org_ou_id_projects]
    accounts                = [aws_organizations_account.project[0].id]
    account_filter_type     = "INTERSECTION"
  }

  parameter_overrides = {
    RepoName = var.repo_name
  }
}
