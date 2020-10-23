resource "aws_iam_group" "test_group" {
    name = "test.group"
} 

resource "aws_iam_group_membership" "test_group" {
    name = aws_iam_group.test_group.name
    users =  [
    aws_iam_user.test_user.name
]
    group = aws_iam_group.test_group.name
}