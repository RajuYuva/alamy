
//IAM Users and service Users and IAM Role with policies to access resources

// IAM User
resource "aws_iam_user" "alamy_user" {
  name = "alamy-user"
}

// IAM User Policy
resource "aws_iam_user_policy" "alamy_user_policy" {
  name       = "alamy-user-policy"
  user       = aws_iam_user.alamy_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          // Aassuming only 2 as of now
        ],
        Resource  = "*",
      },
    ],
  })
}

// IAM Service Role
resource "aws_iam_role" "alamy_service_role" {
  name               = "alamy-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com", 
        },
        Action    = "sts:AssumeRole",
      },
    ],
  })
}

// IAM Role Policy
resource "aws_iam_policy" "alamy_service_role_policy" {
  name        = "alamy-service-role-policy"
  description = "alamy IAM policy for service role"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          
        ],
        Resource  = "*",
      },
    ],
  })
}

// Attach Policy to Role
resource "aws_iam_policy_attachment" "alamy_role_policy_attachment" {
  name       = "alamy-role-policy-attachment"
  roles      = [aws_iam_role.alamy_service_role.name]
  policy_arn = aws_iam_policy.alamy_service_role_policy.arn
}
