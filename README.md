1) First shift. Start of work -> Aug 24 18:00
-   Avoiding usage of AI (for sportsmanship and because i want to code myself at least a bit, have not done that for a while.)
-   Avoiding open source terraform module usage (yes, re-creating the wheel, but the same reason as above)
-   Had to recover personal AWS account to test everything out (in future)
2) Second shift. Start of work -> Aug 26 20:03

3) Third shift, Start of work -> Aug 27 18:40

# Prerequisities
1) terragrunt apply ./terragrunt/eu-north-1/production/deployment-role
2) terragrunt apply ./terragrunt/eu-north-1/production/github_IdP
3) Set the AWS_ASSUME_ROLE_ARN secret in your github repo.
4) 