<!--
SPDX-FileCopyrightText: 2024 Dominik Wombacher <dominik@wombacher.cc>

SPDX-License-Identifier: CC0-1.0
-->

# Git repository management

OpenTofu based management of my git repositories at Sourcehut
with mirrors at Codeberg, Gitlab and GitHub.

[![REUSE status](https://api.reuse.software/badge/git.sr.ht/~wombelix/git-repo-mgmt)](https://api.reuse.software/info/git.sr.ht/~wombelix/git-repo-mgmt)
[![builds.sr.ht status](https://builds.sr.ht/~wombelix/git-repo-mgmt.svg)](https://builds.sr.ht/~wombelix/git-repo-mgmt?)

## Table of Contents

* [Usage](#usage)
* [Source](#source)
* [Contribute](#contribute)
* [License](#license)

## Usage

To interact with AWS (S3 Backend and KMS encryption) and the various git forges,
the following Environment variables have to be set:

```
AWS_REGION
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
GITEA_BASE_URL
GITEA_TOKEN
GITLAB_TOKEN
GITHUB_TOKEN
SRHT_TOKEN
TF_VAR_aws_region
TF_VAR_aws_account_id
TF_VAR_aws_kms_name
TF_VAR_aws_s3_bucket
TF_VAR_project
```

By default, Sourcehut is used as the primary repository with mirrors on
Codeberg, Gitlab and GitHub. To use a different platform as primary
(e.g., GitHub for GitHub Actions), set the `primary_platform` variable:

```hcl
module "my-github-repo" {
  source           = "./modules/repos"
  repo_name        = "my-project"
  description      = "My project description"
  primary_platform = "github"
}
```

Supported primary platforms: `sourcehut` (default), `github`, `gitlab`, `codeberg`.

To archive a repository, set the `archived` parameter:

```hcl
module "archived-repo" {
  source      = "./modules/repos"
  repo_name   = "old-project"
  description = "Legacy project no longer maintained"
  archived    = true
}
```

Archived repositories are read-only on GitHub, GitLab and Codeberg.
Sourcehut doesn't support archiving, so an `[ARCHIVED]` prefix is added
to the description on all platforms.

To managed already existing repositories, use
`tofu import module.<modulename>.<resource>.sourcehut <resourcename>`, example:
`tofu import module.tmp-opentofu-test-repo.sourcehut_repository.sourcehut tmp-opentofu-test-repo`

## Source

The primary location is:
[git.sr.ht/~wombelix/git-repo-mgmt](https://git.sr.ht/~wombelix/git-repo-mgmt)

Mirrors are available on
[Codeberg](https://codeberg.org/wombelix/git-repo-mgmt),
[Gitlab](https://gitlab.com/wombelix/git-repo-mgmt)
and
[GitHub](https://github.com/wombelix/git-repo-mgmt).

## Contribute

Please don't hesitate to provide Feedback,
open an Issue or create a Pull / Merge Request.

Just pick the workflow or platform you prefer and are most comfortable with.

Feedback, bug reports or patches to my sr.ht list
[~wombelix/inbox@lists.sr.ht](https://lists.sr.ht/~wombelix/inbox) or via
[Email and Instant Messaging](https://dominik.wombacher.cc/pages/contact.html)
are also always welcome.

## License

Unless otherwise stated: `MIT`

All files contain license information either as
`header comment` or `corresponding .license` file.

[REUSE](https://reuse.software) from the [FSFE](https://fsfe.org/)
implemented to verify license and copyright compliance.
