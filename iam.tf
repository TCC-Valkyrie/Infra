# Role da instância Python/ML: leitura do bucket "Modelos" e leitura/escrita no "Client"
resource "aws_iam_role" "python_ec2" {
  name = "${var.project_name}-python-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "python_ec2_s3" {
  name = "${var.project_name}-python-ec2-s3-policy"
  role = aws_iam_role.python_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = [
          aws_s3_bucket.modelos.arn,
          "${aws_s3_bucket.modelos.arn}/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
        Resource = [
          aws_s3_bucket.client.arn,
          "${aws_s3_bucket.client.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "python_ec2" {
  name = "${var.project_name}-python-ec2-profile"
  role = aws_iam_role.python_ec2.name
}

# Role da instância Java/Angular: leitura/escrita nos buckets "Trusted" e "Raw"
resource "aws_iam_role" "java_ec2" {
  name = "${var.project_name}-java-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "java_ec2_s3" {
  name = "${var.project_name}-java-ec2-s3-policy"
  role = aws_iam_role.java_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
      Resource = [
        aws_s3_bucket.trusted.arn,
        "${aws_s3_bucket.trusted.arn}/*",
        aws_s3_bucket.raw.arn,
        "${aws_s3_bucket.raw.arn}/*"
      ]
    }]
  })
}

resource "aws_iam_instance_profile" "java_ec2" {
  name = "${var.project_name}-java-ec2-profile"
  role = aws_iam_role.java_ec2.name
}