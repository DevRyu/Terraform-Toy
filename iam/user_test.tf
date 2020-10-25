resource "aws_iam_user" "test_user" {
    name = "test.user"
} 
resource "aws_iam_user_policy" "super-user-policy" {
  name  = "super-admin"
  user  = aws_iam_user.test_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
