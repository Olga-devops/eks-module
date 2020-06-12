resource "aws_iam_role" "example" {
  name = "example"

assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.example.name}"
}

resource "aws_eks_node_group" "example" {
  cluster_name    = "${aws_eks_cluster.example.name}"
  node_group_name = "example"
  node_role_arn   = "${aws_iam_role.example.arn}"
  subnet_ids      = "${var.subnet_ids}"
  instance_types  = ["${var.instance_type}"]
  

  scaling_config {
    desired_size = "${var.asg_desired_capacity}"
    max_size     = "${var.asg_max_size}"
    min_size     = "${var.asg_min_size}"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    "aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy",
    "aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy",
    "aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly",
  ]
}
