# https://registry.terraform.io/providers/-/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "role" {
  name = "${var.role_name}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = var.assume_role_policy
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy.html
resource "aws_iam_policy" "role" {
  name   = "${var.role_name}"
  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.role.arn
  depends_on = [ aws_iam_policy.role ]
}