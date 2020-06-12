#data "aws_eks_cluster" "cluster" {
#  name = module.my-cluster.cluster_id
#}

resource "aws_iam_role" "example-main" {
  name = "eks-cluster-example"

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
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.example-main.name}"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.example-main.name}"
}  

resource "aws_eks_cluster" "example" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.example-main.arn}"
  version = "${var.cluster_version}"

  vpc_config {
    subnet_ids = "${var.subnet_ids}"
    security_group_ids = "${var.security_group_ids}"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    "aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy",
  ]
}



output "endpoint" {
  value = "${aws_eks_cluster.example.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.example.certificate_authority.0.data}"
}

output "cluster_name" {
  value = "${var.cluster_name}"
}

output "region" {
  value = "${var.region}"
}
