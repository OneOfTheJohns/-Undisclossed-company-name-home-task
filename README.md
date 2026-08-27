# How to use
0) Configure backend.tf at account.hcl
1) Update variables in terragrunt/eu-north-1/production/deployment-role/terragrunt.hcl 
2) terragrunt apply ./terragrunt/eu-north-1/production/deployment-role.
3) terragrunt apply ./terragrunt/eu-north-1/production/github_IdP
4) Set the AWS_ASSUME_ROLE_ARN secret in your github repo.
5) Run the plan pipelines and then deploy pipelines
6) Try running `curl -i -X POST https://<YOUR_URL_FROM_OUTPUT>/health -H 'Content-Type: application/json' -d '{"status":"healthy","message":"test"}'`

**All the same steps could be done for "staging" env. The only difference is the passed variable values.**

# Explanation
We initially deploy deployment roles using initial creds and configure github as IdP, which are then used to deploy all other resources.
Those IAM roles have minimum permissions to just be able to deploy the resources.
We deploy APIGW, lambda, lambda role, dynamodb table. Upon POST or GET request against APIGW LAMBDA function is invoked, which uploads some logs (from stdout) into cloudwatch and uploads some data from the caught request into dynamodb table and then answers to APIGW request with hardcoded answer.

# Feedback
Can it be better? -> yes
Is there more stuff to be implemented for better monitoring, alerting, security, compliance and so on? -> yes
Like building of the image trough the pipelines, pushing those into ECR, API key check and so on... Alerting on lambda errors, lambda usage tresholds and so on...
But it works, and i think i have done everything (hopefully) :0

Nothing hard, but took quite some time to write, test, deploy. First of all, because my brain was already not braining after the initial 9-5 job (because i had to do that project on evenings), as well as no-one have removed family,friends,pets,health and so on, fun things that take your time as well troughout the day. So from the limited available time, and 3 days for creation, i think i did good.
So hopefully this pays out, but at the same time, i did learn some stuff (github actions part mostly) anyway, and +1 project for my protfolio.