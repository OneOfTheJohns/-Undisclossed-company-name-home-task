# https://registry.terraform.io/providers/-/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "role" {
  name = "${var.role_name}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
            AWS = "arn:aws:iam::${var.account_id}:user/${var.user_name}"
        },
      },
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy.html
resource "aws_iam_policy" "role" {
  name   = "${var.role_name}-policy"
  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.role.arn
  depends_on = [ aws_iam_policy.role ]
}