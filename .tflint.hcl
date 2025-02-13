# Disabling this check to prevent following rate limit error from Github to happen
# Failed to install a plugin; Failed to fetch GitHub releases:
# GET https://api.github.com/repos/terraform-linters/tflint-ruleset-aws/releases/tags/v0.23.0: 403 API rate limit exceeded for 18.158.133.208
#plugin "aws" {
#  enabled = true
#  version = "0.23.0"
#  source  = "github.com/terraform-linters/tflint-ruleset-aws"
#}
