DevOps Candidate Homework Project: Serverless Health Check API with CI/CD
Objective:
The goal of this project is to assess your ability to build, configure, and automate the deployment
of a simple serverless application on AWS. You will create a health check endpoint that logs
requests and stores them in a database, with a CI/CD pipeline to manage deployments for both
staging and production environments.
Core Requirements:
1. Infrastructure as Code:
o All AWS infrastructure must be defined and managed using Terraform.
o [sec] Encryption Everywhere: Require that the DynamoDB table uses Server-Side
Encryption (SSE)
2. Multi-Environment Setup:
o Your Terraform configuration should support two distinct environments: staging
and prod.
o Use Terraform variables to manage differences between the environments. You
should be able to deploy a specific environment by using a .tfvars file (e.g.,
terraform apply -var-file=&quot;staging.tfvars&quot;).

3. Resource Naming Convention:
o All AWS resources you create must follow the naming convention: env-resource-
name. For example, staging-health-check-lambda or prod-requests-db.

4. AWS Resources to Create:
o DynamoDB Table: A single table to store request data (e.g., staging-requests-db).
o API Gateway: An HTTP endpoint exposing a /health route that accepts GET or
POST requests. Prevent DDoS attacks by adding throttling mechanisms
o Lambda Function: A function (preferably in Python or Node.js) triggered by the
/health endpoint (e.g., staging-health-check-function).
o IAM Role: A dedicated IAM role for the Lambda function with least-privilege
permissions to execute, write logs to CloudWatch, and write items to the
DynamoDB table. [sec] A dedicated IAM role for the deployment process. Both
roles should show sensible scoping and permission choices.

Application Logic (Lambda Function):
When the /health endpoint is invoked, the Lambda function must:
1. Log to CloudWatch: Print a log message to CloudWatch containing the incoming
request event.
2. Save to DynamoDB: Generate a unique ID, and save the request details as an item in the
DynamoDB table.
3. Respond to API Gateway: Return a 200 OK status with a JSON body like:
{ &quot;status&quot;: &quot;healthy&quot;, &quot;message&quot;: &quot;Request processed and saved.&quot; }

What to Deliver:
Please provide a link to a single public GitHub repository containing:
1. Terraform Code: All of your .tf files.
2. Lambda Source Code: The source code for your Lambda function (enough to run it -
this is not part of your evaluation you can use any hello world example from AWS).
3. CI/CD Pipeline: A fully functional CI pipeline using GitHub Actions that automates the
deployment of your Terraform code to AWS. [sec] dependency scanning for the lambda
4. README.md: A comprehensive README.md file that includes:
o Prerequisites required to run your code (e.g., variable names or secret names -
values can be in your github).
o A clear explanation of how your CI/CD pipeline works.
o Step-by-step instructions on how to trigger a deployment for the staging
environment.
o An example curl command to test the deployed /health endpoint.
o A brief explanation of your design choices or any assumptions made.

Review Process:
We will be reviewing your submission commit by commit to understand your thought process
and development workflow. Please use clear, atomic commits that tell a story.
Evaluation Criteria:
 Correctness: Does the infrastructure deploy successfully via the pipeline and function as
required?
 Automation: Does the GitHub Actions pipeline reliably deploy the infrastructure?
 Terraform Best Practices: Is the code clean, readable, and structured for multiple
environments?
 Security: Are IAM permissions correctly scoped? Are you handling secrets appropriately
in the pipeline?
 Clarity: Is the README.md clear and easy to follow? Is your commit history logical?
 [sec] IaC Security: Your CI/CD pipeline has a security scanning step before terraform
apply.
 [sec] Least Privilege: IAM roles must be scoped strictly. Wildcards (*) in IAM
permissions are prohibited (except where mandatory).
 [sec] Encryption: The DynamoDB table must have Server-Side Encryption.
 [sec] Input Validation: The Lambda function must validate that the incoming JSON body
contains a key named payload. If missing, return a 400 error
Bonus Points (Optional):
 Structure your Terraform code into reusable modules.
 Automate the packaging and versioning of the Lambda function within your pipeline.

 Add a manual approval step in your GitHub Action before deploying to the prod
environment.
 [sec] Customer Managed Key in KMS for encryption
 [sec] Lambda is in it’s own VPC
 [sec] Use API Gateway to ensure invalid requests cannot reach Lambda
 [sec] Implement authentication via API key

Good luck! We look forward to seeing your solution.
After you’re done, please share the public GitHub repository link for HR via the HR
contact email.