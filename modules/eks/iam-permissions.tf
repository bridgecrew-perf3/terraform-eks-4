###############################################
## This is eks master node IAM roles and policies
###############################################

resource "aws_iam_role" "eks-master-role" {
  count = local.eks_count
  name  = format("%s-eks-master-iam-role", var.cluster_name)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags = merge(
    {
      "Name" = var.cluster_name
    },
    var.additional_tags
  )
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  count      = local.eks_count
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  count      = local.eks_count
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-master-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}

###############################################
## This is eks node IAM roles and policies
###############################################

resource "aws_iam_role" "eks-node-role" {
  count = local.eks_count
  name  = format("%s-eks-node-iam-role", var.cluster_name)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_iam_role_policy" "s3_readonly_policy" {
  count = local.eks_count
  name  = format("%s-eks-s3-policy", var.cluster_name)
  role  = aws_iam_role.eks-node-role[count.index].name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "ec2_fullaccess_policy" {
  count = local.eks_count
  name  = format("%s-eks-ec2-policy", var.cluster_name)
  role  = aws_iam_role.eks-node-role[count.index].name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKSWorkerNodePolicy" {
  count      = local.eks_count
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKS_CNI_Policy" {
  count      = local.eks_count
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
  count      = local.eks_count
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "eks-node" {
  count = local.eks_count
  name  = format("%s-node-instance-profile", var.cluster_name)
  role  = aws_iam_role.eks-node-role[count.index].name
  lifecycle {
    create_before_destroy = true
  }
}
